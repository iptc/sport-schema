#!/bin/bash

# Save the current working directory in an environment variable
INITIAL_WORKING_DIRECTORY=$(pwd)

# Move to the folder containing this script
cd "$(dirname "$0")"

# This tool uses Saxon as the XSLT engine. Download the free, open source
# Saxon-HE from https://sourceforge.net/projects/saxon/files/Saxon-HE/
# This path will need to change based on your local setup.
SAXON_PATH="../../../../saxon/saxon_java_he/saxon9he.jar"
#
XSLT=./sportsML-to-n3.xsl
INPUT_FILE=../samples/sportsml/soccer-match-g2-specific.xml
#
java -cp $SAXON_PATH net.sf.saxon.Transform -s:$INPUT_FILE -xsl:$XSLT

# Go back to where we were before changing into the
# script directory
cd $INITIAL_WORKING_DIRECTORY
