---
title: Amazon Web Services − Introduction
theme: amazon
---

{::options parse_block_html="true" /}

<section>
# Introduction to<br />Amazon Web Services

<img class="clean" src="../../img/aws_logo.png" />
</section>

<section>
# Outline

- Context
- Overview of the different AWS services
- The Web Console
- Focus on EC2 &amp; S3
- Cost management

</section>

<section>
<section
		data-background-video="../../mov/movie-intro.mp4"
		data-background-video-muted="false">
<h1 style="font-weight: bold;">A bit of History…</h1>

</section>

<section>
# One uppon a time…

<div class="left-column" style="width: 60%">
- **_1995:_** first major online shop, amazon.com
- **_1996:_** $15,700,000,000 revenue during its 1st year
- About 0.5% Walmart's sales volume
</div>
<div class="right-column">
![Business Week cover](../../img/press/business_week_cover.jpg)
</div>

<p style="clear: both;" class="large">Scaling up soon became an issue.</p>
</section>

<section class="small" style="text-align: center;">

# From a shop to a platform

- **_2003:_** Specification of a novel platform for Amazon, based on **Web Services**
- **_2004:_** First AWS service launched for the public: Amazon _Simple Queuing Service_
- **_2006:_** Official lauch of AWS
- **_2010:_** All Amazon.com retail activities moved to AWS

![timeline](../../img/aws_timeline.jpg)

AWS follows a <span data-placement="top" data-toggle="popover" data-trigger="focus"
title="Service Oriented Architecture"
tabindex="0" role="button"
data-content="SOA designates a software design where services are provided between
decoupled components through a network communication protocol.">_Service Oriented Architecture_</span>(SOA) design.
</section>

<section>
# AWS: a few figures

- 9 regions, including  special ones
  - 1 for the US Government in North America
  - 1 for the Chinese market in Beijing
- Revenue: $7.88 billion (2015)
- Profit: &#8776; $1 billion
- Growth &#8776; 50%/year since 2010

<a style="position: absolute; top: 20px; left: 0px; width:50%;"
			class="fragment fade-right"
			href="http://uk.businessinsider.com/aws-revenue-is-bigger-than-its-four-closest-competitors-combined-2015-4"><img src="../../img/press/aws_revenue_businessinsider.jpg" /></a>
<a style="position: absolute; top: 50px; right: 0px; width: 50%;"
			class="fragment fade-left"
			href="http://venturebeat.com/2016/01/28/amazon-web-services-brings-in-2-4b-in-revenue-in-q4-2015-up-69-over-last-year/"><img src="../../img/press/aws_revenue_venturebeat.jpg" /></a>
</section>

<section>
# AWS: services

<div style="text-align: center">
![Main AWS services](../../img/aws_main_services.png)
</div>

- **55 services** accessible through the Web Console
- Stack organization: higher level services rely on low-level services
</section>
</section>

<section>
# AWS in details
</section>

<section>
<section>
# A resilient infrastructure

<div class="left-column small" style="width: 50%;">
- 9 isolated regions
- Each region divided into *availability zones*
- Availability zones inside a region are
  - Physically separate (distinct DCs)
  - Interconnected with a single network
</div>
<div class="right-column" style="width: 50%">
![AWS map](../../img/aws_map.png)
![Availability zones](../../img/aws_availability_zones.png)
 </div>
</section>

<section>
# Regions
<div class="left-column small" style="width: 50%;">
- North America
  - us-east-1 (Northern Virginia)
  - us-west-1 (Oregon)
  - us-west-2 (Northern California)
  - GovCloud (limited to the US Government and their agencies)
- Europe
  - eu-west-1 (Ireland)
  - eu-west-2 (London)
  - eu-central-1 (Frankfurt)
</div>
<div class="right-column small" style="width: 50%;">
- South America
  - sa-east-1 (São Paulo)

- Asia Pacific
  - ap-northeast-1 (Tokyo)
  - ap-northeast-2 (Seoul)
  - ap-southeast-1 (Singapore)
  - ap-southeast-2 (Sydney)
  - ap-south-1 (Mumbai)
  - China (limited to the Chinese domestic market)
</div>

<div style="clear: both;"></div>

Plus &#8776; 40 [Edge regions](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/).
</section>

<section>
# Edge locations
<div class="left-column tiny" style="width: 50%;">
- North America	 	 	 
  - Ashburn, VA 
  - Atlanta, GA
  - Chicago, IL
  - Dallas/Fort Worth, TX 
  - Hayward, CA
  - Jacksonville, FL
  - Los Angeles, CA 
  - Miami, FL
  - Montreal, QC
  - Newark, NJ
  - New York, NY 
  - Palo Alto, CA
  - San Jose, CA
  - Seattle, WA
  - South Bend, IN
  - St. Louis, MO
  - Toronto, ON

- South America
  - Rio de Janeiro, Brazil
  - São Paulo, Brazil
</div>
<div class="right-column tiny" style="width: 50%;">
- Europe
  - London, England 
  - Marseille, France
  - Paris, France 
  - Frankfurt, Germany 
  - Milan, Italy
  - Dublin, Ireland
  - Amsterdam, the Netherlands
  - Warsaw, Poland
  - Madrid, Spain
  - Stockholm, Sweden

- Asia Pacific
  - Melbourne, Australia
  - Sydney, Australia
  - Hong Kong, China 
  - Chennai, India
  - Mumbai, India 
  - New Delhi, India
  - Osaka, Japan
  - Tokyo, Japan 
  - Seoul, Korea 
  - Manila, the Philippines
  - Singapore 
  - Taipei, Taiwan
</div>

<div style="clear: both;"></div>

These edge locations are used by [CloudFront](https://aws.amazon.com/cloudfront/) (CDN)
and [Route53](https://aws.amazon.com/route53/) (DNS)
only.
</section>

<section>
# Region layout

Each region is composed of **multiple isolated Data Centers** called _Availability Zones_

### Example: eu-west-1 region

<div style="text-align: center;">
![eu-west-1 map](../../img/eu-west-1.jpg)
</div>

Average distance between two AZs: &#8776;40km.
</section>
</section>

<section>
<section>
# AWS: main services

<div class="small">
- **EC2** (*Elastic Compute Cloud*)
  - Manage virtual appliances (VMs)
- **S3** (*Simple Storage Service*)
  - Manage storage (buckets)
- **EBS** (*Elastic Block Store*)
  - Manage block storage (raw devices)
- **ELB** (*Elastic Load Balancing*)
  - Manage load balancers
- **RDS** (*Relational Database Service*)
  - Manage relational databases
- **DynamoDB**
  - Manage NoSQL databases
- **ElastiCache**
  - Manage in-memory caches
</div>
</section>

<section>
# EC2

<div class="left-column small" style="width:48%;">
- Manage *Virtual Machines* (VMs)
  - *Based on the [Xen](https://www.xenproject.org/) hypervisor*
- Many instance types (or *flavors*)
  - *CPU, RAM, disk, GPU, etc.*
  - Pricing varies
- VMs rely on *Disk Images*
  - Marketplace (predefined)
  - Custom
- Multiple billing options
  - *On-demand, Reserved, Spot*
  - Pricing varies (a lot!)
</div>
<div class="right-column" style="width: 50%;">
![EC2 terminology](../../img/ec2_terminology.jpg)
</div>
</section>
</section>

<section>
<section>
# EC2 instances

> An **EMI** (*Amazon Machine Image*) is a snapchot of a system that is
> used as a base for VMs. It can be seen as an archive of an entire filesystem.

- Each VM uses its own copy of the EMI
- 2 types of instance:
  - **Instance storage:** non-persistent storage
  - **EBS storage:** the root filesystem is a persistant EBS volume

</section>

<section class="small">
# Instance types

Category  | Usage
----------| -----:
t2        | General purpose
m4        | General purpose
m3        | General purpose
c4        | Compute intensive
c3        | Compute intensive
x1        | Compute &amp; memory intensive
r3        | Memory intensive
g2        | GPU
i2        | I/O intensive
d2        | Storage

</section>

<section class="small">
# Focus: t2 instances

The cheapest category of instances.

Model      | vCPU | Mem (GiB) | Storage
-----------| :---:|:---------:|---------
t2.nano    | 1    | 0.5       | EBS only
t2.micro   | 1    | 1         | EBS only
t2.small   | 1    | 2         | EBS only
t2.medium  | 2    | 4         | EBS only
t2.large   | 2    | 8         | EBS only

**These are [Burstable Performance Instances](https://aws.amazon.com/ec2/faqs/#burst)!**
(Good for unregular performance requirements.)
</section>

<section class="small">
# Focus: m4 instances

The new generation of general purpose instances.

Model         | vCPU | Mem (GiB) | SSD Storage | Dedicated EBS Bandwidth (Mbps)
--------------| :---:|:---------:|-------------|:-----------------------------:
m4.large      | 2    | 8         | EBS only    | 450
m4.xlarge     | 4    | 16        | EBS only    | 750
m4.2xlarge    | 8    | 32        | EBS only    | 1,000
m4.4xlarge    | 16   | 64        | EBS only    | 2,000
m4.10xlarge   | 40   | 160       | EBS only    | 4,000
m4.16xlarge   | 64   | 256       | EBS only    | 10,000

</section>

<section class="small">
# Focus: c4 instances

The new generation of instances optimized for computation intensive.

Model         | vCPU | Mem (GiB) | SSD Storage | Dedicated EBS Bandwidth (Mbps)
--------------| :---:|:---------:|-------------|:-----------------------------:
c4.large      | 2    | 3.75      | EBS only    | 500
c4.xlarge     | 4    | 7.5       | EBS only    | 750
c4.2xlarge    | 8    | 15        | EBS only    | 1,000
c4.4xlarge    | 16   | 30        | EBS only    | 2,000
c4.8xlarge    | 36   | 36        | EBS only    | 4,000

</section>

<section class="small">
# Focus: r3 instances

Instances optimized for memory-intensive applications.

Model         | vCPU | Mem (GiB) | SSD Storage (GB)
--------------| :---:|:---------:|:---------------:
r3.large      | 2    | 15.25     |  1 x 32
r3.xlarge     | 4    | 30.5      |  1 x 80
r3.2xlarge    | 8    | 61        |  1 x 160
r3.4xlarge    | 16   | 122       |  1 x 320
r3.8xlarge    | 36   | 244       |  1 x 320

</section>

<section class="small">
# Focus: g2 instances

Instances optimized for graphics and general purpose GPU compute applications.

Model         | GPUs | vCPU | Mem (GiB) | SSD Storage (GB)
--------------| :--: | :---:|:---------:|:---------------:
g2.2xlarge    | 1    | 8    | 15        | 1 x 60
g2.8xlarge    | 4    | 32   | 60        | 1 x 120

</section>

<section class="small">
# Focus: i2 instances

Instances optimized for storage, with high I/O performance.

Model         | vCPU | Mem (GiB) | SSD Storage (GB)
--------------| :---:|:---------:|:---------------:
i2.xlarge     | 4    | 30.5      |  1 x 800
i2.2xlarge    | 8    | 61        |  2 x 800
i2.4xlarge    | 16   | 122       |  4 x 800
i2.8xlarge    | 32   | 244       |  8 x 800

Good for databases and clustered filesystems.

</section>

<section class="small">
# Focus: d2 instances

Dense-storage instance.

Model         | vCPU | Mem (GiB) | Storage (GB)
--------------| :---:|:---------:|:---------------:
d2.xlarge     | 4    | 30.5      |  3 x 2000 HDD 
d2.2xlarge    | 8    | 61        |  6 x 2000 HDD
d2.4xlarge    | 16   | 122       |  12 x 2000 HDD
d2.8xlarge    | 36   | 244       |  24 x 2000 HDD

Good data warehouses, parallel filesystems, Hadoop MapReduce.

</section>
</section>

<section>
<section>
# EC2: 3 types of instances

…that are actually billing options:

- **On-demand** instances
- **Reserved** instances
- **Spot** instances

For all of them, **license fees** can be added!
</section>

<section>
# EC2: On-demand instances

The most common type of instances:

- No long-term commitment
- Charged by the hour
- The most handy

</section>

<section>
# EC2: Reserved instances

Pay upfront for a defined period and save up to 75%. Two modes:

- _**Always-on:**_ on 24x7, always available (and **always charged**)
- _**Scheduled:**_ reserved on a recurring schedule basis, accomodates
important but irregular needs
</section>

<section>
# EC2: Spot instances

The cheapest: save 50-90% renting unused instances for a low price.
the price fluctuates according to the platform **capacity** and **demand**.

The customer fixes a bid. At any point in time:

- If the current instance price is lower than the bid, your instance can run.
- Otherwise, your instance cannot run, you have to wait for the price to lower
or increase your bid.

**Difficult to use:** instances can disappear anytime due to price variations!

Well fitted for batch on <span data-placement="top"
data-toggle="popover" data-trigger="focus"
title="Bag Of Tasks" tabindex="0" role="button"
data-content="A type of jobs that are parallel and amongst which there are
no dependencies. Tasks from the bag can be run in any order, be interrupted
and restarted without significatively disturbing the whole application.
Examples: file conversion, web crawler, etc.">Bag of Tasks</span> (BoT) applications.
</section>
</section>

<section>
<section>
# Other important AWS services
</section>

<section>
# EC2: Security Groups

A software firewall for instances

- Defines a set of firewall rules
- By default: out traffic allowed, in traffic blocked (including SSH!)
- Every instance is in a security group (_default_ group)
- Custom rules can be added
</section>

<section>
# Elastic IP

**Addressing**: customers can rent public IPs from Amazon

Each instance has:

- 1 private IPv4 address
- 1 public IPv4 address

By default, the instance public IP address is **dynamic** (NAT).

Optionally, a **static** address (paid) can be assigned from customer Elastic IP pool.
</section>

<section>
# IAM

**Identity & Access Management**

- Roles and access management
- User groups
- Limited API access depending on user roles
- Detailed billing per roles/groups
- Fine grained access policies
  - Per role
  - Per resource
</section>

<section>
## EBS

**Elastic Bloc Storage**

- Offers persistent storage volumes
- Volumes can be attached to/detached from one or more EC2 instances
- **Snapchots:** create an copy of an EBS volume at a given time
- Create new volumes from snapchots

<br/>

What     | Identifier
---------|----------:
Volume   | _vol-XXXX_
Snapshot | _snap-XXXX_

</section>

<section>
# ELB

**Elastic Load Balancing**

Balances incoming requests to a pool of EC2 instances

- Supports TCP, HTTP(S) and SSL protocols
- Intances can be attached/detached dynamically
- Compatible with auto-scaling features:
  - provision/deprovision instances dynamically
  - according to pre-defined policies (response time, CPU load, etc.)
</section>

<section class="small">
# S3

**Simple Storage Service**

- Object storage (up to 5 TB)
- Each object associated to a unique key
- Unlimited number of objects
- Object are stored in containers call _buckets_
- Each bucket is assigned to a region
- Fine grained authentication and ACL
  - Object can be public/private

An _Infrequent Access_ offers lower cost for data that are accessed less
frequently.

Billing:

- Put/Get requests
- Transfered volume

</section>

<section>
# Glacier

Long-term storage, archival.

- For very infrequent access
- Very cheap (from $0.0.7/GB/month)
- Long restoration delays (3 to 5 hours)
- Accessed though S3

</section>

<section>
# Route 53

DNS-as-a-Service

- Manages DNS inside and outside AWS
- Routing policies based on
  - Latency
  - Locality
  - Weighted Round Robin
- Compatible with EC2, EIP and ELB
- Very low propagation latency

</section>

<section class="small">
# SQS

**Simple Queuing Service**

<div class="left-column" style="width: 60%;">
A **messaging queue** for web applications & services to communicate
reliably.

- Distributed design
- Build for SOA

**General principles**

  - Producer/consumer paradigm
  - File queues (buffers)
  - A message: 64 KB of text
  - Delivery guarenteed
</div>
<div class="right-column" style="width: 40%;">
![Messaging queue principle](../../img/messaging_queue.png)
</div>

</section>

<section class="small">
# Simple Notification Service

Notification service for applications and clients

  - Publish/subscribte (<span data-placement="bottom" data-toggle="popover" data-trigger="focus"
title="PubSub"
tabindex="0" role="button"
data-content="Publish/Subscribe is a distributed communication paradigm:
clients publish messages to a channel, and clients that previously subscribed
to the same channel will receive it asynchronously.">PubSub</span>) paradigm

**Principles**

  - _Topic:_ a named messaging queue
  - Push model
  - Interfaces with iOS, Android, Windows Phone, SMS, email, etc.


 .           | SQS             | SNS
-------------|-----------------|------------------------------------
Consumers    | No subscription | Mandatory subscription/confirmation
Multiplicity | 1-to-1          | 1-to-N (Broadcast)
Com. model   | Pull            | Pull

</section>

<section>
# Relational Database Service

- DBaaS (Amazon Aurora, Oracle,MS SQL Server, PostgreSQL, MySQL, MariaDB)
- High-availability SQL DB with replication
- Easy scaling
- Backup/Restore
- Effortless
- Import/export feature
</section>

<section>
# DynamoDB

Amazon's
<span data-placement="right" data-toggle="popover" data-trigger="focus"
title="NoSql"
tabindex="0" role="button"
data-content="A database paradigm that allows to store and query data without
relying on traditional relations used in relational databases. Relaxing important
RDB properties, NoSql DBs allow for better performance at the cost of consistency.
Example: Redis, MongoDB, Voldemort, DynamoDB, etc.">NoSql</span>
(key/value) database.

- SSD based: very low latency
- Replicated over **3 Availability Zones** inside any given region
- Strong consistency
- Very scalable

</section>

<section>
# (EMR) Elastic MapReduce

Hadoop is great (but hard to setup!)
EMR is an integrated Hadoop-based
<span data-placement="right" data-toggle="popover" data-trigger="focus"
title="MapReduce"
tabindex="0" role="button"
data-content="MapReduce is a programming model and runtime for big data processing.
The programmer implements only two promitives ('map' and 'reduce');
a runtime environment is then responsible for splitting the workload into independant
tasks and executing them on a cluster. Communications, failures and retries are handled
transparently. The historical implementation is Google MapReduce, while the most
commonly used is Hadoop MapReduce, a free software maintained by the Apache Foundation.">MapReduce</span>
framework:

- Put your data in S3
- Lauch EMR:
  - EC2 cluster automatically provisioned
  - MR tasks automatically run on top of the EC2 cluster
- Get the results back from S3
- EC2 cluster automatically de-provisioned

More than just Hadoop: [HDFS](http://hortonworks.com/apache/hdfs/),
[Pig/Latin](https://pig.apache.org/), [Hive](https://hive.apache.org/),
[Spark](http://spark.apache.org/), …
</section>

<section>
# Virtual Private Cloud

Simulates a private cloud with EC2 instances and VPN techniques.

- Isolated network (software)
- A dedicated IP pool
- Security: limit access to S3 to a VPC
- Allows to bind an EIP to an instance inside a VPC
- Cost: $0.05/h/VPN access
</section>

<section>
# Amazon EC2 Container

The new **buzzword** in Cloud Computing

- Allows easy deployment of Docker containers in EC2 instances
- AMI that includes the Docker daemon
- No virtualized OS: faster deployment*
- Same instances charge

<p class="footnote">*once the EC instances and Docker daemons are deployed</p>
</section>
</section>


<section>
<section>
#Deployment services
</section>

<section>
# Elastic Beanstalk

AWS **PaaS** service.

Allows to deploy a complete stack…

- Java, .NET, PHP, Node.js, Python, Ruby, Go, Docker…
- Relies on other AWS services to deploy and maintain the platform
- Does not deploy DB backends
- Scenario based deployments

…without having to maintain the underlying software.
</section>

<section>
# CodeCommit

Private **git repo** hosting.

- No administrative duty
- IAM takes care of users and ACL
- Elastic: grows with your data
- Low cost: $1/user/month
  - 10GB and 2000 queries/month
</section>

<section>
# CodeDeploy

Deploy **development** code on EC2 instances

- The app must be in S3 or in a git repo
- Integrates with common development tools &amp; platforms
  - GitHub, Jenkins, Tavis CI, CloudBees, etc.
  - Apache, Nginx, Passenger and IIS.
- Deployment configured by _recipies_ (declarative text)
- Web Console, CLI and Python SDK
- Minimizes downtime
</section>

<section>
# CodePipeline

<span data-placement="right" data-toggle="popover" data-trigger="focus"
title="Rolling release"
tabindex="0" role="button"
data-content="Software deployment model where changes to code are pushed
into production continuously. This the opposite of version released, where
the production software is updated in cycles. Rolling releases allow faster
deployment of bug fixes and new features,
greatly reducing the Time-to-Market.">Rolling release</span> of development code.

- Based on various external events
- A GUI to define deployment pipelines

![CodePipeline workflow](../../img/aws_codepipeline.png)
</section>

<section>
# OpsWorks

**Automated infrastructure deployment** based on [Chef](https://www.chef.io/).

- Deploy complete appliances filled with industry-standard software
(HAProxy, Memcached, MySQL, etc.)
- Compatible with your existing Chef recipies
- Manageable with APIs
</section>

<section>
# Amazon Workspaces

A virtual desktop in EC2

- A set of desktop applications inside a web browser
- Windows-based
- Let you chose applications to deploy from a catalog
- From $21/month (<span data-placement="left" data-toggle="popover" data-trigger="focus"
title="BYOL"
tabindex="0" role="button"
data-content="Bring Your Own Licenses: if you already own some licenses, use yours instead
of renting them from the provider (here, Amazon) along with the instances.">BYOL</span>)
</section>
</section>

<section class="small">
# Do you want more?

<div class="fragment zoom-in">
- **Direct Connect**: connect your network directly to Amazon
- **Cloud Front**: CDN (Content Delivery Network) on the Edge
- **AWS storage Gateway**: connect your local IT infrastructure to S3
- **ElastiCache**: distributed in-memory cache (Redis, Memcached)
- **RedShift**: managed <span data-placement="top" data-toggle="popover" data-trigger="focus"
title="Data Wharehouse"
tabindex="0" role="button"
data-content="A large central repository for data coming from multiple sources.
Usually integrated with reporting and analysis tools.">Data Warehouse</span>
- **Cloud Formation**: <span data-placement="top" data-toggle="popover" data-trigger="focus"
title="Infrastructure as Code"
tabindex="0" role="button"
data-content="A technique to provision, configure and manage cloud resources through
declarative machine-redeable definition files. Examples are Ansible, Puppet
and Chef.">Infrastructure-as-Code</span>
- **CloudTrail**: logging service for AWS API calls
- **CloudWatch**: monitoring service
- **Directory Service**: MS Active directory
</div>
</section>

<section style="text-align: center;">
# AWS Console

[https://console.aws.amazon.com](https://console.aws.amazon.com)
</section>

<section>
# Cost

- Use the [Total Cost Ownership Calculator](https://awstcocalculator.com) to estimate whether it is worth
migrating to the cloud.

- Use the [AWS Calculator](https://calculator.s3.amazonaws.com/index.html) to estimate the cost of various services.
</section>

<section>
# Tips and tricks

- EC2
  - Every hour started is charged
  - Incoming traffic is free
  - Data transfers within an AZ is free
  - **Free-tier** on the 1st year: 730h of a t1.micro instance
  - EIP are charged even when unused!

Prefer **reserved** and **spot** instances when possible
</section>

