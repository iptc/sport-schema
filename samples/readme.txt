This directory contains sports statistical data rendered in the turtle format (.ttl) of RDF and SPARQL files to query them (.rq)

RDF: https://en.wikipedia.org/wiki/Resource_Description_Framework
Turtle: https://en.wikipedia.org/wiki/Turtle_(syntax)
SPARQL: https://en.wikipedia.org/wiki/SPARQL

A handy way to query ttl files is with the ARQ query engine developed by Apache:

https://jena.apache.org/documentation/query/

Here are some sample query commands with arq:

arq --data stats-generic.ttl --query query-team-generic.rq

arq --data stats-specific.ttl --query query-team-specific.rq
