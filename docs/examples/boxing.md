---
layout: page
title: Boxing
nav_order: 4
description: Boxing examples
permalink: /examples/boxing/
parent: Examples
---
# Examples: Boxing

Now we can look at how IPTC Sport Schema can be used to represent a head-to-head sport such as boxing.
We use the Taylor versus Serrano fight from November 2024 as an example.

![Boxing example](/diagrams/boxing-example.png)

To implement this with triples, we first define the event itself:

    <http://example.com/Event/taylor-serrano-2024>
        rdf:type                       sport:Event ;
        rdfs:label                     "Taylor vs. Serrano II" ;
        sport:eventInCompetition       <http://wba.com> ;
        sport:eventInCompetition       <http://wbc.com> ;
        sport:eventStatus              <http://cv.iptc.org/newscodes/speventstatus/post-event> ;
        spfacet:weightClassType        "welterweight" ;
        sport:location                 <http://example.com/Site/att-stadium-arlington> ;
        sport:participation            <http://example.com/Participation/taylor-serrano-2024/ktaylor>;
        sport:participation            <http://example.com/Participation/taylor-serrano-2024/aserrano>;
        sport:startDateTime            "2024-11-15T20:00:00-05:00"^^xsd:dateTime .

The event is part of the "competitions" WBA and WBC (actually the event contributed to other competitions too).

We use the sport facet ontology (added in Sport Schema 1.1) to refer to the weight class. (For the
`weightClassType` facet, values are strings. For other facets, values can be from controlled vocabularies.)

Each of the boxers is an Athlete participating in the event:

    <http://example.com/Athlete/ktaylor>
        rdf:type           sport:Athlete ;
        rdfs:label         "Katie Taylor" ;
        sport:dateOfBirth  "1986-07-02"^^xsd:date ;
        sport:nationality  "IRL" .

    <http://example.com/Athlete/aserrano>
        rdf:type           sport:Athlete ;
        rdfs:label         "Amanda Serrano" ;
        sport:dateOfBirth  "1988-10-09"^^xsd:date ;
        sport:nationality  "PRI" .

In Sport Schema 1.1 we added the ability for Associates to have a "membership" relationship
with Athletes, defined using an "AssociateMembership" object. This can be used to track the
coach/manager of each boxer:

    <http://example.com/Associate/123765>
        rdf:type    sport:Associate ;
        rdfs:label  "Ross Enamait" .

    <http://example.com/Associate/257870>
        rdf:type    sport:Associate ;
        rdfs:label  "Jordan Maldonado" .

    <http://example.com/Membership/man257-EPLT43>
        rdf:type               sport:AssociateMembership ;
        rdfs:label             "Jordan Maldonado associate of Amanda Serrano" ;
        sport:member           <http://example.com/Associate/257870> ;
        sport:membershipOf     <http://example.com/Athlete/aserrano> ;
        sport:positionRegular  <http://cv.iptc.org/newscodes/spposition/manager> ,
                               <http://cv.iptc.org/newscodes/spposition/agent> ,
                               <http://cv.iptc.org/newscodes/spposition/trainer> .

    <http://example.com/Membership/man257-EPLT43>
        rdf:type               sport:AssociateMembership ;
        rdfs:label             "Ross Enamait associate of Katie Taylor" ;
        sport:member           <http://example.com/Associate/123765> ;
        sport:membershipOf     <http://example.com/Athlete/ktaylor> ;
        sport:positionRegular  <http://cv.iptc.org/newscodes/spposition/trainer> .

To model results, we use sport:Participation objects as with other sports. Each boxer has its own
Participation object which tracks the score, outcome (win/loss) and the outcome type (unanimous
decision).

We can use the "Participation Split" construct to handle each round of the boxing match.

    <http://example.com/Participation/taylor-serrano-2024/ktaylor>
        rdf:type                    sport:Participation ;
        rdfs:label                  "Katie Taylor Participation in Taylor vs. Serrano II" ;
        spstat:score                "95" ;
        sport:eventOutcome          speventoutcome:win ;
        sport:eventOutcomeType      speventoutcometype:decision-unanimous ;  # term not in cv
        sport:participationBy       <http://example.com/Athlete/ktaylor> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r01> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r02> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r03> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r04> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r05> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r06> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r07> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r08> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r09> ;
        sport:participationSplit    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r10> .

    <http://example.com/Participation/taylor-serrano-2024/ktaylor_r01>
        rdf:type                       sport:ParticipationSplit ;
        rdfs:label                    "Katie Taylor Participation in Taylor vs. Serrano II, Round 1" ;
        spstat:score                  "9" ;
        sport:eventOutcome            speventoutcome:loss ;
        sport:participationBy         <http://example.com/Athlete/ktaylor> ;
        sport:participationSplitType  spcompetitionscope:round .
        
    <http://example.com/Participation/taylor-serrano-2024/aserrano_r01>
        rdf:type                       sport:ParticipationSplit ;
        rdfs:label                    "Amanda Serrano Participation in Taylor vs. Serrano II, Round 1" ;
        spstat:score                  "10" ;
        sport:eventOutcome            speventoutcome:win ;
        sport:participationBy         <http://example.com/Athlete/ktaylor> ;
        sport:participationSplitType  spcompetitionscope:round .

For the full example in Turtle format, see [the Boxing example in the Sport Schema examples folder on GitHub](https://github.com/iptc/sport-schema/tree/main/examples).
One thing that we can't yet handle is the scores given by a panel of judges. This is on the to-do list
for the next version of IPTC Sport Schema.

