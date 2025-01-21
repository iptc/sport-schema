#!/bin/bash

# Validate against RDF Schema
riot --validate --rdfs=ontologies/iptc-sport-merged-ontology.ttl examples/*

# Validate with SHACL
tools/shacl-validate.sh examples/*
