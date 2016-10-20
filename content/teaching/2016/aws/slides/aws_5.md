---
title: Amazon Web Services − Java SDK
theme: amazon
---

{::options parse_block_html="true" /}

<section>
# Amazon Web Services

<img class="clean" src="../../img/aws_logo.png" />

## Java SDK
</section>

<section>
# Outline

- Introduction & Installation
- General concepts
- Zoom on EC2, S3 and ELB
- Alternatives
</section>

<section>
<section>
# Introduction & Installation
</section>

<section>
# History

- Java API
- Integrated with Eclipse
- Supports
  - EC2 (auto-scaling, ELB, CloudWatch)
  - S3, Glacier, DataPipeline, EMR
  - CloudFront, CloudSearch
  - RDS, DynamoDB
  - SQS, SNS, SES
  - Route53, ElasticBeanstalk
</section>

<section>
# Installation

- SDK for Eclipse:
  - Add the AWS channel: <http://aws.amazon.com/eclipse>
- AWS SDK for Java:
  - Download the binaries:
	 <https://sdk-for-java.amazonwebservices.com/latest/aws-java-sdk.zip>
  - Put `aws-java-sdk-x.y/lib/aws-java-sdk-x.y.jar` in your `CLASSPATH`
</section>
</section>

<section>

<section>
# Documentation

- Detailed installation instruction:  
<http://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-install.html>

- API reference:  
<http://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/index.html>
</section>

<section>
# General concepts
</section>

<section>
# Principles

- Main package: `com.amazonaws`
  - Authentication: `com.amazonaws.auth`
  - Services: `com.amazonaws.services.<service>`
- Each connection to a service has its own interface (_e.g._ AmazonEC2)
  - `AmazonXXXClient`: synchronous interface
  - `AmazonXXXClientAsync`: asynchronous interface
</section>

<section>
# Credentials

- Interface `com.amazonaws.auth.AWSCredentials`
- Implementations:
  - `BasicAWSCredentials(String accessKey, String secretKey)`
  - `PropertiesCredentials(File file)`
</section>

<section>
# Credentials Providers

- Interface `com.amazonaws.auth.AWSCredentialsProvider`
- Implementations:
  - `AWSCredentialsProviderChain(AWSCredentialsProvider ...credentialsProviders)` (a
	 sort of _wallet_ for credentials)
  - `ClasspathPropertiesFileCredentialsProvider` (uses a Java properties file in the CP)
  - `SystemPropertiesCredentialsProvider` (uses Java properties
  - `EnvironmentVariableCredentialsProvider` (uses env. vars)
  - `ProfileCredentialsProvider` (uses same profiles as AWS CLI)
</section>

<section>
# Getting credentials

- Through the provider chain:
  - `AWSCredentials = new DefaultAWSCredentialsProviderChain();`  
  (looks in a number of usual locations)
  - Specifying a specific provider
    - `import com.amazonaws.auth.AWSCredentials;`
	 - `import com.amazonaws.auth.profile.ProfileCredentialsProvider;`

`AWSCredentials credentials = new ProfileCredentialsProvider().getCredentials();`
</section>

<section>
# Client

- Get a `<service>Client` object for a given region and manipulate it
- Common constructor arguments:
  - `AWSCredentials` **or** `AWSCredentialsProvider`
  - `ClientConfiguration`: configures the underlying REST client (proxy, retries,
  timeout, protocols (HTTP/HTTPS)

Examples:

- `ec2 = new AmazonEC2Client(credentials);`
- `s3  = new AmazonS3Client(credentials);`
</section>

<section>
# Request interface

A `Request` object represents a HTTP request through which you provide arguments

- then provided to a client that will submit to AWS
- Classes are named after what they allow to manipulate
  - `Create<what>Request`, `Describe<what>Request`, `Delete<what>Request`

Examples:

  - `CreateSecurityGroupRequest`
  - DeleteInstanceRequest`
</section>

<section>
# Result interface

A `Result` object represents a HTTP response

- from which you get the result of your request
- Classes are name the same way as requests

Examples:

- `CreateSecurityGroupResult`
- `CreateInstanceResult`
</section>

<section>
# Models

Package `com.amazonaws.services.<service>.model`

- Contains the object-oriented representations of AWS entities:
  - Instances, Buckets, SecurityGroups, etc.
</section>

<section>
# Regions

Package `com.amazonaws.regions`

- The Enum `regions.Region` lists all regions
- Classes `regions.Region`/`regions.RegionUtils`:
  - List regions
  - Get a region object from a string id (_e.g._ `eu-west-1`)
  - Get a service endpoint
  - Create a client for a service
</section>

<section>
# Documentation

<http://aws.amazon.com/fr/sdkforjava/>
</section>
</section>

<section>
<section>
# EC2
</section>

<section>
# Connection to EC2

~~~~~~~~~~
AWSCredentials credentials = null;
try {
  credentials = new ProfileCredentialsProvider().getCredentials();
} catch (Exception e) {
   throw new AmazonClientException (
     "Cannot load credentials", e);
}
ec2 = new AmazonEC2Client(credentials);
~~~~~~~~~~
{: .language-java}
</section>

<section>
# Select the region

~~~~~~~~~~
Region usWest2 = new Region.getRegion(Regions.US_WEST_2);
ec2.setRegion(usWest2);
~~~~~~~~~~
{: .language-java}
</section>

<section>
# List AMIs

~~~~~~~~~~
DescribeImagesRequest request = new DescribeImagesRequest();

request.setImageIds(Arrays.asList('ami-xxxxxxx', 'ami-yyyyyyy');
DescribeImagesResults res = ec2.describeImages(request);
List<Images> images = res.getImages();
~~~~~~~~~~
{: .language-java}
</section>

<section>
# Run an instance

~~~~~~~~~~
RunInstancesRequest request = new RunInstancesRequest(<ami>, <min count>, <max count>);
RunInstancesResult res = ec2.runInstances(request);
Reservation reservation= res.getReservation();
List<Instance> instances = reservation.getInstances();
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Query an instance state

~~~~~~~~~~
InstanceState state = instance.getState();
String dns = instance.getPublicDnsName();
String ip = instance.getPublicIpAddress();
Date launchDate = instance.getLaunchTime();
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Terminate an instance

~~~~~~~~~~
// Get the reservation
DescribeInstancesRequest request = new DescribeInstancesRequest();
Filter filter = new Filter('tag:name', Arrays.asList('prod'));
request.setFilters(Arrays.asList(filter));
DescribeInstancesResult res = ec2.describeInstances(request);
List<Reservation> reservations = result.getReservations();
Reservation resa = reservations[0];
// Get the instance
instance = resa[0];
instance.terminate();
// Or terminate all instances
resa.terminate_all();
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Create a security group

~~~~~~~~~~
CreateSecurityGroupRequest request = new CreateSecurityGroupRequest('ssh-access', 'open ssh port');
ec2.createSecurityGroup(request);
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Configure a security group

~~~~~~~~~~
// Add a rule
IpPermission ssh = new IpPermission();
ssh.withFromPort(22).withToPort(22).withIpRanges('0.0.0.0/0');
IpPermission http = new IpPermission();
http.withFromPort(80).withToPort(80).withIpRanges('0.0.0.0/0');
List<IpPermission> perms = Arrays.asList(ssh, http);
AuthorizeSecurityGroupIngressRequest request = new authorizeSecurityGroupIngressRequest('ssh-access', perms);
~~~~~~~~~~
{: .language-java}

</section>
</section>

<section>
<section>
# S3
</section>

<section>
# Connection to S3

~~~~~~~~~~
AmazonS3 s3 = new AmazonS3Client(
  new ClasspathPropertiesFileCredentialsProvider());
~~~~~~~~~~
{: .language-java}
</section>

<section>
# Create a bucket

~~~~~~~~~~
CreateBucketRequest request =
  new s3.CreateBucketRequest("<name>", "<region>");
Bucket b = s3.createBucket(request);
~~~~~~~~~~
{: .language-java}
</section>

<section>
# List buckets

~~~~~~~~~~
ListBucketsRequest request = new ListBucketsRequest();
List<Bucket> buckets = s3.listBuckets(request);

for (Bucket b: buckets) {
  String s = String.format("====\n" +
                           "name: %s\n" +
                           "Date: %s\n",
                           b.getName(),
                           b.getCreationDate());
  System.out.println(s);
}
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Store objects

~~~~~~~~~~
// Store an image from a file
PutObjectRequest request =
  new PutObjectRequest("<bucket name>", "<object name>",
    new File('rihanna.jpg'));
s3.putObject(request);
~~~~~~~~~~
{: .language-java}
</section>

<section>
# Get objects

~~~~~~~~~~
// Download to a file
GetObjectrequest request = new GetObjectRequest("<bucket name>", "<object name>");
S3Object res = s3.getObject(request);
S3ObjectInputStream stream = res.getObjectContent();
IOUtils.copy(stream, new FileOutputStream("morerihanna.jpg"));
~~~~~~~~~~
{: .language-java}
</section>

<section>
# List a bucket content

~~~~~~~~~~
ListObjectRequest request = new ListObjectRequest().withBucketName("<bucket name>");
ObjectListing res = S3.listObject(request);
List<S3ObjectSummary> summaries = res.getObjectSummaries();
~~~~~~~~~~
{: .language-java}
</section>
</section>

<section>
<section>
# ELB
</section>

<section>
# Concept

>An _Elastic Load Balancer_ is a server that receives client
>connections and forwards them to a pool of instances based
>on defined rules.

Instances can be added or removed from the pool based on their
_health_ and auto-scaling policies.
</section>

<section>
# Connection to ELB

~~~~~~~~~~
AmazonElasticLoadBalancing elb =
  new AmazonElasticloadBalancing(provider);
~~~~~~~~~~
{: .language-java}
</section>

<section>
# Define a HealthCheck

- Every 20 seconds
- With a 15-second timeout
- On the resource: `HTTP:8080/health`
- 3 successful checks: resource is **enabled**
- 5 failed checkes: resource is **disabled**

~~~~~~~~~~
HealthCheck hc =
  new HealthCheck('HTTP:8080/health', 20, 15, 5, 3);
~~~~~~~~~~
{: .language-java}

A web server must serve `http://<ip>:8080/health`
</section>
<section>
# Creating a load balancer

~~~~~~~~~~
List<String> zones = Arrays.asList('eu-west-1a', 'eu-west-1b');
Listener http = new Listener('http', 80, 8080);
Listener https = new Listener('https', 443, 8443);
List<Listener> listeners = Arrays.asList(http, https);
CreateLoadBalancerRequest request =
  new CreateLoadBalancerRequest('lb1', listeners, zones);
CreateLoadBalancerResult res = elb.createLoadBalancer(request);
~~~~~~~~~~
{: .language-java}

<div class="small">
The **listener** provides _network translation_ from the client to an
instance. Its _frontend_ is limited to ports **25, 80, 443, 465, 587** and
**1024-65535**. Its _backend_ (instance) can listen to any port.
</div>

</section>

<section>
# Creating a load balancer (2)

~~~~~~~~~~
// Get the load balancer DNS
String dns = res.getDNSName();
// Configure the healthcheck
ConfigureHealthCheckRequest request =
  new ConfigureHealthCheckRequest('lb1', hc);
elb.configureHealthCheck(request);
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Add instances to a LB

~~~~~~~~~~
List<Instances> instances =
  Arrays.asList(new Instance('i-xxx'), new Instance('i-yyy'));

RegisterInstancesWithLoadBalancerRequest request =
  new RegisterInstancesWithLoadBalancerRequest('lb1', instances);
Elb.registerInstancesWithLoadBalancer(request);
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Remove instances from a LB

~~~~~~~~~~
DeregisterInstancesFromLoadBalancerRequest request =
  new DeregisterInstancesFromLoadBalancerRequest('lb1', instances);
elb.deregisterInstancesFromLoadBalancer(request);
~~~~~~~~~~
{: .language-java}

</section>

<section>
# Remove a load balancer

~~~~~~~~~~
DeleteLoadBalancerRequest request = new DeleteLoadBalancerRequest('lb1');
elb.deleteLoadBalancer(request);
~~~~~~~~~~
{: .language-java}

</section>
</section>

<section>

<section>
# Alternatives
</section>

<section>
# Boto

- Python library
- Official Python SDK for AWS
- (A lot) less verbose!

<https://aws.amazon.com/sdk-for-python/>

</section>

<section>
# Libcloud

- Python library by Apache
- Broker for [multiple IaaS
  stacks](https://libcloud.readthedocs.io/en/latest/supported_providers.html)
  (more than 50!)
- Supports
  - Virtual machines management
  - Storage service
  - Load balancing service
  - DNS service

<https://libcloud.apache.org/>

</section>

<section>
# Deltacloud

<div style="text-align:center">
![Deltacloud arcitecture](../../img/deltacloud.png)
</div>

- A Broker in the form of a REST proxy
- Developed by [Apache](https://deltacloud.apache.org/)
- Library bindings (Ruby, Python, C, C++) and REST (_via_ Curl, for example)
- Supports [15 providers](https://deltacloud.apache.org/drivers.html#drivers)

</section>

</section>
