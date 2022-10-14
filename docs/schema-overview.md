---
layout: page
title: Schema overview
nav_order: 3
description: "Explaining the thinking behind the structure of the IPTC Sport Schema"
permalink: /schema-overview/
---

# IPTC Sport Schema overview

The IPTC Sport Schema aims to be simple and comprehensive, while leveraging the structures already used in IPTC's 10-year-old
SportsML standard.

This guide explains some of the core structures and patterns used in the IPTC Sport Schema. 

## Key concepts

### Document-based vs open data models

Data models based on XML Schema, such as IPTC's SportsML, treat each data file as a standalone document which conveys a particular set of information.

On the other hand, an RDF-based data model assumes that all data exists in the database together.

The practical result of this is that when querying, we can't simply say "tell me the winner of the game." We have to be specific about exactly which game we mean. All queries must be qualified by filters to only match a given event, sport, league, date etc.

This has led to us creating several generic structures which allow us to
capture richer information about people, teams and events.

### Summary

The model describes three component parts that make up the domain of sports data:
* The structure of a competition. For example matches played in a round, which is itself within a competition instance, that is part of a competition series.
* The participation in a competition, event or action. Teams, atheletes and officials actively participate in competitive events and generate stats about that participation.
* Membership in of a team. Particpation by individuals can be as part of a team. This is expressed in the membership part of the model.

![IPTC Sport Schema high level overview](diagrams/simple-high-level-sport-model.png)

The follow sections describe the patterns used for each of these component parts of the model.


### Competition, event and action: building blocks to describe any competition structure

Competitions are many and varied in structure. In the process of designing the model it was clear there was a need for a flexible and modular appraoch.

The key class is the event this represents the lowests partisipatable thing that has outcome. Things like matches and races that have a result. Activities are more granular than events but do not have an outcome or result in their own right. An example would be a match (event) versus a goal scored (action).

Events will always be part of a competition. In rare cases a competition might have a single event but in the majority of cases a event will be part of a larger competition structure. An event is assocaited with the most granular level of competition. It might be a phase of a competition like a knockout-round or heat. This phase is then assocaited with the overaching competition which itself might be part of a recurring competition series.


### Participation: A container for statistics

When an athlete or a team takes part in an event, we want
to record statistics about each athlete's individual contributions to the event:
goals kicked, penalties received etc.
 
Separately, we want to record the team's contributions, including of course the team's score.

To handle this need, we have introduced the concept of a *Participation* which links people and teams to events.

We define a generic parent *Participation* class and subclasses for *IndividualParticipation* and *TeamParticipation*.

The TeamParticipation object comes into existence as soon as a team is scheduled to compete in an event. The IndividualParticipation comes into existence when the team member is added to the line-up for a team participating in an Event.

![IPTC Sport Schema athlete and team participation example](diagrams/athlete-team-participation.png)

### Linking people to teams: the "Membership" class

In a SportsML document, it is sufficient to say "Athlete A and
Athlete B play for Team 1", so we could imagine a relationship like the
following:

![Simple athlete to team relationship](diagrams/simple-athlete-team.png)

But in a world where every fact about every sports event, team, athlete (player) and
statistic may be added to an ever-growing database, we need to specify more
information about the relationship. Otherwise, what would happen when an athlete switches teams?
Or how would we represent a athlete that plays simultaneously for a league team and the national team?

To solve this, we introduce the concept of a *Membership*, a separate object
that sits between Athlete and Team which can include more details such as a
"from" and "to" date:

![IPTC Sport Schema athlete to team relationship](diagrams/athlete-membership-team.png)

In this way, we can represent things such as:
* A coach that works with more than one team at the same time, even in different sports
* An athlete that moves from one team to another over the course of their career
* An athlete that switches sports completely! (Michael Jordan, for example, switched from NBA Basketball to Major League Baseball, and back again)

This approach makes querying slightly more difficult, but not much more. In SPARQL, a query might look like the following:

```
SELECT ?teamName ?athleteName ?athletePosition ?dob ?uniformNumber
WHERE
{
    ?athlete rdf:type sport:Athlete ;
            rdfs:label ?athleteName .
    ?membership rdf:type sport:IndividualMembership ;
                sport:membershipBy ?player ;
                sport:membershipOf ?team .
    ?team rdf:type sport:Team ;
          rdfs:label ?teamName ;
          sport:membership ?membership .
    OPTIONAL { ?membership sport:positionRegular ?athletePosition . }
    OPTIONAL { ?player sport:dateOfBirth ?dob . }
    OPTIONAL { ?membership sport:uniformNumber ?uniformNumber . }
    FILTER (?team = <http://example.com/Team/T2>) # Aston Villa
}
```

See the [example queries](../queries/) for more examples.


