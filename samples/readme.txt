This directory contains sports statistical data rendered in various RDF formats.

RDF: https://en.wikipedia.org/wiki/Resource_Description_Framework
Turtle: https://en.wikipedia.org/wiki/Turtle_(syntax)
SPARQL: https://en.wikipedia.org/wiki/SPARQL

A handy way to query ttl files is with the ARQ query engine developed by Apache:

https://jena.apache.org/documentation/query/

Here are some sample query commands with arq:

arq --data soccer-match.n3 --query ../queries/result-of-match.rq

arq --data soccer-match-specific.ttl --query ../queries/result-of-match.rq
