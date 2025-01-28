#!/bin/bash

# Validate against RDF Schema
riot --validate --rdfs=ontologies/iptc-sport-merged-ontology.ttl examples/* 2>&1

# Validate with SHACL
tools/shacl-validate.sh examples/*
