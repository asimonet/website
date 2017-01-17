---
kind: article
title: Publication à ComPAS'2014
created_at: 2014/04/28
tags: publications conferences
---

J'ai récemment présenté un article à la conférence francophone
[ComPAS'2014](http://compas2014.unine.ch "ComPAS'2014"){:target="_blank"}
qui a eu lieu à Neuchâtel, dans la session parallélisme. L'article en question n'est pas une simple traduction d'un autre article en anglais,
il met l'accent sur la nécessité de fournir un modèle pour représenter le cycle de vie des données présentes dans n'importe quel système de
gestion de données distribuées.<!--more-->

Dans cet article j'avance les arguments suivants&nbsp;:

* Le traitement de grands volumes de données rend leur distribution nécessaire de facto, forçant la collaboration de plusieurs infrastructures
	de calcul et de stockage, ainsi que de systèmes qui n'ont pas été conçus pour collaborer ;
* Il est difficile de suivre l'évolution des différentes copies d'une même données dans plusieurs systèmes à la fois. En particuliers,
	différents systèmes utilisent différent schémas pour identifier les données ;
* La nature souvent dynamique des données complique les chose : les jeux de données peuvent grandir, rétrécir, être mis à jour partiellement,
	ce qui nécessite des optimisations particulières qui sont difficiles à implémenter au dessus de plusieurs systèmes non-collaboratifs.

J'avance donc que le modèle de cycle de vie d'Active Data et le prototype qui va avec permettent de représenter formellement comment les données
&laquo;&nbsp;vivent&nbsp;&raquo; dans différents systèmes en même temps et passent d'un système à l'autre. À l'exécution, Active Data rend compte
en direct de l'évolution des données, ce qui permettra d'implémenter facilement des optimisations complexes qui tiennent compte de l'état des
données à un même moment dans plusieurs systèmes.

Le texte de l'article est consultable [ici](/download/renpar_2014.pdf "ComPAS'2014")&nbsp;;
suite à une catastrophe informatique, la présentation est perdue à jamais.
