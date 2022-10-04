#!/bin/bash

# Merge ontology files into one schema file
# which can be used for query tests.

CORE_SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-ontology.ttl'
MERGED_SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-merged-ontology.ttl'

DATA_STRING="${CORE_SPORT_ONTOLOGY_FILE}"
for filename in ontologies/*statistics.ttl; do
    DATA_STRING="${DATA_STRING} $filename"
done

cat ${DATA_STRING} >${MERGED_SPORT_ONTOLOGY_FILE}
