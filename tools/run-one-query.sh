#!/bin/bash

# Run the named query against all sample data.

TTL_SAMPLES_DIR='samples/ttl'
SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-merged-ontology.ttl'
MEDIATOPIC_FILE='vocabularies/mediatopic.ttl'

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <query file>"
    exit
fi
queryfile=$1

# build list of data files to use in sparql queries
# start with the ontology file so it can also be used in test queries
DATA_STRING="--data ${SPORT_ONTOLOGY_FILE} --data ${MEDIATOPIC_FILE}"
for filename in ${TTL_SAMPLES_DIR}/*.ttl; do
    DATA_STRING="${DATA_STRING} --data=$filename"
done

sparql ${DATA_STRING} --query=$queryfile
