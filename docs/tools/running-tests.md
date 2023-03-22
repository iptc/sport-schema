---
permalink: /tools/running-tests/
title: Running unit tests
layout: page
nav_order: 2
parent: Working with IPTC Sport Schema
---
# Running IPTC Sport Schema Unit Tests

While creating the IPTC Sport Schema, we wanted to make sure that we weren't "breaking
the model" each time we made a change to the ontology, and that example SPARQL queries
would still work.

So we built a simple framework to help with our design process.

We created a set of SPARQL queries, each in a text file. They correspond to our
[use cases](/use-cases/). You can see the raw files at
[https://github.com/iptc/sport-schema/tree/main/queries](https://github.com/iptc/sport-schema/tree/main/queries).

Each of the SPARQL queries has a corresponding "expected output" file:
[https://github.com/iptc/sport-schema/tree/main/queries/output/](https://github.com/iptc/sport-schema/tree/main/queries/output/).

We then create a [simple Shell script](https://github.com/iptc/sport-schema/blob/main/tools/run-test-queries.sh)
to run each of the queries against our sample data, and compare the output against its
"expected output" file.

If there is a difference between the two, we know that something has gone wrong.

## "Sanity checking" queries

We have also created some queries related to the model itself, and "sanity checking" our sample data.

These queries include:
* [classes-in-ontology-but-not-used.rq](https://github.com/iptc/sport-schema/blob/main/queries/classes-in-ontology-but-not-used.rq)
* [classes-in-ontology.rq](https://github.com/iptc/sport-schema/blob/main/queries/classes-in-ontology.rq)
* [classes-not-in-ontology.rq](https://github.com/iptc/sport-schema/blob/main/queries/classes-not-in-ontology.rq)
* [classes-used.rq](https://github.com/iptc/sport-schema/blob/main/queries/classes-used.rq)
* [classes-with-no-name.rq](https://github.com/iptc/sport-schema/blob/main/queries/classes-with-no-name.rq)
* [objects-with-no-type.rq](https://github.com/iptc/sport-schema/blob/main/queries/objects-with-no-type.rq)
* [properties-in-ontology-but-not-used.rq](https://github.com/iptc/sport-schema/blob/main/queries/properties-in-ontology-but-not-used.rq)
* [properties-not-in-ontology.rq](https://github.com/iptc/sport-schema/blob/main/queries/properties-not-in-ontology.rq)
* [properties-used.rq](https://github.com/iptc/sport-schema/blob/main/queries/properties-used.rq)
* [sports-used.rq](https://github.com/iptc/sport-schema/blob/main/queries/sports-used.rq)
* [subjects-with-no-type.rq](https://github.com/iptc/sport-schema/blob/main/queries/subjects-with-no-type.rq)

## Running the tests locally

If you have checked out the repository, you can run the unit tests by simply running the shell script:

    tools/run-test-queries.sh 
