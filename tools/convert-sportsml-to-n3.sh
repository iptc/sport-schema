#!/bin/bash

INPUT_FILE=$1

if [ $# -eq 0 ]; then
    echo "Usage: $0 <SportsML data file>"
    exit 1
fi

# Get the folder containing this script
THISDIR="$(dirname "$0")"

# This tool uses Saxon as the XSLT engine. Download the free, open source
# Saxon-HE from https://sourceforge.net/projects/saxon/files/Saxon-HE/
# This path will need to change based on your local setup.
SAXON_PATH="$THISDIR/../../../saxon/saxon-he-11.3.jar"
#
XSLT="$THISDIR/sportsML-to-n3.xsl"
#
java -cp $SAXON_PATH net.sf.saxon.Transform -s:$INPUT_FILE -xsl:$XSLT
