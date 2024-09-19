#!/bin/bash

# Validate the Turtle example files against our SHACL validation constraints.

SHACL_FILE='ontologies/iptc-sport-shacl.ttl'
RDF_SCHEMA='ontologies/iptc-sport-merged-ontology.ttl'
# RDF_SCHEMA='ontologies/iptc-sport-ontology.ttl'
VOCABULARIES=(vocabularies/*.ttl)
TTL_SAMPLES_DIR='samples/ttl'
REGEX_FOR_VALID_FILES='conforms  *true'

# handle error in the case that the glob returns null
shopt -s nullglob

# If we have one or more command-line arguments, use that as the filename.
# Otherwise, load all media files in the parent directory.
if [[ $# -eq 0 ]]; then
    filestovalidate=(samples/ttl/*.ttl)
    mediafiles=(${THISDIR}/../*.${MEDIATYPES_REGEX})
else
    filestovalidate=($@)
fi

for filename in "${filestovalidate[@]}"; do
    [ -e "$filename" ] || continue  # catch case where there are no matches
    name=${filename##*/}  # get part after last /
    echo -n "Validating $name against SHACL constraints... "
    # Jena 'shacl' requires only one data file, but we want to merge the instance file
    # wth the ontology file so we can use rdfs:subClassOf in our validation.
    # So we create a temp file containing both, and then validate that.
    temp_dir=$(mktemp -d)
    temp_file=${temp_dir}/${name}  # we keep the same name so Jena can understand the file extension..
    cat ${RDF_SCHEMA} ${VOCABULARIES[@]} ${filename} >${temp_file}
    # create the command we need to run, but save it because we might run it twice.
    shacl_command="shacl validate --shapes ${SHACL_FILE} --data ${temp_file}"
    # run it for the first time...
    shacl_output=$(${shacl_command})
    [[ $shacl_output =~ ${REGEX_FOR_VALID_FILES} ]]
    validationflag="${BASH_REMATCH[0]}"
    if [ -n "$validationflag" ]; then
        echo "validated."
    else
        echo "failed:"
        # cheap hack because the string grab strips out return characters. To make
        # the output readable, just run the validator again...
        # shacl validate --shapes ${SHACL_FILE} --data ${RDF_SCHEMA} ${TTL_SAMPLES_DIR}/${name}
        ${shacl_command}
    fi
done
