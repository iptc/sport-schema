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
% arq --data=samples/ttl/soccer-standings.ttl --query=queries/season-league-standings.rq 
---------------------------------------------------------------------------------------------------------------
| Team                       | GP   | P    | W    | L    | D    | GF   | GA   | GD    | WHOME | LHOME | WAWAY |
===============================================================================================================
| "Manchester City"          | "23" | "53" | "16" | "2"  | "5"  | "46" | "14" | "32"  | "9"   | "1"   | "7"   |
| "Manchester United"        | "24" | "46" | "13" | "4"  | "7"  | "50" | "31" | "19"  | "5"   | "4"   | "8"   |
| "Leicester City"           | "24" | "46" | "14" | "6"  | "4"  | "42" | "26" | "16"  | "6"   | "5"   | "8"   |
| "Liverpool"                | "24" | "40" | "11" | "6"  | "7"  | "45" | "32" | "13"  | "7"   | "3"   | "4"   |
| "Chelsea"                  | "23" | "39" | "11" | "6"  | "6"  | "38" | "24" | "14"  | "5"   | "2"   | "6"   |
| "West Ham United"          | "23" | "39" | "11" | "6"  | "6"  | "34" | "28" | "6"   | "5"   | "3"   | "6"   |
| "Everton"                  | "22" | "37" | "11" | "7"  | "4"  | "34" | "30" | "4"   | "4"   | "5"   | "7"   |
| "Tottenham Hotspur"        | "23" | "36" | "10" | "7"  | "6"  | "36" | "25" | "11"  | "5"   | "4"   | "5"   |
| "Aston Villa"              | "22" | "36" | "11" | "8"  | "3"  | "36" | "24" | "12"  | "5"   | "4"   | "6"   |
| "Arsenal"                  | "24" | "34" | "10" | "10" | "4"  | "31" | "25" | "6"   | "5"   | "4"   | "5"   |
| "Leeds United"             | "23" | "32" | "10" | "11" | "2"  | "40" | "42" | "-2"  | "4"   | "5"   | "6"   |
| "Wolverhampton Wanderers"  | "24" | "30" | "8"  | "10" | "6"  | "25" | "32" | "-7"  | "4"   | "4"   | "4"   |
| "Southampton"              | "23" | "29" | "8"  | "10" | "5"  | "30" | "39" | "-9"  | "5"   | "6"   | "3"   |
| "Crystal Palace"           | "24" | "29" | "8"  | "11" | "5"  | "27" | "42" | "-15" | "4"   | "5"   | "4"   |
| "Brighton and Hove Albion" | "24" | "26" | "5"  | "8"  | "11" | "25" | "30" | "-5"  | "1"   | "4"   | "4"   |
| "Burnley"                  | "23" | "26" | "7"  | "11" | "5"  | "17" | "29" | "-12" | "4"   | "5"   | "3"   |
| "Newcastle United"         | "23" | "25" | "7"  | "12" | "4"  | "25" | "38" | "-13" | "4"   | "6"   | "3"   |
| "Fulham"                   | "23" | "18" | "3"  | "11" | "9"  | "19" | "31" | "-12" | "1"   | "7"   | "2"   |
| "West Bromwich Albion"     | "24" | "13" | "2"  | "15" | "7"  | "19" | "55" | "-36" | "1"   | "7"   | "1"   |
| "Sheffield United"         | "23" | "11" | "3"  | "18" | "2"  | "15" | "37" | "-22" | "2"   | "9"   | "1"   |
---------------------------------------------------------------------------------------------------------------
```

```bash
% arq --data=samples/ttl/soccer-match-03.ttl --query=queries/event-team-starting-lineup.rq
----------------------------------------------------------------------------------------------------------
| teamName               | playerName               | playerPos                                          |
==========================================================================================================
| "Aston Villa"          | "Ahmed El Mohamady"      | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "Aston Villa"          | "Anwar El Ghazi"         | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "Aston Villa"          | "Bertrand Traoré"        | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "Aston Villa"          | "Douglas Luiz"           | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "Aston Villa"          | "Emiliano Martínez"      | <http://cv.iptc.org/newscodes/spsocpos/goalkeeper> |
| "Aston Villa"          | "Ezri Konsa Ngoyo"       | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "Aston Villa"          | "John McGinn"            | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "Aston Villa"          | "Matt Targett"           | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "Aston Villa"          | "Ollie Watkins"          | <http://cv.iptc.org/newscodes/spsocpos/forward>    |
| "Aston Villa"          | "Ross Barkley"           | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "Aston Villa"          | "Tyrone Mings"           | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "West Bromwich Albion" | "Ainsley Maitland-Niles" | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "West Bromwich Albion" | "Callum Robinson"        | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "West Bromwich Albion" | "Conor Gallagher"        | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "West Bromwich Albion" | "Conor Townsend"         | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "West Bromwich Albion" | "Darnell Furlong"        | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "West Bromwich Albion" | "Kyle Bartley"           | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
| "West Bromwich Albion" | "Matheus Pereira"        | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "West Bromwich Albion" | "Mbaye Diagne"           | <http://cv.iptc.org/newscodes/spsocpos/forward>    |
| "West Bromwich Albion" | "Okay Yokuslu"           | <http://cv.iptc.org/newscodes/spsocpos/midfielder> |
| "West Bromwich Albion" | "Sam Johnstone"          | <http://cv.iptc.org/newscodes/spsocpos/goalkeeper> |
| "West Bromwich Albion" | "Semi Ajayi"             | <http://cv.iptc.org/newscodes/spsocpos/defender>   |
----------------------------------------------------------------------------------------------------------
```

```bash
% arq --data=samples/ttl/team-roster.ttl --query=queries/season-team-players.rq
---------------------------------------------------------------------------------------------------------------------------------
| teamName       | playerName              | playerPos                                                  | dob          | jersey |
=================================================================================================================================
| "Dallas Stars" | "Ales Hemsky"           | <http://cv.iptc.org/newscodes/spichposition/right-forward> | "1983-08-13" | "83"   |
| "Dallas Stars" | "Alex Goligoski"        | <http://cv.iptc.org/newscodes/spichposition/defenseman>    | "1985-07-30" | "33"   |
| "Dallas Stars" | "Antoine Roussel"       | <http://cv.iptc.org/newscodes/spichposition/left-forward>  | "1989-11-21" | "21"   |
| "Dallas Stars" | "Austin Smith"          | <http://cv.iptc.org/newscodes/spichposition/right-forward> | "1988-11-07" | "9"    |
| "Dallas Stars" | "Branden Troock"        | <http://cv.iptc.org/newscodes/spichposition/right-forward> | "1994-03-20" | ""     |
| "Dallas Stars" | "Brendan Ranford"       | <http://cv.iptc.org/newscodes/spichposition/left-forward>  | "1992-05-03" | "39"   |
| "Dallas Stars" | "Brett Pollock"         | <http://cv.iptc.org/newscodes/spichposition/center>        | "1996-03-17" | ""     |
| "Dallas Stars" | "Brett Ritchie"         | <http://cv.iptc.org/newscodes/spichposition/right-forward> | "1993-07-01" | "20"   |
| "Dallas Stars" | "Cameron Gaunce"        | <http://cv.iptc.org/newscodes/spichposition/defenseman>    | "1990-03-19" | "36"   |
| "Dallas Stars" | "Cody Eakin"            | <http://cv.iptc.org/newscodes/spichposition/center>        | "1991-05-24" | "20"   |
| "Dallas Stars" | "Colton Sceviour"       | <http://cv.iptc.org/newscodes/spichposition/center>        | "1989-04-20" | "22"   |
| "Dallas Stars" | "Cristopher Nilstorp"   | <http://cv.iptc.org/newscodes/spichposition/goalie>        | "1984-02-16" | "41"   |
| "Dallas Stars" | "Curtis McKenzie"       | <http://cv.iptc.org/newscodes/spichposition/left-forward>  | "1991-02-22" | "11"   |
| "Dallas Stars" | "Derek Meech"           | <http://cv.iptc.org/newscodes/spichposition/defenseman>    | "1984-04-21" | ""     |
| "Dallas Stars" | "Emil Molin"            | <http://cv.iptc.org/newscodes/spichposition/center>        | "1993-02-03" | ""     |
| "Dallas Stars" | "Esa Lindell"           | <http://cv.iptc.org/newscodes/spichposition/defenseman>    | "1994-05-23" | ""     |
```
