---
title: Amazon Web Services − Images provisioning
theme: amazon
---

{::options parse_block_html="true" /}

<section>
# Amazon Web Services

<img class="clean" src="../../img/aws_logo.png" />

## Images provisioning
</section>

<section>
# Outline

- Provisioning
  - Bake vs Fry

- Customize an existing AMI
  - User-data
  - Cloud-init

- Generate your own AMIs
  - Boxgrinder
  - Ubuntu-vm-builder
  - Windows?
</section>

<section>
<section>
# Bake vs. Fry
</section>

<section class="small">
# 2 approaches

<div class="left-column" style="width: 49%;">
**Bake**

Appliance prepared beforehand

Advantages:

- Faster deployment
- Fits your needs right away

Disavantages:

- Updates
- Larger images

</div>

<div class="right-column" style="width: 49%;">
**Fry**

A generic appliance is configured at boot-time

Advantages:

- Easy to achieve

Disadvantages:

- Slower deployment
</div>
</section>

<section>
# Pro tip: combine both

- **Generate** a custom image on a **schedule**
- **Finish** configuration at **boot-time** (updates, config files, etc.)

- No need to regenerate everything each time a VM is run
- The image can serve as a minimal starting point for several applications
  - Without useless componants

</section>
</section>

<section>
<section>
# Customize an AMI

An AMI: **appliance** + **meta-data**

- a unique identifier in a region
- multiple kinds:
  - Public
  - Paid ([marketplace](https://aws.amazon.com/marketplace))
  - Private
</section>

<section class="small">
# EBS backed vs. Instance-store

<div class="left-column" style="width: 49%;">
**EBS backed**

- root on EBS
- can be paused to save money
- faster to start
- storage saved (even in case of faults)
- up to 1 TB!
- possibility to change instance type at runtime
</div>

<div class="right-column" style="width: 49%;">
**Instance-store**

- Root on **S3**
- cannot be paused
- cheaper
- storage lost in case of fault
- up to 10 GB
</div>
</section>

<section>
# User data

- Can be data or a script
- Limited to 16 KB
- Can be base64-encoded
- Accessible via HTTP from the instance

```curl http://169.254.169.254/latest/meta-data/user-data```
</section>
</section>

<section>
<section>
# Boxgrinder
</section>

<section>
# Principle

- YAML description
- Generates multiple appliance formats (KVM, VMWare, Xen, EC2, VirtualBox)
- Deployment (EC2, OpenStack, <span data-placement="left" data-toggle="popover" data-trigger="focus"
title="libvirt"
tabindex="0" role="button"
data-content="A generic toolkit to interact with
multiple virtualization technologies. Includes a C library
and binding for many languages. Supports Xen, Qemu, VMWare,
Virtualbox, OpenVZ and LXC (containers), etc.">libvirt</span>)
- **Test VMs locally** before deploying them in your cloud
</section>

<section>
# Support

- Supports mainly **RedHat**-based distributions
- **But:** cross-OS builds
  - &ldquo;Build a CentOS or RHEL from a Fedora Host&rdquo;
- Community plugins
  - Ubuntu: <https://github.com/rubiojr/boxgrinder-ubuntu-plugin>
</section>

<section style="text-align: center;">
# Boxgrinder

![Boxgrinder workflow](../../img/boxgrinder.png)
</section>

<section>
# Usage

- Create a KVM appliance
```boxgrinder-build centos.appl```

- Create an appliance and deploy run it in VirtualBox
```boxgrinder-build centos.appl -p virtualbox -d local```

</section>

<section>
# Usage

- Create an appliance and run it _via_ libvirt:

~~~~~~~~~~
boxgrinder-build definition.appl \
    -d libvirt --delivery-config \
    connection_uri:qemu:///system,\
    image_delivery_uri:/var/lib/libvirt/images
~~~~~~~~~~

</section>

<section>
# AWS Configuration

2 sections in `$HOME/.boxgrinder/config`

**S3**

~~~~~~~~~~
access_key: <ACCESS_KEY>
secret_access_key: <SECRET_ACCESS_KEY>
bucket: <BUCKET>
account_number: <ACCOUNT_ID> # see security credentials page
path: /
cert_file: /home/me/.boxgrinder/cert-2GDSYWYSIVXTZIDBLYZTAOX4KW.pem
key_file: /home/me/.boxgrinder/pk-2GFVVWYSIVXTZIDBLYZTAOX4KW.pem
region: eu-west-1
~~~~~~~~~~

**EBS**

~~~~~~~~~~
access_key: <ACCESS_KEY>
secret_access_key: <SECRET_ACCESS_KEY>
account_number: <ACCOUNT_ID>
delete_on_termination: true
region: eu-west-1
availability_zone: eu-west-1a
~~~~~~~~~~

</section>

<section>
#  Deploying on EC2

- Deploy an instance-store AMI (S3)

~~~~~~~~~~
boxgrinder-build centos58.appl -p ec2 -d ami
~~~~~~~~~~

- Deploy an EBS AMI

~~~~~~~~~~
boxgrinder-build centos63.appl \
    -p ec2 -d ebs \
    --delivery-config overwrite:true,\
    destroy_instances:true
~~~~~~~~~~

</section>

<section>
# Appliance file

~~~~~~~~~~
name: "centos58-#BASE_ARCH#-jeos"
summary: CentOS 5 Core
version: 1
release: 0

os:
  name: centos
  version: 5 
  password: centos

hardware:
  partitions:
    "/":
      size: 8
~~~~~~~~~~
</section>

<section class="small">
# Appliance file (2)

~~~~~~~~~~
packages:
  - @core
  - cloud-init
  - httpd
  - mysql-server
  - php-mysql
  - openssh-server

repos:
  - name: "EPEL"
    baseurl: "http://download.fedoraproject.org/pub/epel/5/#BASE_ARCH#/"

post:
  base:
    - /sbin/chkconfig httpd on
    - /sbin/chkconfig mysqld on
    - /sbin/chkconfig cloud-init on

~~~~~~~~~~
</section>
</section>

<section>
<section>
# Ubuntu VM-Builder
</section>

<section>
# Principle

Create Ubuntu-based appliances

- Also supports Debian _testing_
- Supports:
  - Hypervisors: KVM, Xen, VirtualBox, VMWare
  - Deployment: libvirt, EC2
</section>

<section>
# Installation

```apt-get install ubuntu-vm-builder python-vm-builder-ec2```
</section>

<section>
# Generate an appliance

General syntax:  
```vmbuilder <hypervisor> <distribution>```

Generate and deploy an appliance

~~~~~~~~~~
vmbuilder kvm ubuntu --suite lucid \
    --arch amd64 \
    --libvirt qemu://system
~~~~~~~~~~

</section>

<section>
# Generate an appliance (2)

- With a pre-configured user  
```vmbuilder kvm ubuntu --user bob --password toto```

- With installed packets

~~~~~~~~~~
vmbuilder kvm ubuntu --addpkg apache2 \
    --addpkg libapache2-mod-php5 \
    --addpkg php5-mysql 
~~~~~~~~~~

</section>

<section>
# Create an appliance and upload it to S3

~~~~~~~~~~
sudo vmbuilder xen ubuntu --suite=karmic --ec2 \
  --ec2-cert=<ec2 cert> \
  --ec2-key=<ec2 key> \
  --ec2-access-key=<aws access key> \
  --ec2-secret-key=<aws secret key> \
  --ec2-user=<aws # number> \
  --ec2-bucket=<ec2 bucket name> \
  --ec2-prefix=<image prefix> \
  --ec2-version="Description of your EC2 image" \
  --firstboot=/usr/share/doc/python-vm-builder-ec2/examples/ec2-firstboot.sh \
  --part=/usr/share/doc/python-vm-builder-ec2/examples/ec2-<arch>-part-file.txt
~~~~~~~~~~

</section>
</section>

<section>
<section>
# Cloud-init
</section>

<section>
# Cloud-init

- Developped by Canonical ([doc](https://cloudinit.readthedocs.io/en/latest/))
- Fetches user-data
- Works arround the size limit
  - Preconfigured actions
  - Compression
  - Concatenation of resources (mime-type encoding)
- Pre-installed on official Amazon AMIs
</section>

<section>
# Some actions

- Set the locale
- Set the hostname
- Generate a key-pair
- Add keys to `$HOME/.ssh/authorized_keys`
- Mount volumes

</section>

<section class="small">
# Cloud-init inputs

- Compressed (Gzip) files
- Mime multipart files
- User-data script
  - Starting with `#!` or `Content-Type: text/x-shellscript`
- Cloud-config file
  - Starting with `#cloud-config` ou `Content-Type: text/cloud-config`
  - Predefined action, in YAML format
- Include file
  - Starting with `#include` ou  `Content-Type: text/x-include-script`
  - One URL (file) per line

</section>

<section>
# \#Cloud-config example

~~~~~~~~~~
#cloud-config
package_update : true 
package_upgrade : true
packages :
  - apache2
apt_sources : 
  - source :deb http://archive.ubuntu.com/ubuntu karmic main …
ssh_authorized_keys :
  - ssh-rsa "<ssh public key>"
locale : fr_FR.UTF-8
runcmd :
  - echo "hello world !" > /home/ubuntu/message
~~~~~~~~~~

</section>

<section>
# Include example

~~~~~~~~~~
#include
http://emn.fr/download/ec2-config.txt
ftp://emn.fr/download/vhost.conf
~~~~~~~~~~

</section>

<section>
# Generating a multipart user-data file

Using the `write-mime-multipart` utility (package with cloud-init):

~~~~~~~~~~
write-mime-multipart –output=combined-userdata.txt \
   my-include.txt:text/x-include-url \
   my-user-script.txt:text/x-shellscript \
   my-cloudconfig.txt
~~~~~~~~~~

</section>
</section>

<section>
<section>
# Windows AMIs
</section>

<section>
# Prepare to suffer

- Creating a Windows AMI from scratch is a delicate process
- Recommanded method:
  - Run a Windows instance
  - Customize it by hand
  - Create a bundle from the CLI or Web Console
  - Save it
  - <http://docs.aws.amazon.com/workspaces/latest/adminguide/bundle_tutorial.html>

- Possibility to create the initial setup with the [EC2Config
  service](http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/UsingConfig_WinAMI.html)
  (PowerShell)
- Rather long process (expect no less than 15 minutes to get the admin password)
</section>

<section>
# How-to: short version

- CLI or Web console
- Applies to other OS as well
</section>

<section>
# EBS images

- Create an image from an EBS: `euca-create-image -n <name> <instance-id>`
- Make the image public: `euca-modify-image-attribute <ami-id> -l -a all`
- Or private: `euca-modify-image-attribute <ami-id> -l -r all`
- Delete the image `euca-deregister <ami-id>`
</section>

<section>
# Instance-store images

- Save the image in S3: `euca-bundle-instance <id> --bucket <bucket> --prefix <bundle-name>`
- Register it as an AMI: `euca-register <bucket>/image.manifest.xml -n <ami-name>`
</section>

</section>

