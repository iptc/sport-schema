#!/bin/bash

# Validate against RDF Schema
riot --validate --rdfs=ontologies/iptc-sport-merged-ontology.ttl samples/ttl/*

# Validate with SHACL
tools/shacl-validate.sh samples/ttl/*
