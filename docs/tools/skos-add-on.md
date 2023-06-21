# Working with Sport Schema - SKOS Add-on

The IPTC Sports Schema utilizes a set of RDF, RDFS, and OWL constructs to create a extensible schema. [SKOS](https://www.w3.org/2004/02/skos/) short for Simple Knowledge Organization System is a popular system for managing knowledge models that contain hiearchy and relationships. Popular industry tools may utizlize SKOS to create and visualize such models. 

The IPTC Sport Schema team has created an add-on that will extend the core Schema so it can be used with such systems.

## SKOS Concepts

Classes that are stand-alone or the first-level of a class hiearchy will now be an sub-class [skos:Concept](http://www.w3.org/2004/02/skos/core#Concept). 

### Concept Example 

```
@prefix rdf:       <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:      <http://www.w3.org/2000/01/rdf-schema#> .
@prefix skos:      <http://www.w3.org/2004/02/skos/core#> .
@prefix sport:     <https://sportschema.org/ontologies/main/> .

sport:Agent rdfs:subClassOf skos:Concept .
```
## SKOS Relationships

The IPTC Sport Schema also defines relationship types between classes. Three SKOS relationship types are leveraged here for hiearchy and relatations. The IPTC defiened relationships will now be a sub-class [skso:broader](https://www.w3.org/2009/08/skos-reference/skos.html#broader), [skos:narrower](https://www.w3.org/2009/08/skos-reference/skos.html#narrower), or [skos:related](https://www.w3.org/2009/08/skos-reference/skos.html#related). 

### SKOS Relationship Example

```
@prefix rdf:       <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:      <http://www.w3.org/2000/01/rdf-schema#> .
@prefix skos:      <http://www.w3.org/2004/02/skos/core#> .
@prefix sport:     <https://sportschema.org/ontologies/main/> .

sport:eventInCompetition rdfs:subPropertyOf skos:broader .
sport:containsEvent rdfs:subPropertyOf skos:narrower .
```

## Instance Level Data

When creating instance level data you may want to create a [skos:ConceptScheme](http://www.w3.org/2004/02/skos/core#ConceptScheme) to attach your concepts. For example, a Concept Scheme such as "Teams" will include teams for a particular competition. A [skos:TopConcept](http://www.w3.org/2004/02/skos/core#TopConcept) pointing to each of your Team instance will allow you to start to build a hierarchical model.

### Instance Example

```
<http://example.com/Sports#ConceptScheme/Teams>
    rdf:type skos:ConceptScheme ;
    rdfs:label "Teams"@en ;
    skos:hasTopConcept <http://example.com/Team/l.nhl.com-t.21> .
```

## Labels

The IPTC Sport Schema utilzies simple labeling using rdfs:label, you may want to consider extending functionality in your system to utilzie [skos:prefLabel](http://www.w3.org/2004/02/skos/core#prefLabel) or [skosxl:prefLabel](http://www.w3.org/2008/05/skos-xl#prefLabel). The rdfs:label can be copied into one of the SKOS label conventions with a small SPARQL Query.

### Label Conversion Example

```
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

INSERT {
  ?subject skos:prefLabel ?label .
}
WHERE {
  ?subject rdfs:label ?label .
}
```
