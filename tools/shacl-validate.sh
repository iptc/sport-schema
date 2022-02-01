#!/bin/bash

# Validate the Turtle example files against our SHACL validation constraints.

SHACL_FILE='ontologies/iptc-sport-shacl.ttl'
TTL_SAMPLES_DIR='samples/ttl'
REGEX_FOR_VALID_FILES='conforms  *true'

for filename in samples/ttl/*.ttl; do
    [ -e "$filename" ] || continue  # catch case where there are no matches
    name=${filename##*/}  # get part after last /
    echo -n "Validating $name against SHACL constraints... "
    shacloutput=$(shacl validate --shapes ${SHACL_FILE} --data ${TTL_SAMPLES_DIR}/${name})
    [[ $shacloutput =~ ${REGEX_FOR_VALID_FILES} ]]
    validationflag="${BASH_REMATCH[0]}"
    if [ -n "$validationflag" ]; then
        echo "validated."
    else
        echo "failed:"
        # cheap hack because the string grab strips out return characters. To make
        # the output readable, just run the validator again...
        shacl validate --shapes ontologies/iptc-sport-shacl.ttl --data samples/ttl/${name}
    fi
done
