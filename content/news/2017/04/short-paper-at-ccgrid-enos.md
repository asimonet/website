---
kind: article
title: >
  Short paper at CCGrid 2017: "Toward a Holistic Framework for Conducting
  Scientific Evaluations of OpenStack"
created_at: 2017/04/19
tags: publications conferences
---

Our group in the Discovery Initiative has a new paper that is to appear at the
[CCGrid 2017](https://www.arcos.inf.uc3m.es/ccgrid2017/){:target="_blank"}
conference in Barcelona next month, where I will present it.

The paper, titled "Toward a Holistic Framework for Conducting Scientific
Evaluations of OpenStack" was coauthored with Ronan-Alexandre Cherrueau, Dimitri
Pertin, Adrien Lebre and Matthieu Simonin.
<!--more-->

It makes the case for building integrated software evaluation frameworks for
large distributed systems and proposes a design, a prototype implementation of
such framework, [Enos](https://github.com/BeyondTheClouds/enos/) and an
evaluation with a complex scenario that involves deploying OpenStack from
scratch and evaluating it under various topologies and circumstances.
<br />
Enos is able to deploy OpenStack on a distributed infrastructure based on a high
level description of where the service should be placed (isolated, co-located
with other services) and of the network (bandwidth and latency control).
Once deployed, test suites can be executed seemlessly and a number of metrics
can be recorded and visualized. Enos then makes it easy to share the raw metrics
and interactive visualisations as a virtual appliance, for others to exploit.
<br />
I strongly encourage you to check out the code and examples if you are
experimenting with OpenStack in particular, or with any software that takes you
way too much effort to deploy, evaluate and re-deploy&hellip;

The full text is available [here](/download/enos_ccgrid_2017.pdf "Download full
text").
