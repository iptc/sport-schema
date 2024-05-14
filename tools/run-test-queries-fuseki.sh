#!/bin/bash

# Run queries against all sample data, ensure that
# the output is what we expect by comparing it to
# the results in the queries/fuseki-output directory.

TTL_SAMPLES_DIR='samples/ttl'
SPORT_ONTOLOGY_FILE='ontologies/iptc-sport-merged-ontology.ttl'
MEDIATOPIC_FILE='vocabularies/mediatopic.ttl'

# handle error in the case that the glob returns null
shopt -s nullglob

# start a local, in-memory-only fuseki server
echo -n "Spinning up a temporary instance of Fuseki triple store..."
# nohup fuseki-server --mem -rdfs ${SPORT_ONTOLOGY_FILE} /sporttest >/dev/null 2>&1 &
nohup fuseki-server --mem /sporttest >/dev/null 2>&1 &
# noisy/verbose version
#nohup fuseki-server --mem -rdfs ${SPORT_ONTOLOGY_FILE} /sporttest &
# nohup fuseki-server --mem /sporttest &
sleep 2 # to give it time to start up
serverPID=$!
echo "Done."

# load our source data into the temporary Fuseki instance
# start with the ontology file and mediatopics file so
echo -n "Loading ontology file into temporary Fuseki instance..."
s-post http://localhost:3030/sporttest/data default ${SPORT_ONTOLOGY_FILE}
echo "Done."

echo -n "Loading Media Topics taxonomy into temporary Fuseki instance..."
s-post http://localhost:3030/sporttest/data default ${MEDIATOPIC_FILE}
echo "Done."

echo -n "Loading all sample data into temporary Fuseki instance..."
# they can also be used in test queries
for filename in ${TTL_SAMPLES_DIR}/*.ttl; do
    s-post http://localhost:3030/sporttest/data default ${filename}
done
echo "Done."

# Are we running one query or all of them?
if [[ $# -eq 1 ]]; then
    queryfiles=($1)
else
    queryfiles=(queries/*.rq)
fi

for queryfile in "${queryfiles[@]}"; do
    queryname=${queryfile##*/}  # get part after last /
    base=${queryname%.rq}     # strip off .xml extension
    temp_file=$(mktemp)
    echo "Comparing ${queryname} results against previously saved version"
    s-query --service http://localhost:3030/sporttest/query --output text --query $queryfile >${temp_file}
    # Compare our query results against previously saved version
    diff queries/fuseki-output/$base.out ${temp_file}
done

# kill our temporary Fuseki server
kill $serverPID
