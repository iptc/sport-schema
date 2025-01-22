---
layout: page
title: Golf
nav_order: 1
description: Golf examples
permalink: /examples/golf/
parent: Examples
---
# Examples: Golf

First of all we show the typical golf instance - a stroke play match such
as the US Masters.

![Golf - match play example](/diagrams/golf-stroke-play-dark.png)

This corresponds to the following triples:

First, the event itself. Note that as opposed to Olympics or other events, there is 
only one event that has a winner, and that is the Masters itself. So we represent the
entire competition as a single Event.

```
<http://pga.com/Event/masters-2022>
        rdf:type                       sport:Event ;
        rdfs:label                     "Masters 2022" ;
        sport:eventInCompetition       <http://pga.com/Competition/pga.com-2022> ;
        sport:eventStatus              <http://cv.iptc.org/newscodes/speventstatus/post-event> ;
        sport:location                 <http://example.com/Site/s.34> ;
        sport:participation            <http://pga.com/Participation/masters-2022_33204>;
        sport:startDateTime            "2022-04-07T10:00:01-05:00"^^xsd:dateTime .
```

Each player's ...

```
<http://pga.com/Participation/masters-2022_r4_roryMcIlroy>
        rdf:type                      sport:ParticipationSplit ;
        rdfs:label             		  "Rory McIlroy Participation in Round 4 at Masters 2022" ;
        spgolf:totalStrokes           "64" ;
        spstat:score                  "-7" ;
        spstat:rank         	  	  "2" ;  
        sport:participationBy         <http://pga.com/Athlete/roryMcIlroy> ;
        sport:participationSplit      <http://pga.com/Participation/masters-2022_r4_roryMcIlroy_15>
        sport:participationSplitType  spcompetitionscope:round .

<http://pga.com/Participation/masters-2022_r4_roryMcIlroy_15>
        rdf:type                      sport:ParticipationSplit ;
        rdfs:label             		  "Rory McIlroy Participation in Hole 15, Round 4 at Masters 2022" ;
        spgolf:totalStrokes           "5" ;
        spstat:score                  "E" ;
        sport:participationBy         <http://pga.com/Athlete/roryMcIlroy> ;
        sport:participationSplitType  spcompetitionscope:hole .

<http://pga.com/Action/masters-2022_r4_33204_15_3>
        rdf:type                       sport:Action ;
        rdfs:label                     "Rory McIlroy Shot 3, Hole 15, Round 4 at Masters 2022" ;
        sport:actionDateTime           "2022-04-07T10:33:57-05:00"^^xsd:dateTime ;
        sport:actionInEvent            <http://pga.com/Event/masters-2022> ;
        sport:class           		   spactionclass:play ;
        sport:actionType               spgolfactiontype:shot ;
        golf:shotType              	   spgolshot:chip ;
        golf:round  				   "4" ;
        golf:hole  					   "15" ;
        golf:stroke  				   "3" ;
        golf:zone  				   	   "4" ;
        golf:shot-location  		   "700083.907,1274390.481,317.248" ;
        golf:shot-distance  		   "10171.500" ;
        golf:distance-remaining  	   "6230.200" ;
        sport:participation   <http://pga.com/Participation/masters-2022_r4_33204_15_3> .

<http://pga.com/Participation/masters-2022_r4_33204_15_3>
        rdf:type                      sport:IndividualParticipation ;
        rdfs:label             		  "Rory McIlroy Participation in  Shot 3, Hole 15, Round 4 at Masters 2022" ;
        sport:participationBy       <http://pga.com/Athlete/roryMcIlroy> ;

<http://example.com/Athlete/roryMcIlroy>
        rdf:type           sport:Athlete ;
        rdfs:label         "Rory McIlroy" ;
        sport:dateOfBirth  "1989-05-04"^^xsd:date ;
        sport:nationality  "NIR" .
```

Match play example:

![Golf - match play example](/diagrams/golf-match-play-dark.png)

