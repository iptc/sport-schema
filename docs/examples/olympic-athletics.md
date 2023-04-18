---
layout: page
title: Olympic Athletics
nav_order: 2
description: Athletics examples
permalink: /examples/athletics/
parent: Examples
---
# Olympic Athletics Example

Here we walk through an example showing how an athletics competition can be
represented in IPTC Sport Schema.

![Athletics competition example](/diagrams/olympic-athletics-dark.png)

First we define the "recurring competition" Summer Olympics (note that these are
the same objects that we define in the Olympic Cycling example, so we don't need to
define them again if we have defined them there.)

```
<http://example.com/GoverningBody/IOC>
        rdf:type    sport:GoverningBody ;
        rdfs:label  "International Olympic Committee" .

<http://example.com/Competition/OLYS>
        rdf:type               sport:Competition ;
        rdfs:label             "Summer Olympics" ;
        sport:competitionType  <http://cv.iptc.org/newscodes/spct/recurring-competition> ;
        sport:governedBy       <http://example.com/GoverningBody/IOC> ;
        sport:sport            medtop:20000827 .
```

We now define the instance of Summer Olympics that represents 2020 Tokyo.

```
<http://example.com/Competition/OLYS2020>
        rdf:type               sport:Competition ;
        rdfs:label             "2020 Tokyo Summer Olympics" ;
        sport:competitionType  <http://cv.iptc.org/newscodes/spct/competition> ;
        sport:parent           <http://example.com/Competition/OLYS> .
```

Now the medal event for the Men's 800 metre race:

```
<http://example.com/Competition/OLYS2020-ATHM800M>
        rdf:type               sport:Competition ;
        rdfs:label             "Men's 800m, 2020 Tokyo" ;
        sport:competitionType  <http://cv.iptc.org/newscodes/spct/competition> ;
        sport:parent           <http://example.com/Competition/OLYS2020> ;
        sport:sport            medtop:20000827 .
```

And the CompetitionPhase for the final and semi-final "rounds":

```
<http://example.com/CompetitionPhase/OLYS2020-ATHM800M-FNL>
        rdf:type                    sport:CompetitionPhase ;
        rdfs:label                  "Men's 800m, Final" ;
        sport:competitionPhaseType  <http://cv.iptc.org/newscodes/sptournamentphase/final> ;
        sport:phaseInCompetition    <http://example.com/Competition/OLYS2020-ATHM800M> .

<http://example.com/CompetitionPhase/OLYS2020-ATHM800M-SFNL>
        rdf:type                    sport:CompetitionPhase ;
        rdfs:label                  "Men's 800m, Semi-Final" ;
        sport:competitionPhaseType  <http://cv.iptc.org/newscodes/sptournamentphase/semi-final> ;
        sport:phaseInCompetition    <http://example.com/Competition/OLYS2020-ATHM800M> .
```

And now the race that is called "Semi-Final 1":

```
<http://example.com/Event/OLYS2020-ATHM800M-SFNL000100>
        rdf:type                       sport:Event ;
        rdfs:label                     "Semi-final 1" ;
        sport:eventInCompetitionPhase  <http://example.com/CompetitionPhase/OLYS2020-ATHM800M-SFNL> ;
        sport:participation            <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1373936> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1453173> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1402343> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1393393> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1307604> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1553500> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1421671> , <http://example.com/Participation/OLYS2020-ATHM800M-SFNL000100-PI1324450> ;
        sport:startDateTime            "2021-08-01T20:26:00+09:00"^^xsd:dateTime .
```

There would of course be equivalent CompetitionPhase objects representing each
round of heats and the final, an Event for each race within those rounds, Athlete objects
to represent each athlete participating in those events, and Participation objects to tie
them all together.
