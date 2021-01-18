<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:newsml="http://iptc.org/std/nar/2006-10-01/" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:include href="character-map-entities.xsl"/>

    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:output use-character-maps="entities" />
    <xsl:strip-space elements="*"/>

	<!-- schema location to find data types -->
	<xsl:variable name="sportsml-schema">schema/sportsml.xsd</xsl:variable>

	<!-- global data variables -->
    <xsl:variable name="sport-vendor-ns">http://sport.org/</xsl:variable>
    <xsl:variable name="newscode-ns">http://cv.iptc.org/newscodes/</xsl:variable>
    <xsl:variable name="sport-ontology-ns">http://www.iptc.org/ontologies/Sport/</xsl:variable>
    <xsl:variable name="sport-code">
            <xsl:choose>
            <xsl:when test="newsml:newsItem/newsml:contentMeta/newsml:subject/newsml:broader/@qcode='subj:15000000'">
				<xsl:value-of 
select="substring-after(newsml:newsItem/newsml:contentMeta/newsml:subject[newsml:broader/@qcode='subj:15000000']/@qcode,':')"/>
            	</xsl:when>
            <xsl:otherwise>15000000</xsl:otherwise>
        </xsl:choose>
	</xsl:variable>
    
    <xsl:template match="/"> 
        <xsl:apply-templates/>
    </xsl:template>

	<!-- top-level element: sports-event. This will contain all the data for reporting on a match/game -->
    <xsl:template match="newsml:sports-event">
    	<!-- get the vendor event ID and convert to URI -->
        <xsl:variable name="event-key"><xsl:value-of select="substring-after(newsml:event-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="event-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Event/',$event-key,'»')"/></xsl:variable>

    	<!-- declare sports event as a type -->
        <xsl:value-of select="$event-id"/> «http://www.w3.org/2000/01/rdf-schema/type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Event','»')"/> .        
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>         
    </xsl:template>

    <!-- team info -->

    <xsl:template match="newsml:team">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
		<xsl:variable name="name" select="newsml:team-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="team-key"><xsl:value-of select="substring-after(newsml:team-metadata/@key,':')"/></xsl:variable> 
        <xsl:variable name="team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$team-key,'»')"/></xsl:variable>
        <xsl:variable name="performance-id"><xsl:value-of
        select="concat('«',$sport-vendor-ns,'Performance/',$event-key,'-',$team-key,'»')"/></xsl:variable>
                <xsl:value-of select="$team-id"/> «https://schema.org/name» "<xsl:value-of select="$name"/>" .

        <xsl:if test="parent::newsml:sports-event">

        <xsl:value-of select="$team-id"/> «http://www.w3.org/2000/01/rdf-schema/type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Team','»')"/> .        
        
        <xsl:choose>
            <xsl:when test="newsml:team-metadata/@alignment='home'">
                <xsl:value-of select="$event-id"/> «https://schema.org/homeTeam» <xsl:value-of select="$team-id"/> .
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$event-id"/> «https://schema.org/awayTeam» <xsl:value-of select="$team-id"/> .
            </xsl:otherwise>
        </xsl:choose>

            <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'performance','»')"/>^<xsl:value-of select="$performance-id"/> .
            <xsl:value-of select="$performance-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'performedBy','»')"/>^<xsl:value-of select="$team-id"/> .      
        </xsl:if>
             
        <xsl:apply-templates>
            <xsl:with-param name="performance-id" select="$performance-id"/>
            <xsl:with-param name="event-id" select="$event-id"/>
            <xsl:with-param name="event-key" select="$event-key"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:team-stats">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:team-stats-soccer">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- player info -->

    <xsl:template match="newsml:player">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
		<xsl:variable name="name" select="newsml:player-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="player-key"><xsl:value-of select="substring-after(newsml:player-metadata/@key,':')"/></xsl:variable> 
        <xsl:variable name="player-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Person/',$player-key,'»')"/></xsl:variable>
        <xsl:variable name="player-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable> 
        <xsl:variable name="player-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$player-team-key,'»')"/></xsl:variable>
        <xsl:variable name="performance-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Performance/',$event-key,'-',$player-key,'»')"/></xsl:variable>
                
        <!-- <player> rdfs:type Athlete -->
        <xsl:value-of select="$player-id"/> «http://www.w3.org/2000/01/rdf-schema/type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Athlete','»')"/> .        
        <!-- <player> schema:name name -->
       	<xsl:value-of select="$player-id"/> «https://schema.org/name» "<xsl:value-of select="$name"/>" .
        <!-- <team> schema:athlete <player> -->
       	<xsl:value-of select="$player-team-id"/> «https://schema.org/athlete» <xsl:value-of select="$player-id"/> .

        <!-- <player> sport:position-regular <soccer-position> -->
        <xsl:value-of select="$player-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'position-regular','»')"/> <xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:player-metadata/@position-regular,':'),'/',substring-after(newsml:player-metadata/@position-regular,':'),'»')"/> .
        

        <xsl:if test="ancestor::newsml:sports-event">
            <!-- <event> schema:competitor <player> -->
            <xsl:value-of select="$event-id"/> «https://schema.org/competitor» <xsl:value-of select="$player-id"/> .
            <xsl:if test="newsml:player-stats">
                <!-- <event> sport:performance <performance> -->
                <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'performance','»')"/>^<xsl:value-of select="$performance-id"/> .
                <!-- <performance> sport:performedBy <player> -->
                <xsl:value-of select="$performance-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'performedBy','»')"/>^<xsl:value-of select="$player-id"/> .
            </xsl:if>
        </xsl:if>
             
        <xsl:apply-templates>
            <xsl:with-param name="performance-id" select="$performance-id"/>
            <xsl:with-param name="player-id" select="$player-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:player-stats">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:player-stats-soccer">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- sport-specific stats templates -->

    <xsl:template match="newsml:stats-soccer-offensive">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:stats-soccer-defensive">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="newsml:stats-soccer-foul">
        <xsl:param name="performance-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="performance-id" select="$performance-id"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:param name="performance-id"/>
		<xsl:variable name="name" select="name()"/>
		<xsl:variable name="parent-element-name" select="name(parent::*)"/>
		<xsl:variable name="value">
            <xsl:choose>
                <xsl:when test="contains(.,':')">
                    <xsl:variable name="prefix"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
                    <xsl:value-of select="concat('«http://cv.iptc.org/newscodes/',$prefix,'/',substring-after(.,':'),'»')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
		</xsl:variable>
		<xsl:variable name="cv-name">
            <xsl:choose>
                <xsl:when test="document('sport-concepts.xml')//newsml:concept[newsml:name=$name][contains(newsml:broader/@qcode,$sport-code)]/newsml:conceptId/@qcode">
		            <xsl:value-of select="substring-before(document('sport-concepts.xml')//newsml:concept[newsml:name=$name][contains(newsml:broader/@qcode,$sport-code)]/newsml:conceptId/@qcode,':')"/>	
            	</xsl:when>
                <xsl:otherwise>
                    <!-- ISSUE: had to add the [1] predicate to this path because there are more than one vocab items with the same name eg. "A sequence of more than one item is not allowed as the first argument of substring-before() ("spstat:score", "spstreaktype:score", ...)" -->
            		<xsl:value-of select="substring-before(document('sport-concepts.xml')//newsml:concept[newsml:name=$name][contains(newsml:broader/@qcode,'15000000')][1]/newsml:conceptId/@qcode,':')"/>	
                </xsl:otherwise>
		    </xsl:choose>
		</xsl:variable>
        <xsl:value-of select="$performance-id"/>^<xsl:value-of select="concat('«',$newscode-ns,$cv-name,'/',$name,'»')"/>^<xsl:value-of select="$value"/> .
    </xsl:template>

	<!-- templates for element values and unwanted attributes -->
    <xsl:template match="newsml:name"/>
    <xsl:template match="newsml:versionCreated"/>
    <xsl:template match="newsml:fileName"/>
    <xsl:template match="newsml:contentCreated"/>
    
    <xsl:template match="@team-coverage"/>
    <xsl:template match="@temporal-unit-type"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>
    <xsl:template match="@foo"/>

    <!-- templates for generic SportsML. Setting aside for now (2020-12-07) but should be easy to build a general template
     	similar to specific -->
    
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
