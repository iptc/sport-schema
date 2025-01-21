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

## Project goals and principles

Our goals were to ensure that the model and vocabulary is:

* **Comprehensive** - it should be able to handle schedules, results and statistics for many types of sports, whether team, individual or head-to-head.
* **Easy to use** - should be approachable by non-experts in Semantic Web technologies. For example, the JSON-LD versions should be simple enough that they can be parsed by any competent developer who is comfortable with handling JSON files.
* **Easy to query** - for those who want to use the power of RDF features such as SPARQL, querying data should be as simple as possible.
* **Compatible with schema.org**. We want the IPTC Sport Schema to be self-contained, but it should be possible to use it alongside schema.org in the future.

## Getting started

### Exploring the example data using SPARQL

We have created a set of test data based on many of the sample files from the SportsML specification. The SportsML data, converted to RDF triples via our SportsML-to-Sport Schema XSLT stylesheet, has been uploaded to a server running the Fuseki tool which can be queried using SPARQL, the query language for RDF.

[Explore IPTC Sport Schema SPARQL Playground](http://query.sportschema.org/dataset.html?tab=query&ds=/sport){: .btn .btn-green .fs-5 .mb-4 .mb-md-0 .mr-2 }

If you haven't seen SPARQL before, it's quite simmilar to SQL. We have created some sample queries that can be used without any SPARQL knowledge. 

You can also run the example queries from your local machine using the `arq` tool from the [Apache Jena project](https://jena.apache.org/) (or any other SPARQL-compatible tool).

See the [running example queries](/tools/running-example-queries) page for more detailed information.

## Latest version: Sport Schema 1.1

Released in October 2024, Sport Schema 1.1 contains the following changes:
* Adds Club and TeamMembership types (so a Team can be a member of a Club)
* Add facets support (based on SportsML / NewsCodes facets) so we can now say
that an event is "women's 400 metres relay swimming", not just "swimming"
* Added the ability to link from Athlete to Team via a new teamParticipation
property
* Add an AssociateMembership type so an Associate (such as a coach) can have a
tenure relating to any Agent, including an Athlete or a Team. Previously
Associates were linked to Teams via Participation objects which wasn't
satisfactory.
* Many cleanups to the SHACL Shapes used for validation of data.
