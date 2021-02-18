# sport-model

Working on the next generation of SportsML, based on semantic web technology.

## About the IPTC Sport Model

It is currently a work in progress. We are experimenting with different
approaches based on a set of use cases documented at
https://github.com/iptc/sport-model/wiki/Use-Cases .

We are creating an RDF model that represents schedules, statistics and results
for all levels of all sports, for both human and machine consumption.

## Repository layout

`queries`:

Contains sample SPARQL queries exercising some of the use cases.

`samples`:

Contains data files in N3 and Turtle (`.ttl`) format.

`samples/sportsml`:

Examples in SportsML, to be converted to N3 using the XSLT script in `tools`.

`tools`:

The XSLT `tools/sportsML-to-n3.xsl` can be used to convert the XML examples
in `samples/sportsml` into N3 triples. (The conversion from N3 to Turtle was
performed manually using Nick Humfrey's https://www.easyrdf.org/converter,
in the future we plan to replace this with a script)

## Running example queries

If you install
[Apache Jena's arq tool](https://jena.apache.org/documentation/query/index.html),
you can run SPARQL queries from the command line using our sample data files and
queries.

Query examples:

```bash
% arq --data=samples/soccer-standings.ttl --query=queries/season-league-standings.rq 
---------------------------------------------
| name                       | eventsPlayed |
=============================================
| "Southampton"              | "23"         |
| "Arsenal"                  | "24"         |
| "Liverpool"                | "24"         |
| "Sheffield United"         | "23"         |
| "Chelsea"                  | "23"         |
| "Leicester City"           | "24"         |
| "Brighton and Hove Albion" | "24"         |
| "Burnley"                  | "23"         |
| "Leeds United"             | "23"         |
| "West Bromwich Albion"     | "24"         |
| "Aston Villa"              | "22"         |
| "Manchester United"        | "24"         |
| "Newcastle United"         | "23"         |
| "West Ham United"          | "23"         |
| "Fulham"                   | "23"         |
| "Everton"                  | "22"         |
| "Crystal Palace"           | "24"         |
| "Manchester City"          | "23"         |
| "Tottenham Hotspur"        | "23"         |
| "Wolverhampton Wanderers"  | "24"         |
---------------------------------------------
```

```bash
% arq --data=samples/soccer-match-specific.ttl --query=queries/event-team-starting-lineup.rq 
-------------------------------------------------------------------------------------------
| teamName      | playerName    | playerPos                                               |
===========================================================================================
| "Aston Villa" | "Alan Hutton" | <http://cv.iptc.org/newscodes/spsocposition/defender>   |
| "Aston Villa" | "Brad Guzan"  | <http://cv.iptc.org/newscodes/spsocposition/goalkeeper> |
-------------------------------------------------------------------------------------------
```
