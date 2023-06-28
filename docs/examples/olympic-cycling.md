---
layout: page
title: Olympic Cycling
nav_order: 3
description: Olympic Cycling example
permalink: /examples/olympic-cycling/
parent: Examples
---
# Olympic Cycling Example

This takes the example instance diagram from the
[BBC Sport Ontology](https://iptc.org/thirdparty/bbc-ontologies/sport.html)
and shows how it would be represented using the IPTC Sport Schema model.

![Olympic cycling example](/diagrams/olympic-cycling-dark.png)

Below, we show how this looks using IPTC Sport Schema triples (using the Turtle format).

First, we define the generic concept of the Olympics as a "recurring competition".
The Summer Olympic Games competition is governed by the IOC:

```
<http://example.com/GoverningBody/IOC>
        rdf:type    sport:GoverningBody ;
        rdfs:label  "International Olympic Committee" .

<http://example.com/Competition/OLYS>
        rdf:type               sport:Competition ;
        rdfs:label             "Summer Olympics" ;
        sport:competitionType  spct:recurring-competition ;
        sport:governedBy       <http://example.com/GoverningBody/IOC> ;
        sport:sport            medtop:20000827 .
```

Then we create an instance of the generic Summer Olympics competition, which is a regular
competition called the "2012 London Summer Olympics".

```
<http://example.com/Competition/OLYS2012>
        rdf:type               sport:Competition ;
        rdfs:label             "2012 London Summer Olympics" ;
        sport:competitionType  spct:competition ;
        sport:parent           <http://example.com/Competition/OLYS> ;
        sport:sport            medtop:20000827 .
```

Within that Competition there would be a separate Competition for each medal. (Note that
a medal is generally known in IOC terminology as an Event. We uses the term  Event
differently.)

```
<http://example.com/Competition/OLYS2012-CTRMSPRINT>
        rdf:type               sport:Competition ;
        rdfs:label             "Men's Track Cycling (Sprint)" ;
        sport:competitionType  spct:competition ;
        sport:parent           <http://example.com/Competition/OLYS2012> ;
        sport:sport            medtop:20001334 .
```

Each group of events is a CompetitionPhase. In this context, the semi-finals of the Men's
Cycling Sprint competition is a CompetitionPhase. Each Heat within the semi-finals is also
a CompetitionPhase, so we use the generic `parent` construct to represent the relationship.

From the CompetitionPhase objects we link Participation objects that can be used to find the
competitors.

```
<http://example.com/CompetitionPhase/OLYS2012-CTRMSPRINT-SFNL>
        rdf:type                    sport:CompetitionPhase ;
        rdfs:label                  "Semi-Finals" ;
        sport:competitionPhaseType  <http://cv.iptc.org/newscodes/sptournamentphase/semi-final> ;
        sport:participation         <http://example.com/Participation/OLYS2012-CTRMSPRINT-SFNL-PI1436558> , <http://example.com/Participation/OLYS2012-CTRMSPRINT-SFNL-PI1467923> ;
        sport:phaseInCompetition    <http://example.com/Competition/OLYS2012-CTRMSPRINT> .

<http://example.com/CompetitionPhase/OLYS2012-CTRMSPRINT-SFNL-00010000>
        rdf:type                    sport:CompetitionPhase ;
        rdfs:label                  "Heat 1" ;
        sport:competitionPhaseType  <http://cv.iptc.org/newscodes/sptournamentphase/heat> ;
        sport:parent                <http://example.com/CompetitionPhase/OLYS2012-CTRMSPRINT-SFNL> ;
        sport:phaseInCompetition    <http://example.com/Competition/OLYS2012-CTRMSPRINT> .
```

The individual races (things which someone can win or lose) are recorded as Events.

Here is the Event for Heat 1, Race 1.

The event takes place at the London Olympic Park Velodrome, which hasn't been defined yet so
we define it here.
```
<http://example.com/Event/OLYS2012-CTRMSPRINT-SFNL-00010001>
        rdf:type                       sport:Event ;
        rdfs:label                     "Heat 1, Race 1" ;
        sport:eventInCompetitionPhase  <http://example.com/CompetitionPhase/OLYS2012-CTRMSPRINT-SFNL-00010000> ;
        sport:participation            <http://example.com/Participation/OLYS2012-CTRMSPRINT-SFNL-00010001-PI1436558> , <http://example.com/Participation/OLYS2012-CTRMSPRINT-SFNL-00010001-PI1467923> ;
        sport:startDateTime            "2021-08-06T16:10:00+09:00"^^xsd:dateTime ;
        sport:location                 <http://example.com/Site/s.29> .

<http://example.com/Site/s.29>
        rdf:type    sport:Site ;
        rdfs:label  "London Olympic Park Velodrome" .
```

Now we show how each player performed during the Event, via Participation objects.

We also define the Athlete object for cyclist Chris Hoy, who is the subject of the
Participation.
```
<http://example.com/Participation/OLYS2012-CTRMSPRINT-SFNL-00010001-PI1436558>
        rdf:type               sport:IndividualParticipation ;
        rdfs:label             "Chris Hoy participation in Event OLYS2012-CTRMSPRINT-SFNL-00010001" ;
        sport:participationBy  <http://example.com/Athlete/PI1436558> ;
        sport:rank             "1" ;
        sport:score            "+0.107" ;
        sport:scoreUnits       <http://cv.iptc.org/newscodes/spscoreunits/relative> .

<http://example.com/Athlete/PI1436558>
        rdf:type           sport:Athlete ;
        rdfs:label         "Chris Hoy" ;
        sport:nationality  "GB" .
```

As well as being a Participant in the Event, Chris Hoy is also a member of the UK Olympic team, 
known as "Team GB". We define that relationship here.

```
<http://example.com/Membership/TGBOLYS2012-PI1436558>
        rdf:type             sport:IndividualMembership ;
        rdfs:label           "Chris Hoy membership of Team GB" ;
        sport:member         <http://example.com/Athlete/PI1436558> ;
        sport:membershipOf   <http://example.com/Team/TGBOLYS2012> ;
        sport:uniformNumber  "29" .

<http://example.com/Team/TGBOLYS2012>
        rdf:type    sport:Team ;
        rdfs:label  "Team GB" .
```
