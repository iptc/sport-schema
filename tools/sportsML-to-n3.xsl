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

    <!-- top-level element: sports-event. This will direct all the data for reporting on a match/game -->
    <xsl:template match="newsml:sports-event">
        <!-- get the vendor event ID and convert to URI -->
        <xsl:variable name="event-key"><xsl:value-of select="substring-after(newsml:event-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="event-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Event/',$event-key,'»')"/></xsl:variable>

        <!-- declare sports event as a type -->
        <xsl:value-of select="$event-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Event','»')"/> .
        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:event-metadata">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>

        <xsl:value-of select="$event-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'startDate','»')"/> <xsl:value-of select="concat('&quot;',@start-date-time,'&quot;')"/> .
        <xsl:value-of select="$event-id"/> ^<xsl:value-of select="concat('«',$sport-ontology-ns,'event-status','»')"/>^<xsl:value-of select="concat('«',$newscode-ns,substring-before(@event-status,':'),'/',substring-after(@event-status,':'),'»')"/> .
        <xsl:if test="@event-outcome-type">
        <xsl:value-of select="$event-id"/> ^<xsl:value-of select="concat('«',$sport-ontology-ns,'event-outcome-type','»')"/>^<xsl:value-of select="concat('«',$newscode-ns,substring-before(@event-outcome-type,':'),'/',substring-after(@event-outcome-type,':'),'»')"/> .
        </xsl:if>

        <!-- site info -->
        <xsl:if test="newsml:site">
        <xsl:variable name="site-name" select="newsml:site/newsml:site-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="site-key">
        <xsl:choose>
            <xsl:when test="newsml:site/newsml:site-metadata/@key">
            <xsl:value-of select="substring-after(newsml:site/newsml:site-metadata/@key,':')"/>
            </xsl:when>
            <xsl:otherwise>
            <xsl:value-of select="translate(newsml:site/newsml:site-metadata/newsml:name[@role='nrol:full'],' ','')"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>
        <xsl:variable name="site-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Site/',$site-key,'»')"/></xsl:variable>
        <xsl:value-of select="$event-id"/> ^<xsl:value-of select="concat('«',$sport-ontology-ns,'site','»')"/>^<xsl:value-of select="$site-id"/> .
        <xsl:value-of select="$site-id"/> ^<xsl:value-of select="concat('«',$sport-ontology-ns,'name','»')"/> "<xsl:value-of select="$site-name"/>" .
        </xsl:if>


        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- top-level element: standing. This will contain team records through a season: events-played, wins, losses, etc. -->
    <xsl:template match="newsml:standing">
        <!-- get an ID for the scope of the standing and convert to URI -->
                
        <xsl:variable name="competition-key">
            <xsl:value-of select="substring-after(newsml:standing-metadata/@competition,':')"/>
        </xsl:variable>

        <xsl:variable name="season-key">
            <xsl:value-of select="concat($competition-key,'-',/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:season']/@literal)"/>
        </xsl:variable>
        
        <xsl:variable name="temporal-scope">
            <xsl:value-of select="substring-after(newsml:standing-metadata/@temporal-unit-type,':')"/>
        </xsl:variable>

        <xsl:variable name="season-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Season/',$season-key,'»')"/></xsl:variable>

        <!-- declare sports season as a type -->
        <xsl:value-of select="$season-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Season','»')"/> .
        <xsl:apply-templates>
            <xsl:with-param name="season-key" select="$season-key"/>
            <xsl:with-param name="season-id" select="$season-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- team info -->

    <xsl:template match="newsml:team">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
        <xsl:param name="season-key"/>
        <xsl:param name="season-id"/>
        <xsl:variable name="name">
        <xsl:choose>
            <xsl:when test="newsml:team-metadata/newsml:name/@role='nrol:full'">
            <xsl:value-of
        select="newsml:team-metadata/newsml:name[@role='nrol:full']"/>
            </xsl:when>
            <xsl:otherwise>
            <xsl:value-of
        select="newsml:team-metadata/newsml:name"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>
        <xsl:variable name="team-key"><xsl:value-of select="substring-after(newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$team-key,'»')"/></xsl:variable>
        <xsl:variable name="participation-id">
        <xsl:choose>
            <xsl:when test="parent::newsml:sports-event">
            <xsl:value-of
        select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$team-key,'»')"/>
            </xsl:when>
            <xsl:when test="parent::newsml:standing">
            <xsl:value-of
        select="concat('«',$sport-vendor-ns,'Participation/',$season-key,'-',$team-key,'»')"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        </xsl:variable>

        <!-- declare type (Team) -->
        <xsl:value-of select="$team-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Team','»')"/> .
        <!-- give name -->
        <xsl:value-of select="$team-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'name','»')"/> "<xsl:value-of select="$name"/>" .

        <xsl:if test="parent::newsml:sports-event">

        <xsl:choose>
            <xsl:when test="newsml:team-metadata/@alignment='home'">
                <xsl:value-of select="$participation-id"/> «http://www.iptc.org/ontologies/Sport/alignment» "home" .
            </xsl:when>
            <xsl:when test="newsml:team-metadata/@alignment='away'">
                <xsl:value-of select="$participation-id"/> «http://www.iptc.org/ontologies/Sport/alignment» "away" .
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>

            <!-- <participation> rdf:type <TeamParticipation> -->
            <xsl:value-of select="$participation-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'TeamParticipation','»')"/> .

            <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>^<xsl:value-of select="$team-id"/> .

            <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participation','»')"/>^<xsl:value-of select="$participation-id"/> .

        </xsl:if>

        <xsl:if test="parent::newsml:standing">

            <!-- <participation> rdf:type <TeamParticipation> -->
            <xsl:value-of select="$participation-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'TeamParticipation','»')"/> .

            <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>^<xsl:value-of select="$team-id"/> .

            <xsl:value-of select="$season-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participation','»')"/>^<xsl:value-of select="$participation-id"/> .

        </xsl:if>

        <xsl:apply-templates>
            <xsl:with-param name="participation-id" select="$participation-id"/>
            <xsl:with-param name="event-id" select="$event-id"/>
            <xsl:with-param name="event-key" select="$event-key"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:team-stats">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:outcome-totals[@alignment-scope!='spcompetitionscope:events-all']">
        <xsl:param name="participation-id"/>
        <xsl:variable name="participation-suffix" select="substring-after(substring-before($participation-id,'»'),'Participation/')"/>
        <xsl:variable name="participationSplit-id" select="concat('«',$sport-vendor-ns,'ParticipationSplit/',$participation-suffix,'-',substring-after(@alignment-scope,':'),'»')"/>

            <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationSplit','»')"/>^<xsl:value-of
        select="$participationSplit-id"/> .

            <xsl:value-of select="$participationSplit-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationSplitType','»')"/>^<xsl:value-of select="concat('«',$newscode-ns,substring-before(@alignment-scope,':'),'/',substring-after(@alignment-scope,':'),'»')"/> .

        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participationSplit-id" select="$participationSplit-id"/>
            <xsl:with-param name="alignment-id" select="@alignment-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:outcome-totals[@alignment-scope='spcompetitionscope:events-all']">
        <xsl:param name="participation-id"/>

        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
            <xsl:with-param name="alignment-id" select="@alignment-id"/>
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
        <xsl:variable name="participation-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$player-key,'»')"/></xsl:variable>

        <!-- <player> rdf:type Athlete -->
        <xsl:value-of select="$player-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Athlete','»')"/> .
        <!-- <player> sport:name name -->
        <xsl:if test="string($name)">
           <xsl:value-of select="$player-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'name','»')"/> "<xsl:value-of select="$name"/>" .
        </xsl:if>

        <!-- <team> sport:athlete <player> -->
           <xsl:value-of select="$player-team-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'athlete','»')"/> <xsl:value-of select="$player-id"/> .

        <!-- <player> sport:position-regular <soccer-position> -->
        <xsl:if test="newsml:player-metadata/@position-regular">
            <xsl:value-of select="$player-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'position-regular','»')"/>^<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:player-metadata/@position-regular,':'),'/',substring-after(newsml:player-metadata/@position-regular,':'),'»')"/> .
        </xsl:if>

        <!-- <player> sport:date-of-birth <date> -->
        <xsl:if test="newsml:player-metadata/@date-of-birth">
            <xsl:value-of select="$player-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'date-of-birth','»')"/>^<xsl:value-of select="concat('&quot;',newsml:player-metadata/@date-of-birth,'&quot;')"/> .
        </xsl:if>

        <!-- <player> sport:uniform-number <date> -->
        <xsl:if test="newsml:player-metadata/@uniform-number">
            <xsl:value-of select="$player-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'uniform-number','»')"/>^<xsl:value-of select="concat('&quot;',newsml:player-metadata/@uniform-number,'&quot;')"/> .
        </xsl:if>

        <xsl:if test="ancestor::newsml:sports-event">
                <!-- <event> sport:participation <participation> -->
                <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participation','»')"/>^<xsl:value-of select="$participation-id"/> .
                <!-- <participation> rdf:type <IndividualParticipation> -->
                <xsl:value-of select="$participation-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'IndividualParticipation','»')"/> .
                <!-- <participation> sport:participationBy <player> -->
                <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>^<xsl:value-of select="$player-id"/> .
        </xsl:if>

        <xsl:apply-templates>
            <xsl:with-param name="participation-id" select="$participation-id"/>
            <xsl:with-param name="player-id" select="$player-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:associate">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
        <xsl:variable name="name" select="newsml:associate-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="associate-key"><xsl:value-of select="substring-after(newsml:associate-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="associate-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Person/',$associate-key,'»')"/></xsl:variable>
        <xsl:variable name="associate-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="associate-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$associate-team-key,'»')"/></xsl:variable>
        <xsl:variable name="associate-role">
        </xsl:variable>
        <xsl:variable name="participation-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$associate-key,'»')"/></xsl:variable>

        <!-- <associate> rdf:type associate -->
        <xsl:value-of select="$associate-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Associate','»')"/> .
        <!-- <associate> sport:name name -->
        <xsl:if test="string($name)">
           <xsl:value-of select="$associate-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'name','»')"/>  "<xsl:value-of select="$name"/>" .
        </xsl:if>

        <!-- <team> sport:coach <player> -->
           <xsl:value-of select="$associate-team-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'coach','»')"/> <xsl:value-of select="$associate-id"/> .

        <!-- <associate> sport:position-event <associate-position> -->
        <xsl:if test="newsml:associate-metadata/@position-event">
            <xsl:value-of select="$associate-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'position-event','»')"/>^<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:associate-metadata/@position-event,':'),'/',substring-after(newsml:associate-metadata/@position-event,':'),'»')"/> .
        </xsl:if>

        <xsl:if test="ancestor::newsml:sports-event and contains(associate-metadata/@position-event,'Manager')">
                <!-- <event> sport:participation <participation> -->
                <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participation','»')"/>^<xsl:value-of select="$participation-id"/> .
                <!-- <participation> rdf:type <ManagerialParticipation> -->
                <xsl:value-of select="$participation-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'ManagerialParticipation','»')"/> .
                <!-- <participation> sport:participationBy <associate> -->
                <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>^<xsl:value-of select="$associate-id"/> .
        </xsl:if>

    </xsl:template>

    <xsl:template match="newsml:official">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
        <xsl:variable name="name" select="newsml:official-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="official-key"><xsl:value-of select="substring-after(newsml:official-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="official-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Person/',$official-key,'»')"/></xsl:variable>
        <xsl:variable name="official-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="official-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$official-team-key,'»')"/></xsl:variable>
        <xsl:variable name="participation-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$official-key,'»')"/></xsl:variable>

        <!-- <official> rdf:type official -->
        <xsl:value-of select="$official-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'Official','»')"/> .
        <!-- <official> sport:name name -->
        <xsl:if test="string($name)">
           <xsl:value-of select="$official-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'name','»')"/> "<xsl:value-of select="$name"/>" .
        </xsl:if>

        <!-- <participation> sport:position-event <official-position> -->
        <xsl:if test="newsml:official-metadata/@position-event">
            <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'position-event','»')"/>^<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:official-metadata/@position-event,':'),'/',substring-after(newsml:official-metadata/@position-event,':'),'»')"/> .
        </xsl:if>

        <xsl:if test="ancestor::newsml:sports-event">
                <!-- <event> sport:participation <participation> -->
                <xsl:value-of select="$event-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participation','»')"/>^<xsl:value-of select="$participation-id"/> .
                <!-- <participation> rdf:type <OfficialParticipation> -->
                <xsl:value-of select="$participation-id"/> «http://www.w3.org/1999/02/22-rdf-syntax-ns#type» <xsl:value-of select="concat('«',$sport-ontology-ns,'OfficialParticipation','»')"/> .
                <!-- <participation> sport:participationBy <player> -->
                <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>^<xsl:value-of select="$official-id"/> .
        </xsl:if>
    </xsl:template>

    <!-- general stats templates -->

    <xsl:template match="newsml:player-stats">
        <xsl:param name="participation-id"/>
            <xsl:choose>
                <xsl:when test="newsml:stats">
        <xsl:apply-templates>
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>

    <xsl:template match="newsml:stat">
        <xsl:param name="participation-id"/>
	    <xsl:variable name="cv-name" select="substring-before(@stat-type,':')"/>
	    <xsl:variable name="name" select="substring-after(@stat-type,':')"/>
                <xsl:value-of select="$participation-id"/>^<xsl:value-of
                 select="concat('«',$newscode-ns,$cv-name,'/',$name,'»')"/>^<xsl:text>"</xsl:text><xsl:value-of select="@value"/><xsl:text>"</xsl:text> .
    </xsl:template>

    <xsl:template match="newsml:rank[contains(@type,'final-result')]">
        <xsl:param name="participation-id"/>
                <xsl:value-of select="$participation-id"/>^<xsl:value-of
                 select="concat('«',$newscode-ns,'spstat/rank»')"/>^<xsl:text>"</xsl:text><xsl:value-of select="@value"/><xsl:text>"</xsl:text> .
    </xsl:template>

    <xsl:template match="newsml:outcome-result">
        <xsl:param name="participation-id"/>
                <xsl:value-of select="$participation-id"/>^<xsl:value-of
                 select="concat('«',$newscode-ns,'spstat/outcome-result»')"/>^<xsl:text>"</xsl:text><xsl:value-of select="@type"/><xsl:text>"</xsl:text> .
    </xsl:template>

    <xsl:template match="newsml:rating">
        <xsl:param name="participation-id"/>
                <xsl:value-of select="$participation-id"/>^<xsl:value-of
                 select="concat('«',$newscode-ns,'spstat/rating»')"/>^<xsl:text>"</xsl:text><xsl:value-of select="@rating-value"/><xsl:text>"</xsl:text> .
    </xsl:template>

    <!-- sport-specific stats templates -->

    <xsl:template match="newsml:player-stats-soccer">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:team-stats-soccer">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template> 

    <xsl:template match="newsml:stats-soccer-offensive">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:stats-soccer-defensive">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:stats-soccer-foul">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="@*">
        <xsl:param name="participation-id"/>
        <xsl:param name="participationSplit-id"/>
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
        
        <xsl:choose>
            <xsl:when test="string($participationSplit-id)">
                <xsl:value-of select="$participationSplit-id"/>^<xsl:value-of
                 select="concat('«',$newscode-ns,$cv-name,'/',$name,'»')"/>^<xsl:value-of select="$value"/> .                
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$participation-id"/>^<xsl:value-of
                 select="concat('«',$newscode-ns,$cv-name,'/',$name,'»')"/>^<xsl:value-of select="$value"/> .
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:template>

    <!-- templates for element values and unwanted attributes -->
    <xsl:template match="newsml:name"/>
    <xsl:template match="newsml:versionCreated"/>
    <xsl:template match="newsml:fileName"/>
    <xsl:template match="newsml:contentCreated"/>
    <xsl:template match="newsml:headline"/>
    <xsl:template match="newsml:highlight"/>
    <xsl:template match="newsml:keyword"/>
    <xsl:template match="newsml:description"/>

    <xsl:template match="@team-coverage"/>
    <xsl:template match="@alignment-scope"/>
    <xsl:template match="@duration-scope"/>
    <xsl:template match="@temporal-unit-type"/>

    <!-- templates for generic SportsML. Setting aside for now (2020-12-07) but should be easy to build a general template
         similar to specific -->

    <xsl:template match="newsml:stats">
        <xsl:param name="participation-id"/>
        <xsl:apply-templates>
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:stat[@stat-type='spstat:event-outcome']">
        <xsl:param name="participation-id"/>
        <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'eventOutcome','»')"/>^"<xsl:value-of select="@value"/>" .
    </xsl:template>

    <xsl:template match="newsml:stat[@stat-type='spstat:score']">
        <xsl:param name="participation-id"/>
        <xsl:value-of select="$participation-id"/>^<xsl:value-of select="concat('«',$sport-ontology-ns,'score','»')"/>^"<xsl:value-of select="@value"/>" .
    </xsl:template>


</xsl:stylesheet>
