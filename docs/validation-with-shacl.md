# Validating SportsRDF files with SHACL

We are working on a SHACL Shapes file that describes how SportsRDF* files
should be constructed and warns users if they have created an invalid
RDF graph.

## Why SHACL?

RDF Schema, the technology we have used for the ontology file, describes
how the classes and properties relate to each other, but by definition
RDF Schema does not specify whether a triple is "valid" or not - for example,
misspelling a property name is not an error under RDF Schema.

Using OWL instead of (or as well as) RDF Schema doesn't solve this problem,
as OWL works the same way (but with a more expressive ontology definition
language).

The W3C's recommended way of validating triple sets is
https://www.w3.org/TR/shacl/[SHACL - the Shapes Constraint Language]. SHACL
is designed to function as a validator for RDF graphs.

## The SHACL Shape for IPTC Sport RDF

Our SHACL file (or "shape") is located in this repository at
`ontologies/iptc-sport-shacl.ttl`.

Currently it 
## Validating triple sets against SHACL on the command line

The Jena command-line tools can be used to validate triple sets against RDF
graphs.

For example:

```bash
% shacl validate --shapes ontologies/iptc-sport-shacl.ttl --data samples/ttl/soccer-match-01.ttl 
@prefix rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix sh:   <http://www.w3.org/ns/shacl#> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .

[ rdf:type     sh:ValidationReport ;
  sh:conforms  true
] .
```

Currently, our SHACL Shape constrains several properties to use only terms from
our IPTC NewsCodes controlled vocabularies, through the use of regular expressions.

This means that the following Turtle would trigger a validation error:

```ttl
# invalid
<http://example.com/Participation/WC-2017-e.958051-T280>
    a                      sport:TeamParticipation ;
    spstat:event-outcome   "draw" .
```

Only a term from the controlled vocabulary would validate:

```ttl
# valid
<http://example.com/Participation/WC-2017-e.958051-T280>
    a                      sport:TeamParticipation ;
    spstat:event-outcome   <http://cv.iptc.org/newscodes/speventoutcome/tie> .
```

To run the SHACL validator over all sample files in the repository, we have written
a small shell script that helps:

```bash
tools/shacl-validate.sh
```
