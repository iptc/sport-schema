#!/bin/bash

# Create RDF (N3 / Turtle / JSON-LD) files from SportsML sources.
# Processes everything in the samples/xml/sportsml folder using the original
# base filename, so "foo.xml" becomes "foo.n3", "foo.ttl" and "foo.jsonld".

if [[ $# -eq 1 ]]; then
    xmlfiles=($1)
else
    xmlfiles=(samples/xml/sportsml/*.xml)
fi

for filename in "${xmlfiles[@]}"; do
    # [ -e "$filename" ] || continue  # catch case where there are no matches
    # this voodoo is called shell parameter expansion:
    # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
    name=${filename##*/}  # get part after last /
    echo -n "Creating RDF from $name: "
    base=${name%.xml}     # strip off .xml extension
    echo -n "N3 "
    tools/convert-sportsml-to-n3.sh $filename >samples/n3/${base}.n3
    echo -n "Turtle "
    riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/${base}.n3 >samples/ttl/${base}.ttl
    echo "JSON-LD"
    riot --formatted=JSONLD samples/ttl/${base}.ttl >samples/json-ld/${base}.jsonld
done
