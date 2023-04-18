---
layout: page
title: Soccer (football)
nav_order: 4
description: Soccer examples
permalink: /examples/soccer/
parent: Examples
---
# Examples: Soccer (football)

Let's look at how IPTC Sport Schema can be used to represent a single football match as part of
the English Premier League 2020 Season.

![Soccer competition example](/diagrams/soccer-competition-example.png)

This corresponds to the following triples representing the match.

First we define English Premier League itself. This only needs to happen once, across all seasons.
We define it as a [Competition](/ontologies/main/#Competition) of
[competitionType](http://127.0.0.1:4000/ontologies/main/#competitionType)
"[recurring-competition](https://cv.iptc.org/newscodes/spct/recurring-competition)",
referring to the sport "soccer" as defined by the IPTC's MediaTopics vocabulary, using its code
(medtop:20001065)[https://cv.iptc.org/newscodes/mediatopic/20001065).

    <http://example.com/Competition/l.premierleague.com>
        rdf:type               sport:Competition ;
        rdfs:label             "English Premier League" ;
        sport:competitionType  spct:recurring-competition ;
        sport:sport            medtop:20001065 .

Then we define the season, also a [Competition](/ontologies/main/#Competition). We use the
[parent](http://127.0.0.1:4000/ontologies/main/#parent) relationship to link the season to the
generic concept of the Premier League competition. (Note that because we define inverse
relationships using OWL, we could query in either direction: `"Premier League" sport:child
"Premier League 2020"` or `"Premier League 2020" sport:parent "Premier League"`.

We use the [competitionType](http://127.0.0.1:4000/ontologies/main/#competitionType) property to
define the 2020 season as a "[competition](https://cv.iptc.org/newscodes/spct/competition)", i.e.
a regular competition that has a winner at the end.

    <http://example.com/Competition/l.premierleague.com-2020>
        rdf:type               sport:Competition ;
        rdfs:label             "English Premier League 2020" ;
        sport:competitionType  spct:competition ;
        sport:parent           <http://example.com/Competition/l.premierleague.com> .

Next we use [CompetitionPhase](/ontologies/main/#CompetitionPhase) to define a given round in
the season: in this case, Week 16. The property to link CompetitionPhase to Competition is
called [phaseInCompetition](/ontologies/main/#phaseInCompetition).

    <http://example.com/CompetitionPhase/l.premierleague.com-2020-week-16>
        rdf:type                  sport:CompetitionPhase ;
        rdfs:label                "Week 16" ;
        sport:phaseInCompetition  <http://example.com/Competition/l.premierleague.com-2020> .

Now for the match itself, which is defined as an [Event](/ontologies/main/#Event) because it is the
smallest level occurrence that has a winner.

The links to the teams are created using the [Participation](/ontologies/main/#Participation)
construct. Each team has a [TeamParticipation](/ontologies/main/#TeamParticipation) which is linked
from the Event using the [participation](/ontologies/main/#participation) property.

We also add some properties describing the status of the event (pre-event, during, or post-event)
using the [eventStatus](http://127.0.0.1:4000/ontologies/main/#eventStatus) property and the 
[event-status vocabulary](http://cv.iptc.org/newscodes/speventstatus/); the location via a link to
a [Site](/ontologies/main/#Site) object; the [eventOutcomeType](/ontologies/main/#eventOutcomeType)
using the [event outcome type vocabulary](http://cv.iptc.org/newscodes/speventoutcometype/), and
the [startDateTime](/ontologies/main/#startDateTime). These are all the same as the equivalent
properties in SportsML.

    <http://example.com/Event/E2128607>
        rdf:type                       sport:Event ;
        rdfs:label                     "Arsenal vs Liverpool, Week 16, EPL" ;
        sport:eventInCompetition       <http://example.com/Competition/l.premierleague.com-2020> ;
        sport:eventInCompetitionPhase  <http://example.com/CompetitionPhase/l.premierleague.com-2020-week-16> ;
        sport:eventOutcomeType         <http://cv.iptc.org/newscodes/speventoutcometype/regular> ;
        sport:eventStatus              <http://cv.iptc.org/newscodes/speventstatus/post-event> ;
        sport:location                 <http://example.com/Site/s.34> ;
        sport:participation            <http://example.com/Participation/E2128607-EPLT35> , <http://example.com/Participation/E2128607-EPLT7> ;
        sport:startDateTime            "2021-02-25T19:00:00+01:00"^^xsd:dateTime .

The [Participation](/ontologies/main/#Participation) object is where scores and stats are expressed
about the team's performance in a given Event. For a team sport, we use the
[TeamParticipation](/ontologies/main/#TeamParticipation) specialisation; for individual sports
we use [IndividualParticipation](/ontologies/main/#IndividualParticipation).

Here we express the [eventOutcome](/ontologies/main/#eventOutcome) using the 
[speventoutcome vocabulary](<http://cv.iptc.org/newscodes/speventoutcome/); the scores for and
against this team ([score](/ontologies/main/#score) from the main ontology and
[scoreOpposing](/ontologies/corestatistics/#scoreOpposing) from the
[Core Statistics ontology](/ontologies/corestatistics/)).

The [participationBy](ontologies/main/#participationBy) property links the TeamParticipation to the
actual [Team](/ontologies/main/#Team). The [alignment](ontologies/main/#alignment) property
shows that Liverpool is the "away" team for this match.

Then we provide a number of statistics about Liverpool's performance in this match, either using the
generic [Core Statistics ontology](/ontologies/corestatistics/) or the
[Soccer statistics Ontology](ontologies/soccer/).

All of the statistics properties are a direct translation from the equivalents in SportsML, but
converted into "camelCase" to follow RDF conventions. So for example the "goals-against-total"
attribute from `sportsml-specific-soccer.xsd` becomes
[spsocstat:goalsAgainstTotal](ontologies/soccer#goalsAgainstTotal) in IPTC Sport Schema.

    <http://example.com/Participation/E2128607-EPLT35>
        rdf:type                        sport:TeamParticipation ;
        rdfs:label                      "Liverpool participation in Week 16, EPL" ;
        spstat:eventOutcome             <http://cv.iptc.org/newscodes/speventoutcome/tie> ;
        spstat:scoreOpposing            "2" ;
        spstat:timeOfPossessionPercentage
                "29.8" ;
        sport:alignment                 "away" ;
        sport:participationBy           <http://example.com/Team/EPLT35> ;
        sport:score                     "2" ;
        spsocstat:cautionsTotal         "2" ;
        spsocstat:clearancesSuccessful  "28" ;
        spsocstat:cornerKicks           "4" ;
        spsocstat:foulsCommited         "9" ;
        spsocstat:freeKicks             "2" ;
        spsocstat:goalsAgainstTotal     "2" ;
        spsocstat:interceptions         "8" ;
        spsocstat:lineFormation         "4141" ;
        spsocstat:offsides              "1" ;
        spsocstat:passesTotal           "240" ;
        spsocstat:shotsBlocked          "1" ;
        spsocstat:shotsOnGoalTotal      "4" ;
        spsocstat:shotsTotal            "10" ;
        spsocstat:tacklesLost           "5" ;
        spsocstat:tacklesTotal          "10" ;
        spsocstat:tacklesWon            "5" ;
        spsocstat:tacklesWonPercentage  "0.500" .

Arsenal gets its own TeamParticipation object, providing its own performance statistics.

    <http://example.com/Participation/E2128607-EPLT7>
        rdf:type                        sport:TeamParticipation ;
        rdfs:label                      "Arsenal participation in Week 16, EPL" ;
        spstat:eventOutcome             speventoutcome:tie ;
        spstat:scoreOpposing            "2" ;
        spstat:timeOfPossessionPercentage
                "70.2" ;
        sport:alignment                 "home" ;
        sport:participationBy           <http://example.com/Team/EPLT7> ;
        sport:score                     "2" ;
        spsocstat:clearancesSuccessful  "14" ;
        spsocstat:cornerKicks           "11" ;
        spsocstat:foulsCommited         "14" ;
        spsocstat:goalsAgainstTotal     "2" ;
        spsocstat:interceptions         "7" ;
        spsocstat:lineFormation         "4231" ;
        spsocstat:offsides              "2" ;
        spsocstat:passesTotal           "551" ;
        spsocstat:shotsBlocked          "6" ;
        spsocstat:shotsOnGoalTotal      "11" ;
        spsocstat:shotsTotal            "24" ;
        spsocstat:tacklesLost           "7" ;
        spsocstat:tacklesTotal          "13" ;
        spsocstat:tacklesWon            "6" ;
        spsocstat:tacklesWonPercentage  "0.462" .

Here are stub objects for the Teams themselves.

    <http://example.com/Team/EPLT35>
        rdf:type    sport:Team ;
        rdfs:label  "Liverpool" .

    <http://example.com/Team/EPLT7>
        rdf:type    sport:Team ;
        rdfs:label  "Arsenal" .

Now that we have the data, we can query on it using SPARQL. For example, this query
shows us the scores for each team:

    PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs:  <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX sport: <https://sportschema.org/ontologies/main/>
    PREFIX spstat: <https://sportschema.org/ontologies/corestatistics/>

    SELECT ?teamName ?score
    WHERE {
        ?team rdf:type sport:Team ;
              rdfs:label ?teamName .
        ?teamParticipation rdf:type sport:TeamParticipation ;
                           sport:participationBy ?team ;
                           sport:score ?score .
        ?event rdf:type sport:Event ;
               sport:participation ?teamParticipation .
    }

Running the query using Apache Jena's arq tool shows the following output:

    % arq --query queries/event-team-game-winner.rq --data samples/ttl/simple-soccer-example.ttl
    -----------------------
    | teamName    | score |
    =======================
    | "Arsenal"   | "2"   |
    | "Liverpool" | "2"   |
    -----------------------
