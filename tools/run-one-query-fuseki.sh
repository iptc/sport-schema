#!/bin/bash

# Run the named query against all sample data.

TTL_SAMPLES_DIR='samples/ttl'
SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-merged-ontology.ttl'
MEDIATOPIC_FILE='tools/iptc-mediatopic.ttl'
TIMEOUT=600000 # global timeout - 600s

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <query file>"
    exit
fi
queryfiles=($1)

# start a local, in-memory-only fuseki server
#nohup fuseki-server --mem -rdfs ${SPORT_ONTOLOGY_FILE} /sporttest >/dev/null 2>&1 &
nohup fuseki-server --mem /sporttest >/dev/null 2>&1 &
# noisy/verbose version
# fuseki-server --mem -rdfs ${SPORT_ONTOLOGY_FILE} --timeout ${TIMEOUT} /sporttest &
sleep 2 # to give it time to start up
serverPID=$!

# load our source data into the temporary Fuseki instance
# start with the ontology file and mediatopics file so
s-post http://localhost:3030/sporttest/data default ${SPORT_ONTOLOGY_FILE}

s-post http://localhost:3030/sporttest/data default ${MEDIATOPIC_FILE}

for filename in ${TTL_SAMPLES_DIR}/*.ttl; do
    s-post http://localhost:3030/sporttest/data default ${filename}
done

for queryfile in "${queryfiles[@]}"; do
    queryname=${queryfile##*/}  # get part after last /
    base=${queryname%.rq}     # strip off .xml extension
    temp_file=$(mktemp)
    s-query --service http://localhost:3030/sporttest/query --output text --query $queryfile
done

# kill our temporary Fuseki server
kill $serverPID
