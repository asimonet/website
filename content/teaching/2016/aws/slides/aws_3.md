---
title: Amazon Web Services − Command-line Interface
theme: amazon
---

{::options parse_block_html="true" /}

<section>
# Amazon Web Services

<img class="clean" src="../../img/aws_logo.png" />

## Command-Line Interface(s)
</section>

<section>
# In this course:

- Presentation of multiple CLI tools for AWS
  - EC2 API/AMI tools
  - Euca2ools
  - S3cmd
  - AWS CLI
</section>

<section>
# Overview 

Many available tools

- The official CLI: <http://docs.aws.amazon.com/cli/latest/reference/>
- Many unofficial tools:
  - Euca2ools (originally for the [Eucaliptus](http://www8.hp.com/us/en/cloud/helion-eucalyptus-overview.html) stack
  - Compatible with AWS, OpenStack and OpenNebula
- S3cmd: the Swiss army knife for S3
 
</section>

<section>
<section>
# Getting your AWS credentials

**Be careful**: you should never use your Master account credentials in
production!!

Instead, create specific users with reduces ACL with AMI

An **AWS credential**:

- An access key
- A secret key

</section>

<section>
# Getting your AWS credentials

1. Log into the administration console at <https://aws.amazon.com>
2. Click on your name, then on &ldquo;Security credentials&rdquo;
3. Create an access key-pair

</section>

<section>
# Creating a AMI user

1. In the console, go to AMI
2. Click on the &ldquo;Users&rdquo; menu
3. Click on &ldquo;Create user&rdquo;
4. Download the credentials in a CSV file file

</section>
</section>

<section>
<section>
# AWS CLI
</section>

<section>
# Context

A unified client for most AWS services

- Based on Python 2/3
- Simple semantics

```
aws <service> <commande> <options>
```

- Can take JSON as input
- Produces JSON output by default

<http://docs.aws.amazon.com/cli/latest/reference/>
</section>

<section class="small">
# Installation

**To install (_Linux_ and _OSX_):**

1. ```pip install awscli```
2. You're done.

**To install (_Windows_):**

1. Follow the instructions: <http://docs.aws.amazon.com/cli/latest/userguide/installing.html>
2. Waste a lot of time

Test it: ```aws help```

</section>

<section class="small">
# Configuration

Via a configuration file generated with ```aws configure```

- Multiple profiles (--profile option)
- Multiple output format (JSON, text, table)

```export AWS_DEFAULT_OUTPUT="table"```

**or** explicitely with ```--output```

**or** in the configuration file ```~/.aws/config```
in the default section: ```output=text ```

</section>

<section>
# Configuration <span class="small">(`~/.aws/config`)</span>

~~~~~
[default]
aws_access_key_id=<default access key>
aws_secret_access_key=<default secret key>
region=us-west-1  # optional, to define default region for this profile

[testing]
aws_access_key_id=<testing access key>
aws_secret_access_key=<testing secret key>
region=us-west-2
~~~~~
</section>

<section>
# Useful commands

- Launch an instance ```aws run-instances --image-id <value> --key-name <value>
--security-groups <value>```


- Show instances ```aws describe-instances```

- Stop an instance ```aws terminate-instances --instance-ids <value>```
</section>

<section class="small">
# Useful commands (2)

- Create a security group
```aws create-security-group --group-name <value> --description <value>```

- Add a rule ```aws ec2 authorize-security-group-ingress --group-name <value> --protocol tcp --port <value> --cidr <value>```

- Delete a rule ```aws revoke-security-group-ingress --group-name <value> --protocol <value> --port <value> --cidr <value>```
</section>

<section>
# More commands:

- List services supported by AWS CLI: `aws help`

- Help and list of commands for a specific service: `aws s3 help`

</section>
</section>

<section>
<section>
# Euca2ools
</section>

<section>
# Installation

- Via your packet manager:
  - `apt-get install euca2ools`
  - `yum install euca2ools`
  - `brew install euca2ools`

- Manual (requires Python 2.6+, Boto and M2Crypto)
  - `curl –O http://downloads.eucalyptus.com/software/euca2ools/3.1/source/euca2ools-3.1.1.tar.xz`
  - `tar xvfz ./euca2ools-3.1.1.tar.xz`
  - `cd euca2ools-3.1.1`
  - `sudo python setup.py install`

</section>

<section>
# Configuration

In `~/.euca/conf.ini`

~~~~~~~~
[global]
default-region = <region>

[user default]
key-id = XXX
secret-key = XXX

[region aws:*]
user = default

[region aws:eu-west-1]
ec2-url = https://ec2.<region>.amazonaws.com
~~~~~~~~

</section>
</section>

<section>
<section>
# Misc commands
</section>

<section class="small">
## List regions

- euca-tools:  
```euca-describe-regions```

- aws cli:  
```aws ec2 describe-regions```

## List availability zones in a region

- euca-tools:  
```euca-describe-availability-zones```

- aws cli:  
```aws ec2 describe-availability-zones```

</section>

<section>
##Manage Key-Pairs
</section>

<section>
## Create a SSH key-pair

- euca-tools:  
```euca-create-keypair <key-pair name>```

- aws cli:  
```aws ec2 create-key-pair –key-name <key-pair name>```

</section>

<section>
## Import an existing SSH key-pair

- euca-tools:  
```euca-import-keypair -f <public key file> <key-pair name>```

- aws cli:  
```aws ec2 import-key-pair --public-key-material <public key file> –-key-name <key-pair name>```

</section>

<section>
## List key-pairs

- euca-tools:  
```euca-describe-keypairs```

- aws cli:  
```aws ec2 describe-key-pairs```

</section>

<section>
## Manage instances
</section>

<section>
## List instances

- euca-tools:  
```euca-describe-instances```

- aws cli:  
```aws ec2 describe-instances```

</section>

<section>
## Get details about an instance

- euca-tools:  
```euca-describe-instances <id>```

- aws cli:  
```aws ec2 describe-instances --instances-ids <id>```

```aws ec2 discribe-instances --filters "Name=instance-type,Value=m1.small"```

</section>

<section>
## Run an instance

- euca-tools:  

~~~~~~~~~~
euca-run-instances <ami id> \
	--region eu-west-1 -g <sec-group name> \
	-t <instance type> -k <key-pair name> -n 4
~~~~~~~~~~

- aws cli:  

~~~~~
aws ec2 run-instances --image-id <ami id> \
	--security-groups <sec-group name> \
	--instance-type <instance type>  --key-name <key-pair name> \
	--count 4
~~~~~

</section>

<section class="small">
## Pause an instance

- euca-tools:
```euca-stop-instances <id>```

- aws cli:
```aws ec2 stop-instance –-instance-ids <id>```

## Resume an instance

- euca-tools:
```euca-start-instances <id>```

- aws cli:
```aws ec2 start-instance –-instance-ids <id>```

</section>

<section class="small">
## Terminate an instance

- euca-tools:  
```euca-terminate-instances <id>```

- aws cli:  
```aws ec2 terminate-instances –-instance-ids <id>```

## Reboot an instance (EBS-backed only)

- euca-tools:
```euca-reboot-instances <id>```

- aws cli:
```aws ec2 reboot-instances –-instances-ids <id>```

</section>

<section>
## SSH into an instance

```ssh -i <key file> <user>@<ip or dns>```

Depending on the AMI, `user` can be `ec2-users`, `ubuntu`, …

</section>

<section>
## Network
</section>

<section>
## Create a security group

- euca-tools:  
```euca-create-group <group name> --description "<description>"```

- aws cli:  
```aws ec2 create-security-group –-group-name <group name> -–description "<description>"```

</section>

<section>
## Add a rule

- euca-tools:

~~~~~~~~~~
```euca-authorize <group name> -P tcp -p <port> -s 0.0.0.0/0```
~~~~~~~~~~

- aws cli:

~~~~~~~~~~
aws ec2 authorized-security-group-ingress –-group-name <group name> \
	–-protocol tcp –-port <port> –-cidr 0.0.0.0/0
~~~~~~~~~~

(Optional `--egress`, ingress by default.)
</section>

<section>
## Delete a rule

- euca-tools:  

~~~~~~~~~~
euca-revoke <group name> -P tcp -p <port> -s 0.0.0.0/0
~~~~~~~~~~

- aws cli:  

~~~~~~~~~~
aws ec2 revoke-security-group-ingress –-group-name <group name> \
	–-protocol tcp –-port <port> –-cidr 0.0.0.0/0
0.0.0.0/0
~~~~~~~~~~

(Optional `--egress`, ingress by default.)
</section>

<section>
## Delete a security group

- euca-tools:
```euca-delete-group <group name>```

- aws cli:
```aws ec2 delete-security-group –-group-name <group name>```

</section>

<section class="small">
## Allocate a fixed IP

- euca-tools:
```euca-allocate-address```

- aws cli:
```aws ec2 allocate-address```

## Free a fixed IP

- euca-tools:
```euca-release-adress <ip>```

- aws cli:
```aws ec2 release-address –-public-ip <ip>```

</section>

<section>
## Allocate a fixed IP to an instance

- euca-tools:
```euca-associate-address -i <id> <ip>```

- aws cli:
```aws ec2 associate-address –-instance-id <id> --public-ip <ip>```

</section>

<section>
## Detach a fixed IP from an instance

- euca-tools:
```euca-deassociate <ip>```

- aws cli:
```aws ec2 disasscotiate-address –public-ip <ip>```

</section>

<section>
## Block storage
</section>

<section>
## Create a volume

- euca-tools:  
```euca-create-volume --zone <avail. zone> --size <size in GB>```

- aws cli:  
```aws ec2 create-volume –-availability-zone <avail. zone> –-size <size in GB>```

</section>

<section>
## Attach a volume to an instance

- euca-tools:  
```euca-attach-volume -i <instance id> -d <device> <volume-id>```

- aws cli:  
```aws ec2 attach-volume –-instance-id <id> --volume-id <volume-id> --device <device>```

</section>

<section>
## Detach a volume from an instance

- euca-tools:  
```euca-detach-volume -i <instance id> <volume-id>```

- aws cli:  
```aws ec2 detach-volume –instance-id <id> --volume-id <volume-id>```

</section>

<section>
## Detach a volume from all instances

- euca-tools:  
```euca-detach-volume <volume-id>```

- aws cli:  
```aws detach-volume –-volume-id <volume-id>```

**Note:** attaching an EBS volume to multiple instances
is generally a bad idea!

</section>

<section>
## Delete a volume

- euca-tools:  
```euca-delete-volume <volume-id>```

- aws cli:  
```aws ec2 delete-volume –-volume-id <volume-id>```

</section>

<section>
## Create a snapchot

- euca-tools:  
```euca-create-snaphot <volume-id>```

- aws cli:  
```aws ec2 create-snapshot –-volume-id <volume-id>```

**Tip:** successive snapchots are created incrementally.

Snapchots are created asynchronously.
</section>

<section>
## Create a volume from a snapchot

- euca-tools:  
```euca-create-volume --zone <avail. zone> --snapshot <snapshot-id>```

- aws cli:  
```aws ec2 create-volume –-availability-zone <avail. zone> --snapshot-id <snapshot-id>```

</section>

<section>
## Get information from a snapchot

- euca-tools:  
```euca-describe-snapshots <volume-id>```

- aws cli:  
```aws ec2 describe-snapshots –-snapshot-id <snapshot-id>```

</section>

<section>
## Delete a snapchot

- euca-tools:  
```euca-delete-snapshot <volume-id>```

- aws cli:  
```aws ec2 delete-snapshot –-snapshot-id <snapshot-id>```

</section>

<section>
## Format a mounted EBS volume

```mkfs.ext4 /dev/sdb && mount /dev/sdb/ /mnt/disk1```

**Note:** it is recommended to unmount EBS volumes while
creating a snapchot to avoid data corruption.

</section>
</section>

<section>
<section>
# S3Cmd

#### A swiss army knife for S3
</section>

<section>
# Installation

1. `sudo pip install s3cmd`
2. Done

# Configuration

- Interactive setup: `s3cmd --configure`
- Configuration stored in `$HOME/.s3cfg`
</section>

<section>
# Managing buckets

- List buckets: `s3cmd ls`
- Create a bucket: `s3cmd mb s3://<bucket>`
- List the content of a bucket `s3cmd ls S3://<bucket>`
</section>

<section>
# Managing files

- Upload to a bucket: `s3cmd put <file> s3://<bucket>`
- Upload to a bucket: (public file): `s3cmd put --acl-public --guess-mime <file> s3://<bucket>`
- Download from a bucket: `s3cmd get s3://<bucket>/<file>`
</section>

<section>
# Managing files (2)

- Remove a file: `s3cmd del s3://<bucket>/<file>`
- Remove a bucket (must be empty): `s3cmd rb s3://<bucket>`
- Copy a file `s3cmd cp s3://<bucket>/<file>  s3://<other bucket>/`
- Move a file `s3cmd mv s3://<bucket>/<file>  s3://<bucket>/<file>`
</section>

<section>
# Managing files (3)

- Get info about a file: `s3cmd info s3://<bucket>`
- Show used disk space: `s3cmd du s3://<bucket>`
- Synchronize a directory with a bucket (similar to [rsync](https://rsync.samba.org/examples.html)): `s3cmd sync test/ s3://<bucket>/`
</section>
</section>

