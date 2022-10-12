---
layout: home
title: Home
nav_order: 1
description: "The next generation of sports data, based on IPTC's SportsML and semantic web principles. A high level model that describes the core elements of competitive sport."
permalink: /
---


# The next generation of sports data
{: .fs-9 }

Based on IPTC's SportsML and semantic web principles
{: .fs-6 .fw-300 }

IPTC Sport Schema is a high-level model that describes the core elements of competitive sport.

[Get started now](#getting-started){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 } [View the project on GitHub](https://github.com/iptc/sport-schema){: .btn .fs-5 .mb-4 .mb-md-0 }

---

{: .warning }
NOTE: Please note that the schema documented on this site is _**not a production ready version of the
Sport Schema**_. We have released our initial work in order to solicit feedback and suggestions
from others. _**Please do not rely on this model for your production work - yet!**_

## Project goals and principles

We want the resulting data model and vocabulary to be:

* Comprehensive - it should be able to handle schedules, results and statistics for many types of sports: team, individual and head-to-head.
* Easy to use - should be approachable by non-experts in Semantic Web technologies. For example, the JSON-LD versions should be simple enough that they can be parsed by any competent developer who is comfortable with handling JSON files.
* Easy to query - for those who want to use the power of RDF features such as SPARQL, querying data should be as simple as possible.
* Compatible with schema.org - we want the IPTC Sport Schema to be self-contained, but it should be possible to use it alongside schema.org in the future.

## Getting started

### Exploring the example data using SPARQL

We have created a set of test data based on many of the sample files from the SportsML specification. The SportsML data, converted to RDF triples via our SportsML-to-Sport Schema XSLT stylesheet, has been uploaded to a server running the Fuseki tool which can be queried using SPARQL, the query language for RDF.

[Explore IPTC Sport Schema SPARQL Playground](http://sport.iptc.org/){: .btn .btn-green .fs-5 .mb-4 .mb-md-0 .mr-2 }

If you haven't seen SPARQL before, it's quite simmilar to SQL. We have created many sample queries that can be used without any SPARQL knowledge. 

You can also run the example queries from your local machine using the arq tool from the Apache Jena project (or other SPARQL tools).

See the [running example queries](running-example-queries) page for more detailed information.

