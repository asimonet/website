#! /usr/bin/env python

import sys, time
import base64
import boto3

# Change this
ACCESS_KEY = 'AKIAJOU44VXHUUISJRUQ'
SECRET_KEY = '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'
KEYPAIR = 'test'
ELB_NAME = 'elb-simonet'

# Do not change this
N_INSTANCES=3
REGION_NAME = 'eu-west-1'

AMI_ID = 'ami-d41d58a7'
INSTANCE_TYPE = 't2.micro'
SEC_GROUP = 'sg-bf9f69d9'

# Connect to EC2
ec2 = boto3.resource('ec2',
        aws_access_key_id=ACCESS_KEY,
        aws_secret_access_key=SECRET_KEY,
        region_name=REGION_NAME)

with open("cloud-init.txt", "r") as f:
    encoded_string = base64.b64encode(f.read())

# Create the instances
instances = ec2.create_instances( \
        ImageId=AMI_ID, \
        KeyName=KEYPAIR, \
        InstanceType=INSTANCE_TYPE, \
        SecurityGroupIds=[SEC_GROUP], \
        MinCount=N_INSTANCES, MaxCount=N_INSTANCES, \
        UserData=encoded_string \
)

# Wait for all the instances to be 'running'
for instance in instances:
    instance.wait_until_running()
    print("New instance: " + instance.instance_id)

# Get the ELB Client
elb = boto3.client('elb',
        aws_access_key_id=ACCESS_KEY,
        aws_secret_access_key=SECRET_KEY,
        region_name=REGION_NAME)

elb_dns = None
try:
    result = elb.describe_load_balancers(LoadBalancerNames=[ELB_NAME])

    # Try to get an existing ELB
    for tmp in result['LoadBalancerDescriptions']:
        if tmp['LoadBalancerName'] == ELB_NAME:
            elb_dns = tmp['DNSName']
            print("Using an existing ELB with DNS: %s" % elb_dns)
except Exception:
    pass # This ELB does not exist

# Otherwise make a new one
if elb_dns is None:
    listener = {
        'Protocol': 'HTTP',
        'LoadBalancerPort': 80,
        'InstancePort': 80
    }
    
    my_elb = elb.create_load_balancer(LoadBalancerName=ELB_NAME, \
            AvailabilityZones=['eu-west-1a', 'eu-west-1b', 'eu-west-1c'], \
            Listeners=[listener])
    
    elb_dns = my_elb['DNSName']
    print("Created an ELB with DNS: %s" % elb_dns)

# Set the health check
elb.configure_health_check(LoadBalancerName=ELB_NAME, \
        HealthCheck={
            'Target':             'HTTP:80/health.php',
            'Interval':           10,
            'Timeout':            5,
            'UnhealthyThreshold': 2,
            'HealthyThreshold':   3
        }
)

# Add the instances to the ELB
result = elb.register_instances_with_load_balancer(LoadBalancerName=ELB_NAME, \
        Instances=[{'InstanceId': i.instance_id} for i in instances])

try:
    while True:
        result = elb.describe_instance_health(LoadBalancerName=ELB_NAME, \
                Instances=[{'InstanceId': i.instance_id} for i in instances])
        
        n_healthy = 0
        n_unhealthy = 0
        
        for instance in result['InstanceStates']:
            if instance['State'] == 'InService':
                n_healthy += 1
            else:
                n_unhealthy += 1
        
        print("\rELB state (healthy/unhealthy/total): %d/%d/%d" % \
                (n_healthy, n_unhealthy, len(instances)))
        
        time.sleep(20)
except KeyboardInterrupt:
    print("\nDone")
    
