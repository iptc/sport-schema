<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:newsml="http://iptc.org/std/nar/2006-10-01/" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:include href="character-map-entities.xsl"/>

    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:output use-character-maps="entities" />
    <xsl:strip-space elements="*"/>

    <xsl:variable name="sport-vendor-ns">http://sport.org/</xsl:variable>
    <xsl:variable name="sport-ontology-ns">http://www.iptc.org/ontologies/Sport/</xsl:variable>
    
    <xsl:template match="newsml:name"/>
    <xsl:template match="newsml:versionCreated"/>
    <xsl:template match="newsml:fileName"/>
    <xsl:template match="newsml:contentCreated"/>

    <xsl:template match="/"> 
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="newsml:sports-event">
        <xsl:variable name="event-key"><xsl:value-of select="substring-after(newsml:event-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="event-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'event/',$event-key,'»')"/></xsl:variable>
        <xsl:value-of select="$event-id"/> «http://www.w3.org/2000/01/rdf-schema/type» «http://sport.org/event/SportsEvent» .
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>         
    </xsl:template>

    <xsl:template match="newsml:team">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
        <xsl:variable name="team-key"><xsl:value-of select="substring-after(newsml:team-metadata/@key,':')"/></xsl:variable> 
        <xsl:variable name="team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'team/',$team-key,'»')"/></xsl:variable>
        <xsl:variable name="performance-id"><xsl:value-of select="concat('«',$event-key,'-',$team-key,'»')"/></xsl:variable>
        
        
        <xsl:if test="parent::newsml:sports-event">
        
        <xsl:choose>
            <xsl:when test="newsml:team-metadata/@alignment='home'">
                <xsl:value-of select="$event-id"/> «https://schema.org/homeTeam» <xsl:value-of select="$team-id"/> .
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$event-id"/> «https://schema.org/awayTeam» <xsl:value-of select="$team-id"/> .
            </xsl:otherwise>
        </xsl:choose>

            <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'TeamPerformance','»')"/>^<xsl:value-of select="$performance-id"/> .
            <xsl:value-of select="$performance-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'performedBy','»')"/>^<xsl:value-of select="$team-id"/> .      
        </xsl:if>
             
        <xsl:apply-templates>
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:team-stats">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates>
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:stats">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates>
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:stat[@stat-type='spstat:event-outcome']">
        <xsl:param name="performance-id"/>
        <xsl:value-of select="$performance-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'eventOutcome','»')"/>^"<xsl:value-of select="@value"/>" .
    </xsl:template>

    <xsl:template match="newsml:stat[@stat-type='spstat:score']">
        <xsl:param name="performance-id"/>
        <xsl:value-of select="$performance-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'score','»')"/>^"<xsl:value-of select="@value"/>" .
    </xsl:template>

</xsl:stylesheet>
