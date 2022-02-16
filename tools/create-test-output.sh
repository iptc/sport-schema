#!/bin/bash

# Run queries against all sample data, saving
# the output so we can compare it in tests.
# Only needs to be run when the data files or
# queries are updated.

TTL_SAMPLES_DIR='samples/ttl'

# build list of data files to use in sparql queries
DATA_STRING=''
for filename in ${TTL_SAMPLES_DIR}/*.ttl; do
    DATA_STRING="${DATA_STRING} --data=$filename"
done

for queryfile in queries/*.rq; do
    name=${queryfile##*/}  # get part after last /
    base=${name%.rq}     # strip off .xml extension
    sparql ${DATA_STRING} --query=$queryfile >queries/output/$base.out
done
