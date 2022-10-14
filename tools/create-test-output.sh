#!/bin/bash

# Run queries against all sample data, saving
# the output so we can compare it in tests.
# Only needs to be run when the data files or
# queries are updated.

TTL_SAMPLES_DIR='samples/ttl'
SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-ontology.ttl'
REGEX_FOR_VALID_FILES='conforms  *true'

# build list of data files to use in sparql queries
# start with the ontology file so it can also be used in test queries
DATA_STRING="--data ${SPORT_ONTOLOGY_FILE}"
for filename in ${TTL_SAMPLES_DIR}/*.ttl; do
    DATA_STRING="${DATA_STRING} --data=$filename"
done

if [[ $# -eq 1 ]]; then
    queryfiles=($1)
else
    queryfiles=(queries/*.rq)
fi

for queryfile in "${queryfiles[@]}"; do
    name=${queryfile##*/}  # get part after last /
    base=${name%.rq}     # strip off .xml extension
    echo "Creating output file for ${base}..."
    sparql ${DATA_STRING} --query=$queryfile >queries/output/$base.out
done
