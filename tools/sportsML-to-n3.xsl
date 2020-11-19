<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:newsml="http://iptc.org/std/nar/2006-10-01/" version="1.0">

    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*"/>


    <xsl:variable name="sport-key">
        <xsl:choose>
            <xsl:when test="newsml:sports-content">
                <xsl:value-of
                    select="substring-after(newsml:sports-content/newsml:sports-metadata/newsml:sports-content-codes/newsml:sports-content-code[@code-type = 'spct:sport']/@code-key, ':')"
                />
            </xsl:when>
            <xsl:when test="newsml:newsItem">
                <xsl:value-of
                    select="substring-after(newsml:newsItem/newsml:contentMeta/newsml:subject[newsml:broader/@qcode = 'subj:15000000']/@qcode, ':')"
                />
            </xsl:when>
            <xsl:otherwise>unknown</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="sport-name-code">
        <xsl:choose>
            <xsl:when test="$sport-key = '15003000'">american-football</xsl:when>
            <xsl:when test="$sport-key = '15054000'">soccer</xsl:when>
            <xsl:when test="$sport-key = '15017000'">cricket</xsl:when>
            <xsl:when test="$sport-key = '15049000'">rugby</xsl:when>
            <xsl:when test="$sport-key = '15048000'">rugby</xsl:when>
            <xsl:when test="$sport-key = '15031000'">ice-hockey</xsl:when>
            <xsl:when test="$sport-key = '15007000'">baseball</xsl:when>
            <xsl:when test="$sport-key = '15008000'">basketball</xsl:when>
            <xsl:when test="$sport-key = '15018000'">curling</xsl:when>
            <xsl:when test="$sport-key = '15027000'">golf</xsl:when>
            <xsl:otherwise>unknown</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="sport-name-short">
        <xsl:choose>
            <xsl:when test="$sport-key = '15003000'">amf</xsl:when>
            <xsl:when test="$sport-key = '15054000'">soc</xsl:when>
            <xsl:when test="$sport-key = '15017000'">cri</xsl:when>
            <xsl:when test="$sport-key = '15049000'">rgx</xsl:when>
            <xsl:when test="$sport-key = '15048000'">rgx</xsl:when>
            <xsl:when test="$sport-key = '15031000'">ich</xsl:when>
            <xsl:when test="$sport-key = '15007000'">bbl</xsl:when>
            <xsl:when test="$sport-key = '15008000'">bkb</xsl:when>
            <xsl:when test="$sport-key = '15018000'">cur</xsl:when>
            <xsl:when test="$sport-key = '15027000'">gol</xsl:when>
            <xsl:otherwise>unknown</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="publisher-code">
        <xsl:choose>
            <xsl:when test="newsml:sports-content"> </xsl:when>
            <xsl:when test="newsml:newsItem">
                <xsl:value-of
                    select="substring-after(newsml:newsItem/newsml:contentMeta/newsml:creator/@qcode, ':')"
                />
            </xsl:when>
            <xsl:otherwise>unknown</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <!-- pass all elements through -->
    <xsl:template match="*" xmlns="http://iptc.org/std/nar/2006-10-01/">
        <xsl:element name="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

    <!-- pass all attributes through -->
    <xsl:template match="@*">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

    <!-- pass all values through -->
    <xsl:template match="text()">
        <xsl:if test="normalize-space()">
            <xsl:value-of select="."/>
        </xsl:if>
    </xsl:template>

    <!-- convert SportsML names to camelCase -->
    <xsl:template name="camel-conversion">
    <xsl:param name="name"/>
                  <xsl:variable name="tmp"
                   	select="translate(moo,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
                   	
    </xsl:template>

    <xsl:template match="newsml:name"/>
    <xsl:template match="newsml:versionCreated"/>
    <xsl:template match="newsml:fileName"/>
    <xsl:template match="newsml:contentCreated"/>

    <xsl:template match="/"> 
        @prefix sport: &lt;http://www.iptc.org/ontologies/Sport#&gt; . 
        @prefix rdf: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; . 
        @prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; . 
        @prefix spes: &lt;http://cv.iptc.org/newscodes/speventstatus#&gt; . 
        @prefix speo: &lt;http://cv.iptc.org/newscodes/speventoutcome#&gt; . 
        @prefix speot: &lt;http://cv.iptc.org/newscodes/speventoutcometype#&gt; . 
        @prefix so: &lt;https://schema.org/&gt; . 
        @prefix soes: &lt;https://schema.org/EventStatusType#&gt; .
        @prefix mt: &lt;http://cv.iptc.org/newscodes/mediatopic#&gt; . 

        @prefix ve: &lt;http://sport.org/event/#&gt; . 
        @prefix vt: &lt;http://sport.org/team/#&gt; . 
        @prefix vp: &lt;http://sport.org/person/#&gt; . 
        
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="newsml:sports-event">
        <xsl:variable name="event-key"><xsl:value-of select="newsml:event-metadata/@key"
            /></xsl:variable>
    	<xsl:value-of select="$event-key"/> a so:SportsEvent;
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
        </xsl:apply-templates> 
        
    </xsl:template>

    <xsl:template match="newsml:team">
        <xsl:param name="event-key"/>
        <xsl:variable name="team-key"><xsl:value-of select="newsml:team-metadata/@key"
            /></xsl:variable> 
        
        <xsl:if test="parent::newsml:sports-event">
        
        <xsl:choose>
            <xsl:when test="newsml:team-metadata/@alignment='home'">
                <xsl:value-of select="$event-key"/> so:homeTeam <xsl:value-of select="$team-key"/>;
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$event-key"/> so:awayTeam <xsl:value-of select="$team-key"/>;
            </xsl:otherwise>
        </xsl:choose>

                <xsl:value-of select="$event-key"/> sport:TeamPerformance <xsl:value-of select="concat(substring-after($event-key,':'),'-',substring-after($team-key,':'))"/>;
                <xsl:value-of select="concat(substring-after($event-key,':'),'-',substring-after($team-key,':'))"/> sport:performedBy <xsl:value-of select="$team-key"/>;
        </xsl:if>
             
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="substring-after($event-key,':')"/>
            <xsl:with-param name="team-key" select="substring-after($team-key,':')"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:team-stats">
        <xsl:param name="event-key"/>
        <xsl:param name="team-key"/>
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="team-key" select="$team-key"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:stats">
        <xsl:param name="event-key"/>
        <xsl:param name="team-key"/>
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="team-key" select="$team-key"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:stat[@stat-type='spstat:event-outcome']">
        <xsl:param name="event-key"/>
        <xsl:param name="team-key"/>
        <xsl:variable name="camel-converstion">
                <xsl:call-template name="camel-conversion">
            		<xsl:with-param name="name" select="name()"/>
		        </xsl:call-template>
        </xsl:variable>
		<xsl:value-of select="concat($event-key,'-',$team-key)"/> sport:eventOutcome "<xsl:value-of select="@value"/>";
    </xsl:template>

    <xsl:template match="newsml:stat[@stat-type='spstat:score']">
        <xsl:param name="event-key"/>
        <xsl:param name="team-key"/>
        <xsl:variable name="camel-converstion">
                <xsl:call-template name="camel-conversion">
            		<xsl:with-param name="name" select="name()"/>
		        </xsl:call-template>
        </xsl:variable>
		<xsl:value-of select="concat($event-key,'-',$team-key)"/> sport:score "<xsl:value-of select="@value"/>";
    </xsl:template>

</xsl:stylesheet>
