# sport-model

Working on the next generation of SportsML, based on semantic web technology.

## About the IPTC Sport Model

It is currently a work in progress. We are experimenting with different
approaches based on a set of use cases documented at
https://github.com/iptc/sport-model/wiki/Use-Cases .

We are creating an RDF model that represents schedules, statistics and results
for all levels of all sports, for both human and machine consumption.

## Project goals and principles

We want the resulting data model and vocabulary to be:

* **Comprehensive** - it should be able to handle schedules, results and
statistics for many sports (team, individual and head-to-head)
* **Easy to use** - should be approachable by non-experts in Semantic Web
technologies, e.g. the JSON-LD versions should be simple enough to be parsed by
any competent developer who is comfortable with handling JSON files.
* **Easy to query** - for those who want to use the power of RDF features such
as SPARQL, querying data should be as simple as possible.
* **Compatible with schema.org** - we want this vocabulary to be self-contained
but it should be possible to use it alongside schema.org in the future.

## Repository layout

`queries`:

Contains sample SPARQL queries exercising some of the use cases.

`samples/{n3|ttl|jsonld}/`:

Contains example data files in RDF N3, Turtle (`.ttl`) and JSON-LD formats.

`samples/xml/sportsml`:

Examples in SportsML, to be converted to N3 using the XSLT script in `tools`.

`tools`:

We have created a Bash script which uses the Saxon XSLT processor to convert
SportsML example files in XML to N3 triples and then uses Apache Jena to convert
the N3 to the more readable Turtle (TTL) and JSON-LD formats.

This repository contains the converted files, but if you need to convert them
again, simply run:

```bash
tools/convert-sportsml-to-rdf.sh
```

If you want to try converting an individual N3 file yourself, you can use Jena's
`riot` tool directly:

```bash
riot --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-01.n3
riot --formatted=JSON-LD samples/ttl/soccer-match-01.ttl
```

Note that the JSON-LD files include the `@context` section at the bottom of the
file, whereas most JSON-LD examples include `@context` at the top. This is an
artefact of the Jena JSON-LD generator and doesn't affect the usefulness of the
data files.

## More detailed documentation

We have some guides regarding how to use the SportRDF model

* [Running the example queries](docs/running-example-queries.md)
* [Running a SPARQL endpoint](docs/sparql-endpoint.md)
* [Validating SportsRDF data with SHACL](docs/validation-with-shacl.md)
