#!/bin/bash

# Create RDF (N3 / Turtle / JSON-LD) files from SportsML sources.
# Processes everything in the samples/xml/sportsml folder using the original
# base filename, so "foo.xml" becomes "foo.n3", "foo.ttl" and "foo.jsonld".
for filename in samples/xml/sportsml/*.xml; do
    # [ -e "$filename" ] || continue  # catch case where there are no matches
    # this voodoo is called shell parameter expansion:
    # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
    name=${filename##*/}  # get part after last /
    echo -n "Creating RDF from $name: "
    base=${name%.xml}     # strip off .xml extension
    echo -n "N3 "
    tools/process-sportsml.sh $filename >samples/n3/${base}.n3
    echo -n "Turtle "
    riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/${base}.n3 >samples/ttl/${base}.ttl
    echo "JSON-LD"
    riot --formatted=JSONLD samples/ttl/${base}.ttl >samples/json-ld/${base}.jsonld
done
