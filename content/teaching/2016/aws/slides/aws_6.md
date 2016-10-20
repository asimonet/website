---
title: Amazon Web Services − Python development with Boto
theme: amazon
---

{::options parse_block_html="true" /}

<section>
# Amazon Web Services

<img class="clean" src="../../img/aws_logo.png" />

## Python development with Boto
</section>

<section>
# Outline

- Introduction & Installation
- General concepts
- Zoom on EC2 and ELB
</section>

<section>
<section>
# Introduction & Installation
</section>

<section>
# History

- A Python library for AWS
- Official support from AWS
- Python 2.6+ and Python 3
  - APIs are quite different!

</section>

<section>
# Installation

1. `pip install  boto3`  
**or**
2. `apt-get install python-boto`

</section>

<section>
# General principles

All supported services are accessed with a specific client.

2 types of clients:

- High-level (EC2, S3, SQS, DynamoDB, …)  

~~~~~~~~~~
ec2 = boto3.resource('ec2',
    aws_access_key_id='<access>',
    aws_secret_access_key='<secret>',
    region_name='<region>')
~~~~~~~~~~
{: .language-python}

- Low-level services (ELB, EMR, CloudFront, …)

~~~~~~~~~~
elb = boto3.client('elb',
    aws_access_key_id='<access>',
    aws_secret_access_key='<secret>',
    region_name='<region>')
~~~~~~~~~~
{: .language-python}

</section>

<section>
# Model

The developper manipulates object that represent AWS entities

- `Instance`, `SecurityGroup`, `Bucket`…
- To instantiate them:  
`instance = ec2.Instance('<instance-id>')`
- To refresh the state of an object:  
`instance.update()`

<http://boto3.readthedocs.io/>
</section>
</section>

<section>
<section>
# EC2
</section>

<section>
# Run instances

Run instances:

~~~~~~~~~~
instances = ec2.create_instances( \
        ImageId='<ami id>', \
        KeyName='<key-pair name>', \
        InstanceType='<instance-type>', \
        SecurityGroupIds=['<sec-group-id>', '<sec-group-id>'], \
        MinCount=<n-instances>, MaxCount=<n-instances>, \
        UserData='<user-data string>')
~~~~~~~~~~
{: .language-python}

Wait for an instance to be `running`:

~~~~~~~~~~
instances[0].wait_until_running()
~~~~~~~~~~
{: .language-python}

</section>

<section>
# Instances

Common operations:

- `.start()`
- `.stop()`
- `.terminate()`
- `.reboot()`
- `.add_tag()`/`.remove_tag()`
- `.update()`
</section>

<section>
# Reservations

A collection of instances resulting from a single `run_instances()` call

- `.stop_all()`

Get instances with a filter:

~~~~~~~~~~
ec2.describe_instances(Filters=[
	{
		'Name': 'tag:Name',
		'Values': ['<name>']
	}
])
~~~~~~~~~~
{: .language-python}
</section>
</section>

<section>
<section>
# ELB
</section>

<section>
# Create a load balancer

Create a load balancer:

~~~~~~~~~~
listener = {
        'Protocol': 'HTTP',
        'LoadBalancerPort': <frontend port>,
        'InstancePort': <backend port>
}

my_elb = elb.create_load_balancer(LoadBalancerName=<name>, \
    AvailabilityZones=['<zone-1>', '<zone-2>'], \
    Listeners=[listener])
~~~~~~~~~~
{: .language-python}

Get existing load balancers:

~~~~~~~~~~
elb.describe_load_balancers()
~~~~~~~~~~
{: .language-python}
</section>

<section>
# Set the Health Check

~~~~~~~~~~
elb.configure_health_check(LoadBalancerName=ELB_NAME, \
    HealthCheck={
        'Target':             'HTTP:80/health',
        'Interval':           10,
        'Timeout':            5,
        'UnhealthyThreshold': 2,
        'HealthyThreshold':   3
    }
)
~~~~~~~~~~
{: .language-python}
</section>

<section>
# Register an instance

Register an instance to the load balancer:

~~~~~~~~~~
elb.register_instances_with_load_balancer(LoadBalancerName='<load balancer name>', \
    Instances=['<instance id>'])
~~~~~~~~~~
{: .language-python}

Deregister the instance:

~~~~~~~~~~
elb.deregister_instances_from_load_balancer(LoadBalancerName='<load balancer name>', \
    Instances=['<instance id>'])
~~~~~~~~~~
{: .language-python}
</section>

<section>
# Manipulate availability zones

Enable an availability zone:

~~~~~~~~~~
elb.enable_availability_zones_for_load_balancer( \
    LoadBalancerName='<load balancer name>', \
    AvailabilityZones=['<zone>'])
~~~~~~~~~~
{: .language-python}

Disable an availability zone:

~~~~~~~~~~
elb.disable_availability_zones_for_load_balancer( \
    LoadBalancerName='<load balancer name>', \
    AvailabilityZones=['<zone>'])
~~~~~~~~~~
{: .language-python}

</section>
</section>
