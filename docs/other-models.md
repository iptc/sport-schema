---
layout: page
title: Comparison with Other Models
nav_order: 6
description: 
permalink: /other-models/
---
# Comparison with other sport data models

While planning and working on IPTC Sport Schema, we of course consulted similar models that cover sports results and data to some extent. This page describes some of the work we have done comparing IPTC Sport Schema to other data models.

## Competition Structure General

|IPTC Sport Schema      | IPTC SportsML |  IOC      |OpenAthletics      |BBC      |Oly Example      |EPL Example      |Note
|---|---|---|---|---|---|---|---|
|GoverningBody    | n/a | Organization    |SportsGoverningBody        | GoverningBody        |IOC      |UEFA(?)      |
|Competition    | |    |CompetitionSeries        |RecurringCompetition      |Summer Olympics      |N/A      |
|Competition    | tournament | Competition    |Competition        |DivisionalCompetition      |Tokyo 2020      |EPL      |New term needed? Think of overall medal standings and NOC "Participation"
|Competition    | tournament | Event    |Competition        |MultiStageCompetition       |Men's 800M      |EPL 2021-22      |Results in award (medal) at end
|CompetitionPhase    | tournament-part | Phase    |Round        |Round      |Men's 800M Semi-Final      |Week 1      |
|Event  | sports-event | Event Unit       |UnitCompetition        |UnitCompetition      |Men's 800M Semi-Final Heat 1     |ManU vs Chelsea Dec. 4       |

## Competition Structure Olympic Men's Track Cycling (Sprint)

|IPTC Sport Schema      | IPTC SportsML | IOC      |OpenAthletics      |BBC      |Event/Phase/Comp
|---|---|---|---|---|---|---|
|GoverningBody    | n/a | Organization    |SportsGoverningBody        | GoverningBody        |IOC
|Competition    | |     |CompetitionSeries        |RecurringCompetition      |Summer Olympics
|Competition    | tournament | Competition    |Competition        |DivisionalCompetition      |Tokyo 2020
|Competition  | tournament | Event       |Competition        |MultiStageCompetition      |Men's Sprint
|CompetitionPhase  | tournament-part | Phase       |Round        |KnockoutCompetition      |Men's Sprint Semi-Finals
|CompetitionPhase  | tournament-part | Event Unit       |UnitCompetition (?)       |Round      |Men's Sprint Semi-Finals Heat 1
|Event  | sports-event | Event Unit       |UnitCompetition        |UnitCompetition      |Men's Sprint Semi-Finals Heat 1, Race 1


## Competitors and Membership

|IPTC Sport Schema      |IPTC SportsML | IOC      |OpenAthletics      |BBC      |Oly Example      |EPL Example      |Note
|---|---|---|---|---|---|---|---|
|GoverningBody    | | Organization    |GoverningBody, Federation, Organization        |GoverningBody         |Canadian Olympic Committee, Badminton World Federation     |UEFA      |IOC Organization is NOC and/or International Federation
|Team    | team | Team    |Team    |CompetitiveSportingOrganisation          |Peru Men's Hockey      |Chelsea      |BBC includes NOC
|Athlete    | player | Athlete    |Athlete    |Person          |Eileen Gu      |Mohamed Salah      |


References:
* [ODF Common Codes](https://odf.olympictech.org/2020-Tokyo/codes/HTML/og_cc/Discipline.htm)
* [OpenAthletics Competition Model](https://w3c.github.io/opentrack-cg/spec/model/#competition-series)
* [BBC Sport Ontology](https://iptc.org/std/other/bbc-ontologies/sport.html)

# Competition Types and Relationships

## English Premier League

|Competition      |Type      |Relationship      |Parent
|---|---|---|---|
|EPL 2022    |Season    |InstanceOf    |EPL

## Olympics

|Competition      |Type      |Relationship      |Parent
|---|---|---|---|
|2020 Men's 800m    |Tournament    |HasParentComp    |2020 Summer Olympics
|2020 Summer Olympics    |Season    |InstanceOf    |Summer Olympics
|Summer Olympics    |Recurring    |HasGoverningBody    |IOC

## Giro d'Italia

|Competition      |Type      |Relationship      |Parent
|---|---|---|---|
|Giro d'Italia 2019    |Season    |InstanceOf    |Giro d'Italia
|Giro d'Italia 2019    |Season    |HasParentComp    |UCI World Tour 2019
|Giro d'Italia    |Recurring    |HasParentComp    |UCI World Tour
|UCI World Tour 2019    |Season    |InstanceOf    |UCI World Tour
|UCI World Tour    |Recurring    |HasGoverningBody    |Union Cycliste Internationale


# Team Membership

## Use Cases

What countries are winning in the Olympics medal standings?

What country is winning the Davis Cup?

image::https://github.com/iptc/sport-model/blob/silver-brendan-ontology/docs/diagrams/team-membership.png[Team Membership Diagram]


