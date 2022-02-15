#!/bin/bash

# Run queries against all sample data, ensure that
# the output is what we expect by comparing it to
# the results in the queries/output directory.

TTL_SAMPLES_DIR='samples/ttl'
REGEX_FOR_VALID_FILES='conforms  *true'

# build list of data files to use in sparql queries
DATA_STRING=''
for filename in ${TTL_SAMPLES_DIR}/*.ttl; do
    DATA_STRING="${DATA_STRING} --data=$filename"
done

for queryfile in queries/*.rq; do
    queryname=${queryfile##*/}  # get part after last /
    base=${queryname%.rq}     # strip off .xml extension
    temp_file=$(mktemp)
    sparql ${DATA_STRING} --query=$queryfile >${temp_file}
    echo "Comparing results for query ${queryname}"
    # Compare our query results against previously saved version
    diff ${temp_file} queries/output/$base.out
done
