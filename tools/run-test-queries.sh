#!/bin/bash

# Run queries against all sample data, ensure that
# the output is what we expect by comparing it to
# the results in the queries/output directory.

TTL_SAMPLES_DIR='samples/ttl'
SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-ontology.ttl'
REGEX_FOR_VALID_FILES='conforms  *true'

# handle error in the case that the glob returns null
shopt -s nullglob

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
    queryname=${queryfile##*/}  # get part after last /
    base=${queryname%.rq}     # strip off .xml extension
    temp_file=$(mktemp)
    sparql ${DATA_STRING} --query=$queryfile >${temp_file}
    echo "Comparing results for query ${queryname}"
    # Compare our query results against previously saved version
    diff queries/output/$base.out ${temp_file}
done
