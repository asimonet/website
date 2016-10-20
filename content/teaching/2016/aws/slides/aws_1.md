---
title: Cloud Computing − Introduction
theme: amazon
---

{::options parse_block_html="true" /}

<section class="title-slide">
# Amazon Web Services

<center>
<img class="clean" src="../../img/aws_logo.png" height="30%" />
</center>

## (Module &ldquo;Cloud Computing&rdquo;)

### Anthony Simonet
</section>
	
<section>
# About this module

<div>
<span><img class="icon" src="/assets/img/icons/user.png" />Anthony Simonet</span><br />
<span><img class="icon" src="/assets/img/icons/email.png" />anthony.simonet@mines-nantes.fr</span><br />
<span><img class="icon" src="/assets/img/icons/globe.png" /><a href="/teaching/2016/aws">http://www.anthony-simonet.fr/teaching/2016/aws</a></span><br />
</div>

<p class="small">All course materials (including this) are online.</p>
</section>

<section>
# Organization

What?     | How long?
:---------|---------:
Course    | 8h
Practical | 8h

**Exam:**

- Small project on Thursday
- (very) small report by next week
</section>

<section>
# Content

- Introduction to Cloud Computing
- Introduction to Amazon Web Services
- Toolbox
- Provisioning
- Introduction to AWS development
- Deploying a Web Application on AWS
</section>

<section>
# Introduction to Cloud Computing
</section>

<section>
# Context

- Building a data-center is:
  - Expensive
  - Slow
  - Complicated
- Cloud Computing is a solution to ALL these issues
  - Cloud operators reduce cost through important economies of scale
  - Resources are available immediately
  - No hardware/software maintenance cost
</section>

<section>
# Before the cloud

Prehistory, companies would:

- Buy servers
- Set them up
- Install OS &amp; software
- Maintain servers (software updates, hardware replacement, etc)
- Repeat <span class="tiny">a few years later</span>.

</section>

<section>
<section class="auto-start">
# What is the Cloud?

<div class="fragment current-displayed" data-fragment-index="0">

- Remote computing resources or services
- Accessed through the Internet
- Virtually unlimited (elastic)
- Based on **Virtualization** techniques
- Per-usage billing

</div>

<table class="fragment fade-up" style="font-size: 0.9em;" data-fragment-index="1">
<tr><th>Advantages</th><th>Disavantages</th></tr>
<tr><td>No installation cost</td><td>Security</td></tr>
<tr><td>No installation maintenance cost</td><td>Confidentiality</td></tr>
<tr><td>Resources available immediately</td><td>Legal concerns</td></tr>
<tr><td>Globaly deployed resources</td><td>Vendor lock-in</td></tr>
<tr><td>Freedom (no contract)</td><td></td></tr>
</table>
</section>

<section>
## The cloud is remote

Clients access online resources throught the **Internet** and have
**no idea** where they are actually located.

<center>
<a href="https://xkcd.com/908/"><img src="../../img/xkcd_the_cloud.png" alt="XKCD: The Cloud" /></a>
</center>
</section>

<section>
## The cloud is virtualized

Recent **Virtualization techniques** allow providers to
**colocate** (or consolidate) multiple virtual machines on
a single server.

Virtualization allows **transparent migrations** for
maintenance, load-balancing, resiliency and more.
</section>

<section>
## The cloud is Elastic

…and virtually **infinite**: clients can _theoratically_
request as many resources as they need.

Cloud resources are charged on a **per-usage** basis
(usually hourly) and can be freed anytime.
</section>
</section>

<section>
<section style="text-align: center;">
# Where is the Cloud?

<img src="../../img/google_cluster_1998.jpg" />
<p class="fragment fade-up small">Google cluster, 1998</p>
</section>

<section data-background-video="../../mov/google-data-center.mp4"
	data-background-video-loop="true"
	data-background-transition="zoom">
<h1 style="font-weight: bold; color: #ffffff">A Google data center, now</h1>

<br /><br /><br />

<div style="font-weight: bold; color: #ffffff">
<p>15+ data-centers on 4 continents</p>
<p>2,000,000+ servers</p>
</div>
<p class="footnote">
Source:
<a href="https://www.youtube.com/watch?v=XZmGGAbHqa0">https://www.youtube.com/watch?v=XZmGGAbHqa0</a>
</p>
</section>

<section>
# Google data-centers

Google uses <span data-placement="bottom" data-toggle="popover" data-trigger="focus"
title="Commodity Hardware"
tabindex="0" role="button"
data-content="Relatively inexpensive consumer hardware, as opposed to
high-end specialized hardware. This type of hardware can be commonly
found everywhere, which also makes it more interchangeable.">commodity hardware</span> (in custom cases):

- When the number of servers increases, faults are unavoidable
- Resiliency must be a software duty
  - Task replication
  - Clever distribution of tasks/data
  - Adapted programming paradigms (_e.g._ <span data-placement="top" data-toggle="popover" data-trigger="focus"
title="Implicit Parallelism"
tabindex="0" role="button"
data-content="Class of high-level proramming models where developpers
write sequential code, which is then transpasently executed in parallel
by a runtime system.">implicit parallelism</span>)
</section>
</section>

<section>
<section>
# The cloud **needs** scalable infrastructures
</section>

<section>
# Scalable infrastructures

**_Scalability:_** capacity to increase throughput as the size of the
infrastructure increases.

A scalable infrastructure requires scalable **software** and
**hardware** architectures:

- More resources must imply better performance
- No single Point of Failure (PoF)
- Efficient resource usage
- Ability to manage heterogeneous resources

</section>

<section style="text-align: center;">
# Scalability

<img src="../../img/scalability.png" class="stretch" alt="Scalability" />

</section>

<section>
# Scalability

2 strategies to scale up an infrastructure:

- **_Horizontal scaling:_** increase the number of resources (_scale out_)
- **_Vertical scaling:_** increase the capacity of individual resources (_scale up_).

</section>

<section>
# Scalability

<div class="left-column">
**_Horizontal_**

- Slow
- Costly
- …but easy

</div>
<div class="right-column">
**_Vertical_**

- Hard to program
- Must be planned well in advance
- Creates less disruption

</div>
</section>

<section>
# Scale in, **Scale down**

**_The Cloud:_**

- virtually infinite resources
- available and charged on demand
- no contract

&#8702; makes _scaling down_ easy (and cheap)
</section>
</section>

<section>
<section>
# There's more to the cloud
</section>

<section class="auto-play">
# \*-as-a-Service

- **Infrastructure as a Service**
  - Provides virtual machines on which we deploy virtual images
  - Amazon EC2, Microsoft Azure, Rackspace, etc.
- **Platform as a Service**
  - Provides a runtime platform (OS, DB, application servers, etc)
  - Amazon Elastic Beanstalck, Google App Engine, etc.
- **Software as a Service**
  - Provides a software service
  - Google Apps, LiveOffice, SaleForce, etc.

</section>

<section>
# Deployment models

- **_Public:_**
  - Infrastructure rented from a third party provider
  - E.g. AWS, Microsoft Azure, Rackspace, OVH
- **_Private/shared:_**
  - Private infrastructure managed by a company/an institution,
  can be shared with partner institutions
  - E.g. locally deployed OpenStack/OpenNebula
- **_Hybrid:_**
  - Aggregate of resources from multiple clouds to accomodate _bursts_
  - _Sky Computing_

</section>

<section>
![Separation of Responsibilities](../../img/cloud-stack.png)
</section>

<section data-background-color="#000000" class="auto-play loop">
<p class="TBC">To be continued<span class="fragment">.</span><span class="fragment">.</span><span class="fragment">.</span></p>
</section>
</section>
