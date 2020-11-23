<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:local="http://www.bbc.co.uk/tom.grahame@bbc.co.uk">
    <xsl:character-map name="entities">
        <xsl:output-character character="«" string="&lt;"/>   
        <xsl:output-character character="»" string="&gt;"/>
        <xsl:output-character character="±" string="&amp;"/>
    </xsl:character-map>
</xsl:stylesheet>