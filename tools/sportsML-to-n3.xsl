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
    <xsl:variable name="sport-vendor-ns">http://example.com/</xsl:variable>
    <xsl:variable name="newscode-ns">http://cv.iptc.org/newscodes/</xsl:variable>
    <xsl:variable name="sport-ontology-ns">http://www.iptc.org/ontologies/Sport/</xsl:variable>
    <xsl:variable name="sport-action-ontology-ns">http://www.iptc.org/ontologies/Sport/Action/</xsl:variable>
    <xsl:variable name="rdf-ns">http://www.w3.org/1999/02/22-rdf-syntax-ns#</xsl:variable>
    <xsl:variable name="rdfs-ns">http://www.w3.org/2000/01/rdf-schema#</xsl:variable>
    <xsl:variable name="genre-key" select="/newsml:newsItem/newsml:contentMeta/newsml:genre/@qcode"/>

    <xsl:variable name="sport-code">
        <xsl:choose>
            <xsl:when test="newsml:newsItem/newsml:contentMeta/newsml:subject/newsml:broader/@qcode='medtop:15000000'">
                <xsl:value-of
select="substring-after(newsml:newsItem/newsml:contentMeta/newsml:subject[newsml:broader/@qcode='medtop:15000000']/@qcode,':')"/>
            </xsl:when>
            <xsl:otherwise>15000000</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="sport-id">
        <xsl:value-of select="concat('«',$newscode-ns,'mediatopic/',$sport-code,'»')"/>
    </xsl:variable>

    <xsl:variable name="competition-key">
        <xsl:choose>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']">
                <xsl:value-of select="substring-after(/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']/@qcode,':')"/>
            </xsl:when>
            <xsl:when test="//newsml:tournament/newsml:tournament-metadata/@key">
                <xsl:value-of select="substring-after(//newsml:tournament/newsml:tournament-metadata/@key,':')"/>
            </xsl:when>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:competition']">
                <xsl:value-of select="substring-after(/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:competition']/@qcode,':')"/>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="competition-id">
        <xsl:value-of select="concat('«',$sport-vendor-ns,'Competition/',$competition-key,'»')"/>
    </xsl:variable>

    <xsl:variable name="season-key">
        <xsl:choose>
            <xsl:when test="//newsml:tournament/newsml:tournament-metadata/@key">
                <xsl:value-of select="substring-after(//newsml:tournament/newsml:tournament-metadata/@key,':')"/>
            </xsl:when>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:competition']">
                <xsl:value-of select="$competition-key"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat($competition-key,'-',/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:season']/@literal)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="season-id">
        <xsl:choose>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:competition']">
                <xsl:value-of select="concat('«',$sport-vendor-ns,'Competition/',$competition-key,'»')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('«',$sport-vendor-ns,'Competition/',$season-key,'»')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="$genre-key='spfixt:player-bio'"/>
            <!-- Sports where league is parent competition and season is competition -->
            <xsl:when test="$sport-code = ('20000849','20000851','20000965','20000823')">
                <xsl:value-of select="$season-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Competition','»')"/> .
                <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="concat(/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']/newsml:name,' ',/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:season']/@literal)"/>" .
                <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'instanceOf','»')"/>~<xsl:value-of select="$competition-id"/> .
                <xsl:value-of select="$competition-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Competition','»')"/> .
                <xsl:value-of select="$competition-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']/newsml:name"/>" .
                <xsl:value-of select="$competition-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'sport','»')"/>~<xsl:value-of select="$sport-code"/> .
            </xsl:when>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[contains(@type,'competition')]">
                <xsl:for-each select="/newsml:newsItem/newsml:contentMeta/newsml:subject[contains(@type,'competition')]">
                    <xsl:variable name="competition-id" select="concat('«',$sport-vendor-ns,'Competition/',substring-after(@qcode,':'),'»')"/>
                    <xsl:variable name="parent-competition-key" select="newsml:broader[@rel='comprel:child']/@qcode"/>
                    <xsl:variable name="instance-competition-key" select="newsml:broader[@rel='comprel:instance']/@qcode"/>
                    
                    <!-- info about the comp itself -->
                    <xsl:value-of select="$competition-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Competition','»')"/> .
                    <xsl:value-of select="$competition-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="newsml:name"/>" .

                    <!-- info about parent competitions -->
                    <xsl:if test="newsml:broader[@rel='comprel:child'] and contains(//newsml:subject[@qcode=$parent-competition-key]/@type,'competition')">
                        <xsl:variable name="parent-competition-id" select="concat('«',$sport-vendor-ns,'Competition/',substring-after(newsml:broader[@rel='comprel:child']/@qcode,':'),'»')"/>
                        <xsl:value-of select="$competition-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'parentCompetition','»')"/> <xsl:value-of select="$parent-competition-id"/> .
                    </xsl:if>

                    <!-- info about instanceOf -->
                    <xsl:if test="newsml:broader[@rel='comprel:instance'] and contains(//newsml:subject[@qcode=$instance-competition-key]/@type,'competition')">
                        <xsl:variable name="parent-competition-id" select="concat('«',$sport-vendor-ns,'Competition/',substring-after(newsml:broader[@rel='comprel:instance']/@qcode,':'),'»')"/>
                        <xsl:value-of select="$competition-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'instanceOf','»')"/> <xsl:value-of select="$parent-competition-id"/> .
                    </xsl:if>

                    <!-- info about broader governing body -->
                    <xsl:if test="newsml:broader and //newsml:subject[@qcode=$parent-competition-key]/@type='spct:governing-body'">
                        <xsl:variable name="governing-body-id" select="concat('«',$sport-vendor-ns,'GoverningBody/',substring-after(newsml:broader/@qcode,':'),'»')"/>
                        <xsl:value-of select="$competition-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'governingBody','»')"/> <xsl:value-of select="$governing-body-id"/> .
                        <xsl:value-of select="$governing-body-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'GoverningBody','»')"/> .
                        <xsl:value-of select="$governing-body-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="//newsml:subject[@qcode=$parent-competition-key]/newsml:name"/>" .
                    </xsl:if>

                </xsl:for-each>
            </xsl:when>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']">
                <xsl:value-of select="$competition-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Competition','»')"/> .
                <xsl:value-of select="$competition-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']/newsml:name"/>" .
                <xsl:value-of select="$competition-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'sport','»')"/>~<xsl:value-of select="$sport-code"/> .
                <xsl:if test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:season']">
                    <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Competition','»')"/> .
                    <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="concat(/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']/newsml:name,' ',/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:season']/@literal)"/>" .
                    <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'parentCompetition','»')"/>~<xsl:value-of select="$competition-id"/> .
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:apply-templates/>
    </xsl:template>

    <!-- template to produce RDF for top-level metadata such as sport, league, season, etc. Called from "top-level" content elements and applied to the corresponding object:
         sports-event, standing, schedule, tournament or statistic. -->
    <xsl:template name="metadata-general">
        <xsl:param name="object-id"/>

        <!-- specify RDF type of object based on its ID -->
        <xsl:choose>
            <xsl:when test="contains($object-id, 'Team')">
                <xsl:value-of select="$object-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Team','»')"/> .
            </xsl:when>
            <xsl:when test="contains($object-id, 'Athlete')">
                <xsl:value-of select="$object-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Athlete','»')"/> .
            </xsl:when>
        </xsl:choose>
        <xsl:if test="$object-id != $season-id">
            <xsl:choose>
                <xsl:when test="$genre-key='spfixt:player-bio'"/>
                <xsl:when test="//newsml:tournament"/>
                <xsl:otherwise>
                    <xsl:value-of select="$object-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'competition','»')"/>~<xsl:value-of select="$season-id"/> .
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- top-level element: sports-event. This will direct all the data for reporting on a match/game -->
    <xsl:template match="newsml:sports-event">
        <!-- get the vendor event ID and convert to URI -->
        <xsl:variable name="event-key"><xsl:value-of select="substring-after(newsml:event-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="event-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Event/',$event-key,'»')"/></xsl:variable>

        <xsl:call-template name="metadata-general">
            <xsl:with-param name="object-id" select="$event-id"/>
        </xsl:call-template>

        <!-- declare event type -->
        <xsl:value-of select="$event-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Event','»')"/> .

        <!-- give the event a name/label -->
        <xsl:choose>
          <xsl:when test="newsml:event-metadata/newsml:name">
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="newsml:event-metadata/newsml:name"/>" .
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "Event <xsl:value-of select="$event-key"/>" .
          </xsl:otherwise>
        </xsl:choose>

        <!-- link event with subEvents -->
        <xsl:for-each select="newsml:sports-event">
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'event','»')"/>~<xsl:value-of select="concat('«',$sport-vendor-ns,'Event/',substring-after(newsml:event-metadata/@key,':'),'»')"/> .
        </xsl:for-each>

        <!-- add competition info -->
        <xsl:if test="ancestor::newsml:tournament-part/newsml:tournament-part-metadata/@type">
            <xsl:variable name="phase-id">
                <xsl:choose>
                    <!-- simple round -->
                    <xsl:when test="parent::newsml:tournament-part/newsml:tournament-part-metadata[@type = 'sptournamentphase:round']/@number">
                        <xsl:value-of select="concat('«', $sport-vendor-ns, 'CompetitionPhase/', $season-key, '-round-', parent::newsml:tournament-part/newsml:tournament-part-metadata/@number, '»')"/>
                    </xsl:when>
                    <!-- group phase -->
                    <xsl:when test="parent::newsml:tournament-part[newsml:tournament-part-metadata/@format-type = 'sptournamentform:single-group']">
                        <xsl:value-of select="concat('«', $sport-vendor-ns, 'CompetitionPhase/', $season-key, '-group-', parent::newsml:tournament-part/newsml:tournament-part-metadata/@number, '»')"/>
                    </xsl:when>
                    <!-- single round phase -->
                    <xsl:when test="parent::newsml:tournament-part/newsml:tournament-part-metadata/@type">
                        <xsl:value-of select="concat('«', $sport-vendor-ns, 'CompetitionPhase/', $season-key, '-', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type,':'), '»')"/>
                    </xsl:when>
                    <!-- elimination phase when format changes within sub-phases eg. Champions league final switching from home-and-home to single-elimination -->
                    <xsl:when test="parent::newsml:tournament-part[newsml:tournament-part-metadata/@format-type = 'sptournamentform:single-elimination']">
                        <xsl:value-of select="concat('«', $sport-vendor-ns, 'CompetitionPhase/', $season-key, '-', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"/>
                    </xsl:when>
                    <!-- elimination phase -->
                    <xsl:when test="ancestor::newsml:tournament-part[newsml:tournament-part-metadata/@format-type = 'sptournamentform:single-elimination']">
                        <xsl:value-of select="concat('«', $sport-vendor-ns, 'CompetitionPhase/', $season-key, '-', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"/>
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«', $sport-ontology-ns, 'competitionPhase', '»')"/>~<xsl:value-of select="$phase-id"/> .
            <xsl:value-of select="$phase-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'CompetitionPhase','»')"/> .
            <xsl:value-of select="$phase-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'competition','»')"/>~<xsl:value-of select="$competition-id"/> .

            <xsl:choose>
                <xsl:when test="parent::newsml:tournament-part/newsml:tournament-part-metadata//newsml:name">
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="parent::newsml:tournament-part/newsml:tournament-part-metadata//newsml:name"/>" .
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "CompetitionPhase <xsl:value-of select="$phase-id"/> of competition <xsl:value-of select="$competition-id"/>" .
                </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
                <!-- simple round -->
                <xsl:when test="parent::newsml:tournament-part/newsml:tournament-part-metadata[@type = 'sptournamentphase:round']/@number">
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionPhaseType', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '/', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"
                        /> .
                </xsl:when>
                <!-- group phase -->
                <xsl:when test="parent::newsml:tournament-part[newsml:tournament-part-metadata/@format-type = 'sptournamentform:single-group']">
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionFormat', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(parent::newsml:tournament-part/newsml:tournament-part-metadata[@format-type = 'sptournamentform:single-group']/@format-type, ':'), '/', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata[@format-type = 'sptournamentform:single-group']/@format-type, ':'), '»')"
                        /> .
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionPhaseType', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(ancestor::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '/', substring-after(ancestor::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"
                        /> .
                </xsl:when>
                <!-- elimination phase when format changes within sub-phases eg. Champions league final switching from home-and-home to single-elimination -->
                <xsl:when test="parent::newsml:tournament-part[newsml:tournament-part-metadata/@format-type = 'sptournamentform:single-elimination']">
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionFormat', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(parent::newsml:tournament-part/newsml:tournament-part-metadata/@format-type, ':'), '/', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@format-type, ':'), '»')"
                        /> .
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionPhaseType', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '/', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"
                        /> .
                </xsl:when>
                <!-- elimination phase -->
                <xsl:when test="ancestor::newsml:tournament-part[newsml:tournament-part-metadata/@format-type = 'sptournamentform:single-elimination']">
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionFormat', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(ancestor::newsml:tournament-part/newsml:tournament-part-metadata[@format-type = 'sptournamentform:single-elimination']/@format-type, ':'), '/', substring-after(ancestor::newsml:tournament-part/newsml:tournament-part-metadata[@format-type = 'sptournamentform:single-elimination']/@format-type, ':'), '»')"
                        /> .
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionPhaseType', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '/', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"
                        /> .
                </xsl:when>
                <xsl:when test="parent::newsml:tournament-part/newsml:tournament-part-metadata/@type">
                    <xsl:value-of select="$phase-id"/>~<xsl:value-of
                        select="concat('«', $sport-ontology-ns, 'competitionPhaseType', '»')"/>~<xsl:value-of
                        select="concat('«', $newscode-ns, substring-before(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '/', substring-after(parent::newsml:tournament-part/newsml:tournament-part-metadata/@type, ':'), '»')"
                        /> .
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:if>

        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:event-metadata">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>

        <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'startDateTime','»')"/>~<xsl:value-of select="concat('&quot;',@start-date-time,'&quot;^^«http://www.w3.org/2001/XMLSchema#dateTime»')"/> .
        <xsl:if test="@event-status">
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventStatus','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(@event-status,':'),'/',substring-after(@event-status,':'),'»')"/> .
        </xsl:if>
        <xsl:if test="@event-outcome-type">
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventOutcomeType','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(@event-outcome-type,':'),'/',substring-after(@event-outcome-type,':'),'»')"/> .
        </xsl:if>

        <xsl:if test="newsml:site/newsml:site-stats/@attendance">
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'attendance','»')"/>~"<xsl:value-of select="newsml:site/newsml:site-stats/@attendance"/>" .
        </xsl:if>

        <!-- season week -->
        <xsl:if test="newsml:event-metadata-soccer/@week and not(ancestor::newsml:tournament-part)">
            <xsl:variable name="season-week" select="newsml:event-metadata-soccer/@week"/>
            <xsl:variable name="competition-phase-id" select="concat('«', $sport-vendor-ns, 'CompetitionPhase/', $season-key, '-week-', $season-week, '»')"/>
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'competitionPhase','»')"/>~<xsl:value-of select="$competition-phase-id" /> .
            <xsl:value-of select="$competition-phase-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'CompetitionPhase','»')"/> .
            <xsl:value-of select="$competition-phase-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"Week <xsl:value-of select="$season-week"/>" .
            <xsl:value-of select="$competition-phase-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'competition','»')"/>~<xsl:value-of select="$season-id"/> .
        </xsl:if>

        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- site info -->
    <xsl:template match="newsml:site">
        <xsl:param name="event-id"/>

        <xsl:variable name="site-name" select="newsml:site-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="site-key">
            <xsl:choose>
                <xsl:when test="newsml:site-metadata/@key">
                    <xsl:value-of select="substring-after(newsml:site-metadata/@key,':')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="translate(newsml:site-metadata/newsml:name[@role='nrol:full'],' ','')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="site-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Site/',$site-key,'»')"/></xsl:variable>
        <!-- declare Site type -->
        <xsl:value-of select="$site-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Site','»')"/> .
        <!-- <event> sport:site <site> -->
        <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'site','»')"/>~<xsl:value-of select="$site-id"/> .
        <!-- <site> rdfs:label "name" -->
        <xsl:value-of select="$site-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$site-name"/>" .
    </xsl:template>

    <!-- top-level element: standing. This will contain team records through a season: events-played, wins, losses, etc. -->
    <xsl:template match="newsml:standing">
        <!-- get an ID for the scope of the standing and convert to URI -->
        <xsl:variable name="competition-key">
            <xsl:value-of select="substring-after(newsml:standing-metadata/@competition,':')"/>
        </xsl:variable>

        <xsl:variable name="season-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Competition/',$season-key,'»')"/></xsl:variable>

        <xsl:call-template name="metadata-general">
            <xsl:with-param name="object-id" select="$season-id"/>
        </xsl:call-template>

        <!-- declare sports season type -->
        <xsl:choose>
            <xsl:when test="//newsml:tournament"/>
            <xsl:when test="/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:competition']"/>
            <xsl:otherwise>
                <xsl:value-of select="$season-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Competition','»')"/> .
                <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="concat(/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:league']/newsml:name,' ',/newsml:newsItem/newsml:contentMeta/newsml:subject[@type='spct:season']/@literal)"/>" .
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates>
            <xsl:with-param name="season-key" select="$season-key"/>
            <xsl:with-param name="season-id" select="$season-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- top-level element: statistic. This will contain statistical reports for leagues, teams and athletes. Could also be a team roster or competitor list. -->
    <xsl:template match="newsml:statistic">
        <!-- get an ID for the scope of the standing and convert to URI -->
        <xsl:variable name="object-id">
            <xsl:choose>
                <xsl:when test="newsml:statistic-metadata/@team-coverage='spteamcoverage:single-team'">
                    <xsl:variable name="team-key"><xsl:value-of select="substring-after(newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
                    <xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$team-key,'»')"/>
                </xsl:when>
                <xsl:when test="$genre-key='spfixt:player-bio'">
                    <xsl:variable name="player-key"><xsl:value-of select="substring-after(newsml:team/newsml:player/newsml:player-metadata/@key,':')"/></xsl:variable>
                    <xsl:value-of select="concat('«',$sport-vendor-ns,'Athlete/',$player-key,'»')"/>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:call-template name="metadata-general">
            <xsl:with-param name="object-id" select="$object-id"/>
        </xsl:call-template>

        <xsl:apply-templates/>
    </xsl:template>

    <!-- team info -->

    <xsl:template match="newsml:team">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
        <xsl:param name="season-key"/>
        <xsl:param name="season-id"/>

        <xsl:variable name="team-name">
            <xsl:choose>
                <xsl:when test="newsml:team-metadata/newsml:name/@role='nrol:full'">
                    <xsl:value-of select="newsml:team-metadata/newsml:name[@role='nrol:full']"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="newsml:team-metadata/newsml:name"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="team-key"><xsl:value-of select="substring-after(newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$team-key,'»')"/></xsl:variable>
        <xsl:variable name="participation-id">
            <xsl:choose>
                <xsl:when test="parent::newsml:sports-event">
                    <xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$team-key,'»')"/>
                </xsl:when>
                <xsl:when test="parent::newsml:standing">
                    <xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$season-key,'-',$team-key,'»')"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>

        <!-- declare Team type -->
        <xsl:value-of select="$team-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Team','»')"/> .
        <!-- <team> rdfs:label "name" -->
        <xsl:value-of select="$team-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$team-name"/>" .

        <xsl:if test="string($participation-id)">
            <!-- <participation> rdf:type <TeamParticipation> -->
            <xsl:value-of select="$participation-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'TeamParticipation','»')"/> .
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$team-name"/> participation in Event <xsl:value-of select="$event-key"/>" .

            <!-- <participation> sport:participationBy <team> -->
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>~<xsl:value-of select="$team-id"/> .
        </xsl:if>

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

            <!-- <event> sport:eventParticipation <participation> -->
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventParticipation','»')"/>~<xsl:value-of select="$participation-id"/> .
        </xsl:if>

        <xsl:if test="parent::newsml:standing">
            <!-- <season> sport:competitionParticipation <participation> -->
            <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'competitionParticipation','»')"/>~<xsl:value-of select="$participation-id"/> .
        </xsl:if>

        <xsl:apply-templates>
            <xsl:with-param name="participation-id" select="$participation-id"/>
            <xsl:with-param name="event-id" select="$event-id"/>
            <xsl:with-param name="event-key" select="$event-key"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:team-stats">
        <xsl:param name="participation-id"/>

        <xsl:if test="newsml:rank">
            <xsl:choose>
                <xsl:when test="newsml:rank[contains(@type,'final-result')]">
			        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'rank»')"/>~<xsl:text>"</xsl:text><xsl:value-of select="newsml:rank[contains(@type,'final-result')]/@value"/><xsl:text>"</xsl:text> .
                </xsl:when>
                <xsl:otherwise>
		            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'rank»')"/> "<xsl:value-of select="newsml:rank[1]/@value"/>" .
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:apply-templates select="@* | node()">
            <xsl:with-param name="participation-id" select="$participation-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:outcome-totals[@alignment-scope!='spcompetitionscope:events-all']">
        <xsl:param name="participation-id"/>
        <xsl:variable name="participation-suffix" select="substring-after(substring-before($participation-id,'»'),'Participation/')"/>
        <xsl:variable name="participationSplit-id" select="concat('«',$sport-vendor-ns,'ParticipationSplit/',$participation-suffix,'-',substring-after(@alignment-scope,':'),'»')"/>

        <!-- <participation split> rdf:type ParticipationSplit -->
        <xsl:value-of select="$participationSplit-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'ParticipationSplit','»')"/> .
        <xsl:value-of select="$participationSplit-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"ParticipationSplit <xsl:value-of select="$participationSplit-id"/>" .
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationSplit','»')"/>~<xsl:value-of select="$participationSplit-id"/> .

        <xsl:value-of select="$participationSplit-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationSplitType','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(@alignment-scope,':'),'/',substring-after(@alignment-scope,':'),'»')"/> .

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

        <xsl:variable name="player-key"><xsl:value-of select="substring-after(newsml:player-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="player-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Athlete/',$player-key,'»')"/></xsl:variable>
        <xsl:variable name="player-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="player-team-name"><xsl:value-of select="ancestor::newsml:team/newsml:team-metadata/newsml:name[@role='nrol:full']"/></xsl:variable>
        <xsl:variable name="player-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$player-team-key,'»')"/></xsl:variable>
        <xsl:variable name="participation-id">
            <xsl:choose>
                <xsl:when test="ancestor::newsml:sports-event">
                    <xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$player-key,'»')"/>
                </xsl:when>
                <xsl:when test="ancestor::newsml:standing">
                    <xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$season-key,'-',$player-key,'»')"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="player-name">
            <xsl:choose>
                <xsl:when test="string(newsml:player-metadata/newsml:name[@role='nrol:full'])">
                    <xsl:value-of select="newsml:player-metadata/newsml:name[@role='nrol:full']"/>
                </xsl:when>
                <!-- whitespace in this value causes problems in RDF processing -->
                <xsl:otherwise>Player <xsl:value-of select="$player-id"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- <player> rdf:type Athlete -->
        <xsl:value-of select="$player-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Athlete','»')"/> .

        <!-- <player> rdfs:label "name" -->
        <xsl:value-of select="$player-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$player-name"/>" .

        <!-- <team> sport:athlete <player> -->
        <xsl:if test="ancestor::newsml:team">
            <xsl:variable name="player-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
            <xsl:variable name="player-team-name"><xsl:value-of select="ancestor::newsml:team/newsml:team-metadata/newsml:name[@role='nrol:full']"/></xsl:variable>
            <xsl:variable name="player-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$player-team-key,'»')"/></xsl:variable>
            <xsl:variable name="membership-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Membership/',$player-team-key,'-',$player-key,'»')"/></xsl:variable>

            <xsl:value-of select="$player-team-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Team','»')"/> .
            <xsl:value-of select="$player-team-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$player-team-name"/>" .
            <xsl:value-of select="$player-team-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'membership','»')"/>~<xsl:value-of select="$membership-id"/> .
            <xsl:value-of select="$membership-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'IndividualMembership','»')"/> .
            <xsl:value-of select="$membership-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$player-name"/> membership of <xsl:value-of select="$player-team-name"/>" .
            <xsl:value-of select="$membership-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'membershipOf','»')"/> <xsl:value-of select="$player-team-id"/> .
            <xsl:value-of select="$membership-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'membershipBy','»')"/> <xsl:value-of select="$player-id"/> .
            <xsl:if test="newsml:player-metadata/@position-regular">
                <xsl:value-of select="$membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'positionRegular','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:player-metadata/@position-regular,':'),'/',substring-after(newsml:player-metadata/@position-regular,':'),'»')"/> .
            </xsl:if>
            <xsl:if test="string(newsml:player-metadata/@uniform-number)">
                <xsl:value-of select="$membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'uniformNumber','»')"/>~<xsl:value-of select="concat('&quot;',newsml:player-metadata/@uniform-number,'&quot;')"/> .
            </xsl:if>

            <xsl:for-each select="newsml:player-metadata/newsml:career-phase[@start-date]">
                <xsl:variable name="phase-team-key"><xsl:value-of select="substring-after(@key,':')"/></xsl:variable>
                <xsl:variable name="phase-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$phase-team-key,'»')"/></xsl:variable>
                <xsl:variable name="phase-team-name"><xsl:value-of select="@label"/></xsl:variable>
                <xsl:variable name="phase-membership-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Membership/',$phase-team-key,'-',$player-key,'»')"/></xsl:variable>

                <xsl:if test="$phase-membership-id != $membership-id">
                    <xsl:value-of select="$phase-team-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'membership','»')"/>~<xsl:value-of select="$phase-membership-id"/> .
                    <xsl:value-of select="$phase-membership-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Membership','»')"/> .
                    <xsl:value-of select="$phase-membership-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$player-name"/> membership of <xsl:value-of select="$phase-team-name"/>" .
                    <xsl:value-of select="$phase-membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'membershipOf','»')"/> <xsl:value-of select="$phase-team-id"/> .
                    <xsl:value-of select="$phase-team-id"/>~<xsl:value-of select="concat('«',$rdf-ns,'type','»')"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'Team','»')"/> .
                    <xsl:value-of select="$phase-team-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$phase-team-name"/>" .
                    <xsl:value-of select="$phase-membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'membershipBy','»')"/>~<xsl:value-of select="$player-id"/> .
                </xsl:if>

                <xsl:value-of select="$phase-membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'startDate','»')"/>~<xsl:value-of select="concat('&quot;',@start-date,'&quot;^^«http://www.w3.org/2001/XMLSchema#date»')"/> .

                <xsl:if test="@end-date">
                    <xsl:value-of select="$phase-membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'endDate','»')"/>~<xsl:value-of select="concat('&quot;',@end-date,'&quot;^^«http://www.w3.org/2001/XMLSchema#date»')"/> .
                </xsl:if>
            </xsl:for-each>
        </xsl:if>

        <!-- <participation> sport:playerStatus (started, bench etc) -->
        <xsl:if test="newsml:player-metadata/@status">
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'playerStatus','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:player-metadata/@status,':'),'/',substring-after(newsml:player-metadata/@status,':'),'»')"/> .
        </xsl:if>

        <!-- <player> sport:dateOfBirth <date> -->
        <xsl:if test="newsml:player-metadata/@date-of-birth and matches(newsml:player-metadata/@date-of-birth,'\d\d\d\d-\d\d-\d\d')">
            <xsl:value-of select="$player-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'dateOfBirth','»')"/>~<xsl:value-of select="concat('&quot;',newsml:player-metadata/@date-of-birth,'&quot;^^«http://www.w3.org/2001/XMLSchema#date»')"/> .
        </xsl:if>
        <xsl:if test="newsml:player-metadata/@nationality">
            <xsl:value-of select="$player-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'nationality','»')"/>~<xsl:value-of select="concat('&quot;',newsml:player-metadata/@nationality,'&quot;')"/> .
        </xsl:if>
        <xsl:if test="string(newsml:player-metadata/@uniform-number) and not(ancestor::newsml:team)">
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'uniformNumber','»')"/>~<xsl:value-of select="concat('&quot;',newsml:player-metadata/@uniform-number,'&quot;')"/> .
        </xsl:if>

        <xsl:if test="ancestor::newsml:sports-event">
            <!-- <event> sport:eventParticipation <participation> -->
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventParticipation','»')"/>~<xsl:value-of select="$participation-id"/> .
            <!-- <participation> rdf:type <IndividualParticipation> -->
            <xsl:value-of select="$participation-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'IndividualParticipation','»')"/> .
            <!-- <participation> rdfs:label -->
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$player-name"/> participation in Event <xsl:value-of select="$event-key"/>" .
            <!-- <participation> sport:participationBy <player> -->
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>~<xsl:value-of select="$player-id"/> .
        </xsl:if>

        <xsl:if test="parent::newsml:standing">
            <!-- <season> sport:competitionParticipation <participation> -->
            <xsl:value-of select="$season-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'competitionParticipation','»')"/>~<xsl:value-of select="$participation-id"/> .
            <xsl:value-of select="$participation-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'IndividualParticipation','»')"/> .
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$player-name"/> participation in Event <xsl:value-of select="$event-key"/>" .
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>~<xsl:value-of select="$player-id"/> .
        </xsl:if>

        <xsl:apply-templates>
            <xsl:with-param name="participation-id" select="$participation-id"/>
            <xsl:with-param name="player-id" select="$player-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- associate info (manager, coach etc.) -->

    <xsl:template match="newsml:associate">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>

        <xsl:variable name="associate-name" select="newsml:associate-metadata/newsml:name[@role='nrol:full']"/>
        <xsl:variable name="associate-key"><xsl:value-of select="substring-after(newsml:associate-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="associate-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Associate/',$associate-key,'»')"/></xsl:variable>
        <xsl:variable name="associate-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="associate-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$associate-team-key,'»')"/></xsl:variable>
        <xsl:variable name="associate-team-name"><xsl:value-of select="ancestor::newsml:team/newsml:team-metadata/newsml:name[@role='nrol:full']"/></xsl:variable>
        <xsl:variable name="associate-role"></xsl:variable>
        <xsl:variable name="associate-membership-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Membership/',$associate-key,'-',$associate-team-key,'»')"/></xsl:variable>
        <xsl:variable name="associate-participation-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$associate-key,'»')"/></xsl:variable>

        <!-- <associate> rdf:type Associate -->
        <xsl:value-of select="$associate-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Associate','»')"/> .

        <!-- <associate> rdfs:label "name" -->
        <xsl:if test="string($associate-name)">
           <xsl:value-of select="$associate-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$associate-name"/>" .
        </xsl:if>

        <!-- New way of representing coach -->

        <!-- <associate-membership> rdf:type Membership -->
        <xsl:value-of select="$associate-membership-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Membership','»')"/> .
        <!-- <associate-membership> rdfs:label  -->
        <xsl:value-of select="$associate-membership-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$associate-name"/> associate membership of <xsl:value-of select="$associate-team-name"/>" .

        <!-- <associate-membership> sport:membershipOf <team> -->
        <xsl:value-of select="$associate-membership-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'membershipOf','»')"/> <xsl:value-of select="$associate-team-id"/> .

        <!-- <associate-membership> sport:membershipBy <associate> -->
        <xsl:value-of select="$associate-membership-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'membershipBy','»')"/> <xsl:value-of select="$associate-id"/> .

        <!-- old way: <team> sport:coach <associate> -->
        <!-- <xsl:value-of select="$associate-team-id"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'coach','»')"/> <xsl:value-of select="$associate-id"/> . -->

        <!-- <associate-membership> sport:positionRegular <associate-position> -->
        <xsl:if test="newsml:associate-metadata/@position-event">
            <xsl:value-of select="$associate-membership-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'positionRegular','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:associate-metadata/@position-event,':'),'/',substring-after(newsml:associate-metadata/@position-event,':'),'»')"/> .
        </xsl:if>

        <xsl:if test="ancestor::newsml:sports-event and contains(associate-metadata/@position-event,'Manager')">
            <!-- <event> sport:eventParticipation <participation> -->
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventParticipation','»')"/>~<xsl:value-of select="$associate-participation-id"/> .
            <!-- <participation> rdf:type <AssociateParticipation> -->
            <xsl:value-of select="$associate-participation-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'AssociateParticipation','»')"/> .
            <!-- <participation> sport:participationBy <associate> -->
            <xsl:value-of select="$associate-participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>~<xsl:value-of select="$associate-id"/> .
        </xsl:if>
    </xsl:template>

    <!-- official info (referee etc.) -->
    <xsl:template match="newsml:official">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>

        <xsl:variable name="official-key"><xsl:value-of select="substring-after(newsml:official-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="official-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Official/',$official-key,'»')"/></xsl:variable>
        <xsl:variable name="official-name">
            <xsl:choose>
                <xsl:when test="string(newsml:official-metadata/newsml:name[@role='nrol:full'])">
                    <xsl:value-of select="newsml:official-metadata/newsml:name[@role='nrol:full']"/>
                </xsl:when>
                <xsl:otherwise>Official <xsl:value-of select="$official-id"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="official-team-key"><xsl:value-of select="substring-after(ancestor::newsml:team/newsml:team-metadata/@key,':')"/></xsl:variable>
        <xsl:variable name="official-team-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',$official-team-key,'»')"/></xsl:variable>
        <xsl:variable name="participation-id"><xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$official-key,'»')"/></xsl:variable>

        <!-- <official> rdf:type Official -->
        <xsl:value-of select="$official-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Official','»')"/> .

        <!-- <official> rdfs:label name -->
       <xsl:value-of select="$official-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$official-name"/>" .

        <!-- <participation> sport:positionEvent <official-position> -->
        <xsl:if test="newsml:official-metadata/@position-event">
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'positionEvent','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(newsml:official-metadata/@position-event,':'),'/',substring-after(newsml:official-metadata/@position-event,':'),'»')"/> .
        </xsl:if>

        <!-- <participation> rdf:type <OfficialParticipation> -->
        <xsl:value-of select="$participation-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'OfficialParticipation','»')"/> .
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/>~"<xsl:value-of select="$official-name"/> participation in Event <xsl:value-of select="$event-key"/>" .

        <!-- <participation> sport:participationBy <official> -->
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>~<xsl:value-of select="$official-id"/> .

        <xsl:if test="ancestor::newsml:sports-event">
            <!-- <event> sport:eventParticipation <participation> -->
            <xsl:value-of select="$event-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventParticipation','»')"/>~<xsl:value-of select="$participation-id"/> .
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
        <xsl:if test="newsml:rank">
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'rank»')"/> "<xsl:value-of select="newsml:rank/@value"/>" .
        </xsl:if>
    </xsl:template>

    <xsl:template match="newsml:outcome-result">
        <xsl:param name="participation-id"/>

        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$newscode-ns,'spstat/outcome-result»')"/>~<xsl:text>"</xsl:text><xsl:value-of select="@type"/><xsl:text>"</xsl:text> .
    </xsl:template>

    <xsl:template match="newsml:rating">
        <xsl:param name="participation-id"/>

        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$newscode-ns,'spstat/rating»')"/>~<xsl:text>"</xsl:text><xsl:value-of select="@rating-value"/><xsl:text>"</xsl:text> .
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

        <xsl:variable name="element-name" select="name()"/>
        <xsl:variable name="parent-element-name" select="name(parent::*)"/>
        <xsl:variable name="value">
            <xsl:choose>
                <xsl:when test="matches(.,'[0-9]')">
                    <xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
                </xsl:when>
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
                <xsl:when test="document('sport-concepts.xml')//newsml:concept[newsml:name=$element-name][contains(newsml:broader/@qcode,$sport-code)]/newsml:conceptId/@qcode">
                    <xsl:value-of select="substring-before(document('sport-concepts.xml')//newsml:concept[newsml:name=$element-name][contains(newsml:broader/@qcode,$sport-code)]/newsml:conceptId/@qcode,':')"/>
                </xsl:when>
                <xsl:otherwise>
                    <!-- ISSUE: had to add the [1] predicate to this path because there are more than one vocab items with the same name eg. "A sequence of more than one item is not allowed as the first argument of substring-before() ("spstat:score", "spstreaktype:score", ...)" -->
                    <xsl:value-of select="substring-before(document('sport-concepts.xml')//newsml:concept[newsml:name=$element-name][contains(newsml:broader/@qcode,'15000000')][1]/newsml:conceptId/@qcode,':')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- attach the stat to a participation or a participationSplit -->
        <xsl:choose>
            <xsl:when test="name()='temporal-unit-type'"/>
            <xsl:when test="name()='team-coverage'"/>
            <xsl:when test="name()='score'">
                <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'score','»')"/>~<xsl:value-of select="$value"/> .
            </xsl:when>
            <xsl:when test="name()='score-units'">
                <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'scoreUnits','»')"/>~<xsl:value-of select="$value"/> .
            </xsl:when>
            <xsl:when test="$cv-name=''">
                <!-- general properties not in CVs -->
                <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,$cv-name,$element-name,'»')"/>~<xsl:value-of select="$value"/> .
            </xsl:when>
            <xsl:when test="string($participationSplit-id)">
                <!-- <participationSplit> <newscodescv:cvterm> "value" -->
                <xsl:value-of select="$participationSplit-id"/>~<xsl:value-of select="concat('«',$newscode-ns,$cv-name,'/',$element-name,'»')"/>~<xsl:value-of select="$value"/> .
            </xsl:when>
            <xsl:otherwise>
                <!-- <participation> <newscodescv:cvterm> "value" -->
                <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$newscode-ns,$cv-name,'/',$element-name,'»')"/>~<xsl:value-of select="$value"/> .
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- actions -->

    <xsl:template match="newsml:actions">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>

        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:action[@id]">
        <xsl:param name="event-key"/>
        <xsl:param name="event-id"/>
        <xsl:variable name="action-key">
            <xsl:choose>
                <xsl:when test="@key">
                    <xsl:value-of select="@key"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@id"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="action-id" select="concat('«',$sport-vendor-ns,'Action/',$event-key,'-',$action-key,'»')"/>

        <xsl:value-of select="$action-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'Action','»')"/> .
        <xsl:value-of select="$action-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "Action <xsl:value-of select="$action-key"/> on event <xsl:value-of select="$event-key"/>" .
        <xsl:value-of select="$action-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'event','»')"/>~<xsl:value-of select="$event-id"/> .
        <!-- xsl:value-of select="$action-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'team','»')"/>~<xsl:value-of select="concat('«',$sport-vendor-ns,'Team/',@team-idref,'»')"/> . -->

        <xsl:for-each select="@*[not(name()='team-idref') and not(name()='id') and not(name()='created')]">
            <xsl:variable name="value">
                <xsl:choose>
                    <xsl:when test="contains(.,':') and not(name()='date-time') and not(name()='time-elapsed')">
                        <xsl:variable name="prefix"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
                        <xsl:value-of select="concat('«http://cv.iptc.org/newscodes/',$prefix,'/',substring-after(.,':'),'»')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>"</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:value-of select="$action-id"/>~<xsl:value-of select="concat('«',$sport-action-ontology-ns,name(),'»')"/>~<xsl:value-of select="$value"/> .
        </xsl:for-each>

        <xsl:apply-templates>
            <xsl:with-param name="event-key" select="$event-key"/>
            <xsl:with-param name="action-key" select="$action-key"/>
            <xsl:with-param name="event-id" select="$event-id"/>
            <xsl:with-param name="action-id" select="$action-id"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="newsml:participant[parent::newsml:action/@id]">
        <xsl:param name="event-key"/>
        <xsl:param name="action-key"/>
        <xsl:param name="event-id"/>
        <xsl:param name="action-id"/>

        <xsl:variable name="player-key" select="@idref"/>
        <xsl:variable name="participation-id">
            <xsl:value-of select="concat('«',$sport-vendor-ns,'Participation/',$event-key,'-',$action-key,'-',$player-key,'»')"/>
        </xsl:variable>

        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'participationBy','»')"/>~<xsl:value-of select="concat('«',$sport-vendor-ns,'Athlete/',$player-key,'»')"/> .
        <xsl:value-of select="$action-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'actionParticipation','»')"/>~<xsl:value-of select="$participation-id"/> .
        <xsl:value-of select="$participation-id"/> <xsl:value-of select="concat('«',$rdf-ns,'type','»')"/> <xsl:value-of select="concat('«',$sport-ontology-ns,'IndividualParticipation','»')"/> .
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$rdfs-ns,'label','»')"/> "<xsl:value-of select="$player-key"/> participation in action <xsl:value-of select="$action-key"/> in event <xsl:value-of select="$event-key"/>" .
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-action-ontology-ns,'role','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(@role,':'),'/',substring-after(@role,':'),'»')"/> .
    </xsl:template>

    <!-- templates for unwanted element values and attributes -->
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

    <!-- special treatment: spstat:event-outcome becomes sport/eventOutcome -->
    <xsl:template match="newsml:stat[@stat-type='spstat:event-outcome']">
        <xsl:param name="participation-id"/>
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'eventOutcome','»')"/>~<xsl:value-of select="concat('«',$newscode-ns,substring-before(@value,':'),'/',substring-after(@value,':'),'»')"/> .
    </xsl:template>

    <!-- xsl:template match="newsml:stat[@stat-type='spstat:score']">
        <xsl:param name="participation-id"/>
        <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$sport-ontology-ns,'score','»')"/>~"<xsl:value-of select="@value"/>" .
    </xsl:template -->

    <xsl:template match="newsml:stat">
        <xsl:param name="participation-id"/>

        <!-- in our source SportsML some stats have empty or NaN values so we ignore those -->
        <xsl:if test="@value != '' and @value != 'NaN'">
            <xsl:variable name="cv-name" select="substring-before(@stat-type,':')"/>
            <xsl:variable name="value-name"><xsl:value-of select="substring-after(@stat-type,':')"/></xsl:variable>
            <!-- if the stat has a :, output the value as a CV term URI -->
            <xsl:variable name="value">
                <xsl:choose>
                    <xsl:when test="contains(@value,':') and not(name()='date-time') and not(name()='time-elapsed')">
                        <xsl:variable name="prefix"><xsl:value-of select="substring-before(@value,':')"/></xsl:variable>
                        <xsl:value-of select="concat('«',$newscode-ns,$prefix,'/',substring-after(@value,':'),'»')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>"</xsl:text><xsl:value-of select="@value"/><xsl:text>"</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- <participation> newscodescv:cvterm value -->
            <xsl:value-of select="$participation-id"/>~<xsl:value-of select="concat('«',$newscode-ns,$cv-name,'/',$value-name,'»')"/>~<xsl:value-of select="$value"/> .
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
