---
permalink: /tools/making-a-sparql-endpoint/
title: Making a SPARQL endpoint 
layout: page
nav_order: 4
parent: Working with IPTC Sport Schema
---
# Making a SPARQL endpoint

Apache Jena contains the TDB2 engine which functions as a local datastore for RDF triples.

Here we document how it can be used to create a local triple store of IPTC Sport Schema data
which can then be queried to test our sample queries.

## Loading data into a TDB2 datastore

`tdb2.tdbloader --loc sportdb samples/ttl/*.ttl`

(note: should we use --graph to load data into a named graph??)

Once the data is loaded into the TDB2 file, it can be queried using the `tdb2.tdbquery` tool:

`tdb2.tdbquery --loc sportdb --query queries/season-team-players.rq`

## Turning the data file into a SPARQL endpoint

If you install Apache Jena's Fuseki package (a separate download from the
[Jena downloads page](https://jena.apache.org/download/index.cgi), then it's easy to
turn the TDB2 file into the data store for a SPARQL server:

`fuseki-server --tdb2 --loc sportdb /sport`

Fuseki has a Web UI, go to `http://localhost:3030/` to explore it.

Through the Web UI, you can enter SPARQL queries and load more data into the system.

IPTC are hosting a test instance of Fuseki at [http://query.sportschema.org/](http://query.sportschema.org/).
This contains the
ontology files, our test data, and some "canned queries" illustrating how to test the
endpoint with SPARQL queries relating to our use cases.

## Querying the SPARQL endpoint over HTTP

When fuseki is running, you can also query the SPARQL endpoint via HTTP requests

For example:

`curl http://localhost:3030/sport/query -X POST --data 'query=%0A%0ASELECT+%3Fsubject+%3Fpredicate+%3Fobject%0AWHERE+%7B%0A++%3Fsubject+%3Fpredicate+%3Fobject%0A%7D%0ALIMIT+25' -H 'Accept: application/sparql-results+json,*/*;q=0.9'`

## Adding reasoning capabilities to the SPARQL engine

Still to come.
