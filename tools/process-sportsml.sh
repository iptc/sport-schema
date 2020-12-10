# This will need to change based on your local paths
SAXON_PATH="../../../../saxon/saxon_java_he/saxon9he.jar"
#
XSLT=sportsML-to-n3.xsl
INPUT_FILE=sportsml/soccer-match-g2-specific.xml
#
java -cp $SAXON_PATH net.sf.saxon.Transform -s:$INPUT_FILE -xsl:$XSLT
