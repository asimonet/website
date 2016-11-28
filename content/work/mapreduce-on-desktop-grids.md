---
title: MapReduce on Desktop Grids
parent: /Work/
author: Anthony SIMONET
description: Tutorial on how to deploy a MapReduce framework on a Desktop Grid with BitDew. Examples are given for the Grid'5000 experimental testbed.
---



The MapReduce implementation on top of BitDew is the result of the work of several people and presents a set of unique features. The key one is
its ability to work on Desktop grid architectures and benefit of close-to-free computing and storage resources.

A tutorial is available [here](/misc/bitdew-mapreduce/ WordCount Tutorial). It will guide you
through the required steps to run the WordCount experiment on [Grid'5000](http://www.grid5000.fr){:target="_blank"}. Below are the files you will
need.

# Files

* [bitdew-0.2.2.tar.gz](/download/bitdew-0.2.2.tar.gz "bitdew-0.2.2.tar.gz")
* [bitdew-mapreduce.tar.gz](/download/bitdew-mapreduce.tar.gz "bitdew-mapreduce.tar.gz")
* [wordcount_ftp.tar.gz](/download/wordcount_ftp.tar.gz "WordCount Linux image")

# Features

Thanks to the BitDew middleware, integrating the following features in our MapReduce implementation was fairly costless:

* Works through firewalls and NAT;
* Massive fault tolerance;
* Barrier-free execution;
* Able to work with high latencies.

# Technical and implementation details

Here we discuss how we used the BitDew framework to implement MapReduce. We first give a high-level implementation. We will then discuss
the implementation details.

## The big picture

In a typical MapReduce execution, we place the BitDew services on one or more stable nodes and workers on unstable nodes. A particular node
will be the MapReduce master and will most likely, for commodity, be placed on a service node.

The master splits the input into several fixed size chunks. These chunks are then registered into BitDew, uploaded and set to be scheduled.
When workers starts, they receive a special Data that tells them they have to run map tasks. Then, they will be scheduled data chunks.

Upon a schedule event, a worker will download the corresponding data file and start a user provided map task. Each worker writes results to
a local intermediate file. When the map task is complete, the intermediate file is registered in BitDew and uploaded.

The master also schedules a certain number of special Data that tells the receiving node it must start reduce tasks as well. So some nodes
will be scheduled and download intermediate files, previously grouped by key by the master. The reducer executes the reduce task and registers
the result as a BitDew Data and uploads it.

When the job is completed, all result files have been uploaded to BitDew.

## In details

The implementation relies on BitDew and a new service, the DM (Data Message). However, the main part of the code (MapReduce mechanics and
MapReduce programs) is in the Role layer of BitDew. The Core layer has also been augmented with Data Collections; Data Collections are objects
that represent a set of Data Chunks and offer an API to perform bulk operations on them.

### Setup

In BitDew − as in most Desktop Grid middleware − nodes are divided in 2 groups: stable nodes and unstable nodes, with different fault models.
Here stable nodes are used to host the BitDew services and the MapReduce master; Unstable nodes are used worker nodes, they run map and reduce
tasks.<br />
We use <img src='http://s0.wp.com/latex.php?latex=N+%2B+1&#038;bg=ffffff&#038;fg=000000&#038;s=0' alt='N + 1' title='N + 1' class='latex' />
nodes, including <em>N</em> workers and <em>1</em> master.

<em>K</em> is the number of partitions, and of reduce tasks. A subset of the workers will run reduce tasks, so
<img src='http://s0.wp.com/latex.php?latex=N+%5Cgeq+K&#038;bg=ffffff&#038;fg=000000&#038;s=0' alt='N \geq K' title='N \geq K' class='latex' />.</p>

### Execution

When the master starts, it splits the <img src='http://s0.wp.com/latex.php?latex=F_%7Bc%7D&#038;bg=ffffff&#038;fg=000000&#038;s=0'
alt='F_{c}' title='F_{c}' class='latex' /> input files into chunks of size <img src='http://s0.wp.com/latex.php?latex=S_%7Bc%7D&#038;bg=ffffff&#038;fg=000000&#038;s=0'
alt='S_{c}' title='S_{c}' class='latex' />. It then schedules them one by one.

Then, it creates and schedules &#8220;Token&#8221; data. These tokens are used to tell the nodes what they must do and and to know where map
and reduce tasks should be scheduled. A token per chunk is created; This way, when a worker is schedule one of these tokens, it will download the
corresponding chunk and apply the map task to it.

The mapper will also apply the Combining method if it was supplied. When the map task is done, writes <em>K</em> files on its local
filesystem according to a partitioning method provided by the user. Data objects are then created and scheduled for these files. When it
schedules these data, it sets their affinity to the token corresponding to their partition, so the reducer will be scheduled all the intermediate
files corresponding to a partition it has to reduce.

The mapper maintains a list of incoming intermediate data and process them once all intermediate results in its partition has been received. The
result file is associated with a data in BitDew, and this data is scheduled with the master attribute. The master will then collects it and stops
whenever all final result files have been received.

# Related publications
[Towards MapReduce For Desktop Grid Computing](http://graal.ens-lyon.fr/~gfedak/thesis/xtremmapreduce.3pgcic10.pdf "Towards MapReduce for Desktop Grid
Computing"){:taget="_blank"}

[Distributed Results Checking for MapReduce in Volunteer Computer](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=6009055 "Distributed Results
Checking for MapReduce in Volunteer Computer"){:target="_blank"}
