---
kind: article
title: >
  Paper at IC2E 2017: "Revising OpenStack to Operate Fog/Edge
  Computing Infrastructures"
created_at: 2016/11/28
tags: publications conferences
---

Our paper "Revising OpenStack to Operate Fog/Edge Computing
Infrastructures" is to appear at the _IEEE International
Conference on Cloud Engineering_ ([IEEE
IC2E](http://conferences.computer.org/IC2E/2016/){:target="_blank"})
conference that will take place in Vancouver, Canada in early April 2017.
<!--more-->

This paper, coauthored with Adrie Lebre, Jonathan Pastor and Frederic Desprez,
presents and eveluates a design for a highly distributed **OpenStack** suited for
Fog/Edge Computing.<br />
The infrastructures considered here are composed of numerous small data centers
that are volatile (they mail fail/recover at any time) and geographically
distributed over large territories (potentially implying high latencies).
**OpenStack** has two main blocking points to operate such infrastructures that are
the message bus (**RabbitMQ**) and the SQL backend (**MariaDB**, a fork of MySQL).<br />
Here we address the SQL backend: when subject to network latencies higher than
10ms, the performance of Galera (the synchronous replication-based cluster
solution for MySQL) collapse. We propose and eveluate an **OpenStack** deployment
where MariaDB is replaced with the **Redis** NoSQL database and

Like most of my current work, this research is part of and funded by the
[Discovery Initiative](http://beyondtheclouds.github.io/){:target="_blank"}.

The full text is available [here](/download/discovery_ic2e_2017.pdf "Download full
text").
