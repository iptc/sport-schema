# Running example queries

If you install
[Apache Jena's arq tool](https://jena.apache.org/documentation/query/index.html),
you can run SPARQL queries from the command line using our sample data files and
queries.

Query examples, with references to the [use cases](https://github.com/iptc/sport-model/wiki/Use-Cases)
from our design documentation:

## All-time Questions

### Player
1. Career stats (Goals, assists, etc.)
2. Biographical details (Height, weight, nationality, place and date of birth, etc.)

### Team
1. Overall record
2. Championships/Competitions won

## Season Questions

### Player
1. Season stats (Goals, assists, etc.)

### Team
1. Who plays for the team? (Includes jersey number, position, etc.)

```bash
arq --data samples/ttl/team-roster.ttl --query queries/season-team-players.rq
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

2. What is the team's record so far? (Games played, wins, losses, ties, clean sheets/shutouts, etc.)
3. What is the team record broken down into home and away events?
4. Scoring for and against in current season?
5. How many penalty shots against and allowed?
6. Infractions committed, broken down by type (yellow/red, fouls, TK, particular for other sports)

### League
1. What are the current standings? (Includes games played, wins, losses, ties, etc.)

```bash
arq --data samples/ttl/soccer-standings.ttl --query queries/season-league-standings.rq 
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

2. Who is the scoring leader?
3. Who are the top 20 scorers?
4. What is the full league schedule (including fixtures and results)?

Note that we don't yet include results in this query.

```bash
arq --data samples/ttl/league-schedule.ttl --query queries/league-schedule.rq
--------------------------------------------------------------------------------------------------------------------------
| week | displayDate  | displayTime | match                                                | siteName                    |
==========================================================================================================================
| 1    | "2020-09-12" | "12:30"     | "Fulham v Arsenal"                                   | "Craven Cottage"            |
| 1    | "2020-09-12" | "15:00"     | "Crystal Palace v Southampton"                       | "Selhurst Park"             |
| 1    | "2020-09-12" | "17:30"     | "Liverpool v Leeds United"                           | "Anfield"                   |
| 1    | "2020-09-12" | "20:00"     | "West Ham United v Newcastle United"                 | "London Stadium"            |
| 1    | "2020-09-13" | "14:00"     | "West Bromwich Albion v Leicester City"              | "The Hawthorns"             |
[ ... ]
| 38   | "2021-05-23" | "16:00"     | "Sheffield United v Burnley"                         | "Bramall Lane"              |
| 38   | "2021-05-23" | "16:00"     | "Leeds United v West Bromwich Albion"                | "Elland Road"               |
| 38   | "2021-05-23" | "16:00"     | "West Ham United v Southampton"                      | "London Stadium"            |
| 38   | "2021-05-23" | "16:00"     | "Aston Villa v Chelsea"                              | "Villa Park"                |
| 38   | "2021-05-23" | "16:00"     | "Manchester City v Everton"                          | "Etihad Stadium"            |
| 38   | "2021-05-23" | "16:00"     | "Arsenal v Brighton and Hove Albion"                 | "Emirates Stadium"          |
--------------------------------------------------------------------------------------------------------------------------

5. What are the teams in a competition or league?
6. Infractions leaders
7. What is the structure of the seasonal competition? (league competition, regular and post-season, groups/knockout, etc.)

## Event Questions

### Player

1. Was this player in the starting line up?

```bash
arq --data samples/ttl/soccer-match-01.ttl --query queries/event-player-starting-lineup.rq
----------------------------------------------------------------------------------------------------------
| teamName          | playerName                 | playerStatus                                          |
==========================================================================================================
| "Aston Villa"     | "Alan Hutton"              | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Aly Cissokho"             | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Andreas Weimann"          | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Ashley Westwood"          | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Brad Guzan"               | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Carlos Sánchez"           | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Charles N'Zogbia"         | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Christian Benteke"        | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Ciaran Clark"             | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Darren Bent"              | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Fabian Delph"             | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Jack Grealish"            | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Kieran Richardson"        | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Leandro Bacuna"           | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Nathan Baker"             | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Philippe Senderos"        | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Aston Villa"     | "Shay Given"               | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Aston Villa"     | "Tom Cleverley"            | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Aleksandar Kolarov"       | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Bacary Sagna"             | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Manchester City" | "David Silva"              | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Edin Dzeko"               | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Eliaquim Mangala"         | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Fernando Francisco Reges" | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Manchester City" | "Fernando Luiz Rosa"       | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Frank Lampard"            | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Manchester City" | "Gnegneri Yaya Touré"      | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "James Milner"             | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Jesús Navas"              | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Manchester City" | "Joe Hart"                 | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Martín Demichelis"        | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Manchester City" | "Pablo Zabaleta"           | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Sergio Agüero"            | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Stevan Jovetic"           | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
| "Manchester City" | "Vincent Kompany"          | <http://cv.iptc.org/newscodes/spplayerstatus/starter> |
| "Manchester City" | "Willy Caballero"          | <http://cv.iptc.org/newscodes/spplayerstatus/bench>   |
----------------------------------------------------------------------------------------------------------
```

2. Which players scored goals and when?

TBD - requires Actions

3. How many minutes did this player play?

```bash
arq --data samples/ttl/soccer-match-01.ttl --query queries/event-player-minutes-played.rq
----------------------------------------------
| playerName                 | minutesPlayed |
==============================================
| "Alan Hutton"              | 90            |
| "Aleksandar Kolarov"       | 90            |
| "Aly Cissokho"             | 90            |
| "Andreas Weimann"          | 61            |
| "Ashley Westwood"          | 90            |
| "Brad Guzan"               | 90            |
| "Charles N'Zogbia"         | 71            |
| "Christian Benteke"        | 29            |
| "David Silva"              | 84            |
| "Edin Dzeko"               | 64            |
| "Eliaquim Mangala"         | 90            |
| "Fabian Delph"             | 90            |
| "Fernando Francisco Reges" | 26            |
| "Fernando Luiz Rosa"       | 56            |
| "Frank Lampard"            | 34            |
| "Gnegneri Yaya Touré"      | 90            |
| "Jack Grealish"            | 19            |
| "James Milner"             | 90            |
| "Jesús Navas"              | 6             |
| "Joe Hart"                 | 90            |
| "Kieran Richardson"        | 71            |
| "Leandro Bacuna"           | 19            |
| "Nathan Baker"             | 90            |
| "Pablo Zabaleta"           | 90            |
| "Philippe Senderos"        | 90            |
| "Sergio Agüero"            | 90            |
| "Tom Cleverley"            | 90            |
| "Vincent Kompany"          | 90            |
----------------------------------------------
```

4. Did this player score a goal?

```bash
arq --data samples/ttl/soccer-match-05.ttl --query queries/event-player-goal-scorers.rq 
----------------------------
| playerName       | goals |
============================
| "Joseph Willock" | "1"   |
| "Mohamed Salah"  | "1"   |
----------------------------
```

5. What type of goal? (Penalty, freekick, power-play, three-pointer, field goal, etc.)
6. What method of goal? (Header, left foot, rush, pass, etc.)
7. Did the player assist a goal?
8. Was the player substituted? - Y/N and time they went off (NB: this is same as "1. Who were the subs for each team in this match?" Right?
9. Was this player penalized and what for? (Includes penalty level: straight red, major, minor, etc. Includes time)
10. What are this player's stats for the game?

```bash
% arq --data samples/ttl/soccer-match-01.ttl --query queries/event-player-stats.rq
----------------------------------------------------------------------------------------------------
| teamName          | playerName                 | stat                                | statValue |
====================================================================================================
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:shots-off-goal-total      | 1         |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:touches                   | 34        |
| "Aston Villa"     | "Charles N'Zogbia"         | spstat:events-started               | 1         |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:passes-total              | 21        |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:passes-complete           | 12        |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:clearances-successful     | 2         |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:fouls-commited            | 1         |
| "Aston Villa"     | "Charles N'Zogbia"         | spstat:time-played-total            | 71        |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:goals-against-total       | 0         |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:passes-complete-3rd-final | 4         |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:shots-total               | 1         |
| "Aston Villa"     | "Charles N'Zogbia"         | spsocstat:passes-incomplete         | 9         |
| "Aston Villa"     | "Brad Guzan"               | spsocstat:touches                   | 45        |
| "Aston Villa"     | "Brad Guzan"               | spsocstat:save-percentage           | 0.714     |
[ ... ]
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:passes-complete           | 59        |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:passes-complete-long      | 1         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:clearances-successful     | 3         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:shutouts                  | 1         |
| "Manchester City" | "Eliaquim Mangala"         | spstat:time-played-total            | 90        |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:aerials-won               | 4         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:goals-against-total       | 0         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:fouls-suffered            | 1         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:shots-total               | 1         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:passes-incomplete         | 5         |
| "Manchester City" | "Eliaquim Mangala"         | spsocstat:interceptions             | 2         |
----------------------------------------------------------------------------------------------------
```

### Team

1. What is the starting lineup? (including position slated)

```bash
arq --data=samples/ttl/soccer-match-03.ttl --query=queries/event-team-starting-lineup.rq
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

2. Which team won the game?

```bash
arq --data samples/ttl/soccer-match-02.ttl --query queries/event-team-game-winner.rq
--------------------------------------------
| name             | score | opposingScore |
============================================
| "Leicester City" | "2"   | "1"           |
--------------------------------------------
```

3. What was the score of the game?

```bash
arq --data samples/ttl/soccer-match-05.ttl --query queries/event-team-game-score.rq
------------------------------
| name               | score |
==============================
| "Liverpool"        | "1"   |
| "Newcastle United" | "1"   |
------------------------------
```

4. Who were the substitutes and positions played? (baseball, soccer, American football)

TBD (requires Actions)

5. What were the stats for each team?

```bash
arq --data samples/ttl/soccer-match-01.ttl --query queries/event-team-stats.rq 
------------------------------------------------------------------------------------------
| teamName          | stat                                 | statValue                   |
==========================================================================================
| "Aston Villa"     | spsocstat:shots-on-goal-total        | 1                           |
| "Aston Villa"     | spstat:score-opposing                | 2                           |
| "Aston Villa"     | rdf:type                             | sport:TeamParticipation     |
| "Aston Villa"     | spsocstat:line-formation             | 433                         |
| "Aston Villa"     | spsocstat:fouls-commited             | 4                           |
| "Aston Villa"     | sport:participationBy                | <http://sport.org/Team/T2>  |
| "Aston Villa"     | sport:alignment                      | "home"                      |
| "Aston Villa"     | spstat:time-of-possession-percentage | 31.6                        |
| "Aston Villa"     | sport:score                          | "0"                         |
| "Aston Villa"     | sport:eventOutcome                   | "loss"                      |
| "Aston Villa"     | spsocstat:shots-total                | 6                           |
| "Manchester City" | spsocstat:shots-on-goal-total        | 7                           |
| "Manchester City" | spstat:score-opposing                | 0                           |
| "Manchester City" | rdf:type                             | sport:TeamParticipation     |
| "Manchester City" | spsocstat:line-formation             | 442                         |
| "Manchester City" | spsocstat:fouls-commited             | 6                           |
| "Manchester City" | sport:participationBy                | <http://sport.org/Team/T12> |
| "Manchester City" | sport:alignment                      | "away"                      |
| "Manchester City" | spstat:time-of-possession-percentage | 68.4                        |
| "Manchester City" | sport:score                          | "2"                         |
| "Manchester City" | spsocstat:corner-kicks               | 7                           |
| "Manchester City" | sport:eventOutcome                   | "win"                       |
| "Manchester City" | spsocstat:shots-total                | 27                          |
------------------------------------------------------------------------------------------
```

6. Who was penalized? (Team level)

First version, any foul:
```bash
arq --data samples/ttl/soccer-match-01.ttl --query queries/event-team-penalties.rq
-------------------------------------------------------------
| teamName          | playerName           | foulsCommitted |
=============================================================
| "Aston Villa"     | "Aly Cissokho"       | 1              |
| "Aston Villa"     | "Charles N'Zogbia"   | 1              |
| "Aston Villa"     | "Nathan Baker"       | 1              |
| "Aston Villa"     | "Tom Cleverley"      | 1              |
| "Manchester City" | "Aleksandar Kolarov" | 2              |
| "Manchester City" | "Edin Dzeko"         | 1              |
| "Manchester City" | "Fernando Luiz Rosa" | 1              |
| "Manchester City" | "James Milner"       | 2              |
-------------------------------------------------------------
```

Second version, only red/yellow cards:

TBD (requires Actions)

### League

1. What are the current scores? (Scoreboard)
```bash
arq --data samples/ttl/league-schedule.ttl --query queries/event-league-scores.rq
-----------------------------------------------------------------------------------------------------
| displayDate  | displayTime | match                                | homeTeamScore | awayTeamScore |
=====================================================================================================
| "2021-02-15" | "18:00"     | "West Ham United v Sheffield United" | "3"           | "0"           |
| "2021-02-15" | "20:00"     | "Chelsea v Newcastle United"         | "2"           | "0"           |
-----------------------------------------------------------------------------------------------------
```
2. What is the current status of an event (pre-, mid-, post-, postponed, suspended, canceled, etc.)
```bash
arq --data samples/ttl/league-schedule.ttl --query queries/event-league-status.rq 
-------------------------------------------------------------------------------------------------------------------------------
| displayDate  | displayTime | match                                | status                                                  |
===============================================================================================================================
| "2021-02-15" | "18:00"     | "West Ham United v Sheffield United" | <http://cv.iptc.org/newscodes/speventstatus/post-event> |
| "2021-02-15" | "20:00"     | "Chelsea v Newcastle United"         | <http://cv.iptc.org/newscodes/speventstatus/post-event> |
-------------------------------------------------------------------------------------------------------------------------------
```
3. What was the result the last time these two teams met? Across all competitions this season

TBD

4. Where are today's matches being played?
```bash
arq --data samples/ttl/league-schedule.ttl --query queries/event-league-site.rq
-----------------------------------------------------------------------------------------------------
| displayDate  | displayTime | match                                         | siteName             |
=====================================================================================================
| "2021-05-23" | "16:00"     | "Liverpool v Crystal Palace"                  | "Anfield"            |
| "2021-05-23" | "16:00"     | "Wolverhampton Wanderers v Manchester United" | "Molineux Stadium"   |
| "2021-05-23" | "16:00"     | "Fulham v Newcastle United"                   | "Craven Cottage"     |
| "2021-05-23" | "16:00"     | "Leicester City v Tottenham Hotspur"          | "King Power Stadium" |
| "2021-05-23" | "16:00"     | "Sheffield United v Burnley"                  | "Bramall Lane"       |
| "2021-05-23" | "16:00"     | "Leeds United v West Bromwich Albion"         | "Elland Road"        |
| "2021-05-23" | "16:00"     | "West Ham United v Southampton"               | "London Stadium"     |
| "2021-05-23" | "16:00"     | "Aston Villa v Chelsea"                       | "Villa Park"         |
| "2021-05-23" | "16:00"     | "Manchester City v Everton"                   | "Etihad Stadium"     |
| "2021-05-23" | "16:00"     | "Arsenal v Brighton and Hove Albion"          | "Emirates Stadium"   |
-----------------------------------------------------------------------------------------------------
```
5. What time does game begin?
```bash
arq --data samples/ttl/league-schedule.ttl --query queries/event-league-starttime.rq
---------------
| displayTime |
===============
| "20:00"     |
---------------
```
6. Who are the referees?

```bash
arq --data samples/ttl/soccer-match-01.ttl --query queries/event-league-referees.rq
--------------------------------------------------------------------------
| officialName | officialPosition                                        |
==========================================================================
| "Chris Foy"  | <http://cv.iptc.org/newscodes/vendoffpos/main-official> |
--------------------------------------------------------------------------
```

7. What was the attendance for this match?
```bash
arq --data samples/ttl/soccer-match-01.ttl --query queries/event-league-attendance.rq 
--------------
| attendance |
==============
| 32964      |
--------------
```