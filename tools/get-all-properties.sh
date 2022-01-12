#!/bin/bash

tmpfile=$(mktemp /tmp/iptc.XXXXXX)

for filename in samples/ttl/*; do
    [ -e "$filename" ] || continue
    arq --results=csv --query queries/get-all-properties.rq --data $filename >>$tmpfile
done

cat $tmpfile | sort | uniq | grep -v 'type,property'
