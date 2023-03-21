---
layout: page
title: Use Cases
permalink: /use-cases/
nav_order: 4
---
# IPTC Sport Schema Use Cases

To plan and track progress, and to make sure our model solves real-world problems, we are taking a use case-driven approach when
designing the IPTC Sport Schema.

The use cases are written as questions. Each use case/question should be answered with a SPARQL query based on our sample triples generated from converted SportsML files. 

Implementing all of these use cases, along with the corresponding sample data triples, is a work in progress, but most use cases are now implemented.

## All-Time Statistics and Results Questions

### Player (also known as Athlete)
1. What are Player X's all-time career stats (Goals, assists, etc.)?
1. What are Player X's biographical details (Height, weight, nationality, place and date of birth, etc.)?
1. Which teams did Player X play for during their career?

### Team
1. What is Team Y's overall record throughout history (or in a given date range)?
1. Which championships/competitions has Team Y won throughout history (or in a given date range)?
1. Which players were on Team Y at a given time (including "right now")?
1. Handling teams that move cities and change names - e.g. New Orleans Jazz became Utah Jazz - all players were the same, it was the same legals entity, but the name and home stadium changed. (*Not yet handled*)

## Season Questions 

### Player
1. What are Player X's stats for Season Z (Goals, assists, etc.)?

### Team
1. Who plays for Team Y in Season Z (including jersey number, position, etc.)?
1. What is Team Y's record so far in Season Z (games played, wins, losses, ties, clean sheets/shutouts, etc.)?
1. What is Team Y's record for Season Z broken down into home and away events?
1. What were the scores for and against for Team Y in Season Z?
1. How many penalty shots were taken for and allowed against Team Y in Season Z?
1. What infractions were committed by Team Y in Season Z, broken down by type (yellow/red, fouls, TK, particular for other sports)?

### League
1. What are the current team standings for Season Z? (Includes games played, wins, losses, ties, etc.)
1. Who is the current scoring leader for Season Z?
1. Which players are the top 20 scorers across all teams in Season Z?
1. What is the full league schedule (including fixtures and results) for Season Z?
1. What are the teams in a competition or league as of a given date?
1. Who (players or teams?) are the infractions leaders across Sseason Z?
1. What is the structure of the competition for Season Z (league competition, regular and post-season, groups/knockout, etc.)?

## Event Questions 

### Player
1. Was Player X in the starting line up for Team Y at Event E?
1. Which players scored goals and when at Event E?
1. How many minutes did Player X play at Event E?
1. Did Player X score a goal at Event E?
1. What type of goal was scored by Player X at Event E (Penalty, freekick, power-play, three-pointer, field goal, etc.)?
1. What method of goal was scored by Player X at Event E (Header, left foot, rush, pass, etc.)?
1. Did Player X assist a goal at Event E?
1. Was Player X substituted at Event E, and if so at what time?
1. Was Player X penalised at Event E and if so when and what for (Includes penalty level: straight red, major, minor, etc.)?

### Team
1. What was the starting lineup for Team Y at Event E? (including positions slated)
IN PROGRESS[link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+spstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspstat%2F%3E%0Aprefix+spsocpos%3A+%3Cundefined%3E%0A%0A%23+Use+case%3A+Event+%2F+Team+%2F+1.+What+is+the+starting+lineup%3F+(including+position+slated)%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+%3FteamName+%3FplayerName+%3FplayerPos%0AWHERE+%7B+%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+%3B%0A+++++++++++sport%3Aparticipation+%3Fplayerperf+.%0A++++%3Fplayerperf+sport%3AparticipationBy+%3Fplayer+%3B%0A++++++++++++++++rdf%3Atype+sport%3AIndividualParticipation+.%0A++++%3Fplayer+rdfs%3Alabel+%3FplayerName+%3B+%0A++++++++++++rdf%3Atype+sport%3AAthlete+.+%0A++++%3Fplayerperf+sport%3Astatus+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspperstatus%2Fstarter%3E+.%0A++++%3Fteam+sport%3Amembership+%3Fmembers+.+%0A++++%3Fmembers+sport%3AmembershipBy+%3Fplayer+%3B%0A+++++++++++++sport%3ApositionRegular+%3FplayerPos+%3B%0A+++++++++++++sport%3AmembershipOf+%3Fteam+.%0A++++%3Fteam+rdf%3Atype+sport%3ATeam+%3B%0A++++++++++rdfs%3Alabel+%3FteamName+.%0A%7D%0AORDER+BY+%3FteamName+%3FplayerName)
1. Which team won the game?
IN PROGRESS [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+spstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspstat%2F%3E%0A%0A%23+Use+case%3A+Event+%2F+Team+%2F+2.+Which+team+won+the+game%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+%3FteamName+%3Fscore+%3FopposingScore%0AWHERE+%7B+%0A++++%3Fteam+rdf%3Atype+sport%3ATeam+.%0A++++%3Fteam+rdfs%3Alabel+%3FteamName+.%0A++++%3FteamParticipation+sport%3AparticipationBy+%3Fteam+.%0A++++%3FteamParticipation+spstat%3Ascore+%3Fscore+.%0A++++%3FteamParticipation+spstat%3Ascore-opposing+%3FopposingScore+.%0A++++FILTER+(+%3Fscore+%3E+%3FopposingScore+)%0A%7D)
1. What was the score of the game? IN PROGRESS [live link to query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+spstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspstat%2F%3E%0A%0A%23+Use+case%3A+Event+%2F+Team+%2F+3.+What+was+the+score+of+the+game%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+%3Fname+%3Fscore%0AWHERE+%7B+%0A++++%3Fteam+rdf%3Atype+sport%3ATeam+.%0A++++%3Fteam+rdfs%3Alabel+%3Fname+.++%0A++++%3FteamParticipation+sport%3AparticipationBy+%3Fteam+.%0A++++%3FteamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FteamParticipation+spstat%3Ascore+%3Fscore+.%0A%7D)
1. Who were the substitutes and positions played? (baseball, soccer, American football)
1. Who was penalized?
1. What are the stats for each team? IN PROGRESS [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+spstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspstat%2F%3E%0Aprefix+spsocstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspsocstat%2F%3E%0A%0A%23+Use+case%3A+Event+%2F+Team+%2F+5.+What+were+the+stats+for+each+team%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+%3FteamName+%3Fstat+%3FstatValue%0AWHERE+%7B+%0A++++%3Fteam+rdf%3Atype+sport%3ATeam+.+%0A++++%3Fteam+rdfs%3Alabel+%3FteamName+.+%0A++++%3FteamParticipcation+sport%3AparticipationBy+%3Fteam+.%0A++++%3FteamParticipcation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FteamParticipcation+%3Fstat+%3FstatValue+.%0A++++FILTER+(strStarts(str(%3Fstat)%2C+%22http%3A%2F%2Fcv.iptc.org%2Fnewscodes%2F%22))+.%0A%7D)

### League
1. What are the current scores? (Scoreboard) DONE [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+spstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspstat%2F%3E%0Aprefix+xsd%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0A%0A%23+Use+case%3A+Event+%2F+League+%2F+1.+What+are+the+current+scores%3F+(Scoreboard)%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0A+%0ASELECT+(CONCAT(STR(YEAR(%3Fdate))%2C%22-%22%2CSTR(MONTH(%3Fdate))%2C%22-%22%2CSTR(DAY(%3Fdate)))+as+%3FdisplayDate)%0A+++++++(CONCAT(STR(HOURS(%3Fdate))%2C%22%3A%22%2CSTR(MINUTES(%3Fdate)))+as+%3FdisplayTime)%0A+++++++(CONCAT(%3FhomeTeamName%2C%22+v+%22%2C%3FawayTeamName)+as+%3Fmatch)%0A+++++++%3FhomeTeamScore+%3FawayTeamScore%0AWHERE%0A%7B%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+.%0A++++%3Fevent+sport%3AstartDate+%3Fdate+.%0A++++%3Fevent+sport%3Aparticipation+%3FhomeTeamParticipation+.%0A++++%3FhomeTeamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FhomeTeamParticipation+sport%3AparticipationBy+%3FhomeTeam+.%0A++++%3FhomeTeamParticipation+sport%3Aalignment+%22home%22+.%0A++++%3FhomeTeamParticipation+spstat%3Ascore+%3FhomeTeamScore+.%0A++++%3FhomeTeam+rdf%3Atype+sport%3ATeam+.%0A++++%3FhomeTeam+rdfs%3Alabel+%3FhomeTeamName+.%0A++++%3Fevent+sport%3Aparticipation+%3FawayTeamParticipation+.%0A++++%3FawayTeamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FawayTeamParticipation+sport%3AparticipationBy+%3FawayTeam+.%0A++++%3FawayTeamParticipation+sport%3Aalignment+%22away%22+.%0A++++%3FawayTeamParticipation+spstat%3Ascore+%3FawayTeamScore+.%0A++++%3FawayTeam+rdf%3Atype+sport%3ATeam+.%0A++++%3FawayTeam+rdfs%3Alabel+%3FawayTeamName+.%0A++++%3Fevent+sport%3Asite+%3Fsite+.%0A++++%3Fsite+rdf%3Atype+sport%3ASite+.%0A++++%3Fsite+rdfs%3Alabel+%3FsiteName+.%0A++++FILTER+(+%3Fdate+%3E+%222021-02-15T00%3A00%3A00Z%22%5E%5Exsd%3AdateTime+)%0A++++FILTER+(+%3Fdate+%3C+%222021-02-16T00%3A00%3A00Z%22%5E%5Exsd%3AdateTime+)%0A%7D%0A)
1. What is the current status of an event (pre-, mid-, post-, postponed, suspended, canceled, etc.) DONE [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+spstat%3A+%3Chttp%3A%2F%2Fcv.iptc.org%2Fnewscodes%2Fspstat%2F%3E%0Aprefix+xsd%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0A%0A%23+Use+case%3A+Event+%2F+League+%2F+2.+What+is+the+current+status+of+an+event+(pre-%2C+mid-%2C+post-%2C+postponed%2C+suspended%2C+canceled%2C+etc.)%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+(CONCAT(STR(YEAR(%3Fdate))%2C%22-%22%2CSTR(MONTH(%3Fdate))%2C%22-%22%2CSTR(DAY(%3Fdate)))+as+%3FdisplayDate)%0A+++++++(CONCAT(STR(HOURS(%3Fdate))%2C%22%3A%22%2CSTR(MINUTES(%3Fdate)))+as+%3FdisplayTime)%0A+++++++(CONCAT(%3FhomeTeamName%2C%22+v+%22%2C%3FawayTeamName)+as+%3Fmatch)%0A+++++++%3Fstatus%0AWHERE%0A%7B%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+.%0A++++%3Fevent+sport%3AstartDate+%3Fdate+.%0A++++%3Fevent+sport%3Aparticipation+%3FhomeTeamParticipation+.%0A++++%3FhomeTeamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FhomeTeamParticipation+sport%3AparticipationBy+%3FhomeTeam+.%0A++++%3FhomeTeamParticipation+sport%3Aalignment+%22home%22+.%0A++++%3FhomeTeamParticipation+spstat%3Ascore+%3FhomeTeamScore+.%0A++++%3FhomeTeam+rdf%3Atype+sport%3ATeam+.%0A++++%3FhomeTeam+rdfs%3Alabel+%3FhomeTeamName+.%0A++++%3Fevent+sport%3Aparticipation+%3FawayTeamParticipation+.%0A++++%3FawayTeamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FawayTeamParticipation+sport%3AparticipationBy+%3FawayTeam+.%0A++++%3FawayTeamParticipation+sport%3Aalignment+%22away%22+.%0A++++%3FawayTeamParticipation+spstat%3Ascore+%3FawayTeamScore+.%0A++++%3FawayTeam+rdf%3Atype+sport%3ATeam+.%0A++++%3FawayTeam+rdfs%3Alabel+%3FawayTeamName+.%0A++++%3Fevent+sport%3AeventStatus+%3Fstatus+.%0A++++FILTER+(+%3Fdate+%3E+%222021-04-25T00%3A00%3A00Z%22%5E%5Exsd%3AdateTime+)%0A++++FILTER+(+%3Fdate+%3C+%222021-04-26T00%3A00%3A00Z%22%5E%5Exsd%3AdateTime+)%0A%7D%0AORDER+BY+%3FdisplayDate+%3FdisplayTime%0A)
1. What was the result the last time these two teams met? Across all competitions this season - MORE DATA NEEDED
1. Where are today's matches being played? DONE [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0Aprefix+xsd%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2001%2FXMLSchema%23%3E%0A%0A%23+Use+case%3A+Event+%2F+League+%2F+4.+Where+are+today's+matches+being+played%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+(CONCAT(STR(YEAR(%3Fdate))%2C%22-%22%2CSTR(MONTH(%3Fdate))%2C%22-%22%2CSTR(DAY(%3Fdate)))+as+%3FdisplayDate)%0A+++++++(CONCAT(STR(HOURS(%3Fdate))%2C%22%3A%22%2CSTR(MINUTES(%3Fdate)))+as+%3FdisplayTime)+%0A+++++++(CONCAT(%3FhomeTeamName%2C%22+v+%22%2C%3FawayTeamName)+as+%3Fmatch)+%0A+++++++%3FsiteName%0AWHERE++%0A%7B%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+.%0A++++%3Fevent+sport%3AstartDate+%3Fdate+.%0A++++%3Fevent+sport%3Aparticipation+%3FhomeTeamParticipation+.%0A++++%3FhomeTeamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FhomeTeamParticipation+sport%3AparticipationBy+%3FhomeTeam+.%0A++++%3FhomeTeamParticipation+sport%3Aalignment+%22home%22+.%0A++++%3FhomeTeam+rdf%3Atype+sport%3ATeam+.%0A++++%3FhomeTeam+rdfs%3Alabel+%3FhomeTeamName+.%0A++++%3Fevent+sport%3Aparticipation+%3FawayTeamParticipation+.%0A++++%3FawayTeamParticipation+rdf%3Atype+sport%3ATeamParticipation+.%0A++++%3FawayTeamParticipation+sport%3AparticipationBy+%3FawayTeam+.%0A++++%3FawayTeamParticipation+sport%3Aalignment+%22away%22+.%0A++++%3FawayTeam+rdf%3Atype+sport%3ATeam+.%0A++++%3FawayTeam+rdfs%3Alabel+%3FawayTeamName+.%0A++++%3Fevent+sport%3Asite+%3Fsite+.%0A++++%3Fsite+rdf%3Atype+sport%3ASite+.%0A++++%3Fsite+rdfs%3Alabel+%3FsiteName+.%0A++++FILTER+(+%3Fdate+%3E+%222014-10-04T00%3A00%3A00Z%22%5E%5Exsd%3AdateTime+)%0A++++FILTER+(+%3Fdate+%3C+%222014-10-05T00%3A00%3A00Z%22%5E%5Exsd%3AdateTime+)%0A%7D%0AORDER+BY+%3Fweek+%3FdisplayDate+%3FdisplayTime)
1. What time does the game begin? DONE [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0A%0A%23+Use+case%3A+Event+%2F+League+%2F+5.+What+time+does+the+game+begin%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+(CONCAT(STR(HOURS(%3Fdate))%2C%22%3A%22%2CSTR(MINUTES(%3Fdate)))+as+%3FdisplayTime)%0AWHERE%0A%7B%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+.%0A++++%3Fevent+sport%3AstartDate+%3Fdate+.%0A++++FILTER+(+%3Fevent+%3D+%3Chttp%3A%2F%2Fexample.com%2FEvent%2FE755363%3E+)%0A%7D%0A)
1. Who are the referees? DONE [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+rdfs%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2000%2F01%2Frdf-schema%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0A%0A%23+Use+case%3A+Event+%2F+League+%2F+6.+Who+are+the+referees%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+%3FofficialName+%3FofficialPosition%0AWHERE%0A%7B%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+.%0A++++%3Fevent+sport%3Aparticipation+%3FofficialParticipation+.%0A++++%3FofficialParticipation+rdf%3Atype+sport%3AOfficialParticipation+.%0A++++%3FofficialParticipation+sport%3AparticipationBy+%3Fofficial+.%0A++++%3FofficialParticipation+sport%3ApositionEvent+%3FofficialPosition+.%0A++++%3Fofficial+rdf%3Atype+sport%3AOfficial+.%0A++++%3Fofficial+rdfs%3Alabel+%3FofficialName+.%0A++++FILTER+(+%3Fevent+%3D+%3Chttp%3A%2F%2Fexample.com%2FEvent%2FE755363%3E+)%0A%7D%0A)
1. What was the attendance for this match? DONE [link to live query](http://sport.iptc.org/dataset.html?tab=query&ds=/sport#query=prefix+rdf%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F1999%2F02%2F22-rdf-syntax-ns%23%3E%0Aprefix+sport%3A+%3Chttp%3A%2F%2Fwww.iptc.org%2Fontologies%2FSport%2F%3E%0A%0A%23+Use+case%3A+Event+%2F+League+%2F+7.+What+was+the+attendance+for+this+match%3F%0A%23+https%3A%2F%2Fgithub.com%2Fiptc%2Fsport-model%2Fwiki%2FUse-Cases%0ASELECT+%3Fattendance%0AWHERE%0A%7B%0A++++%3Fevent+rdf%3Atype+sport%3AEvent+.%0A++++%3Fevent+sport%3AstartDate+%3Fdate+.%0A++++%3Fevent+sport%3Aattendance+%3Fattendance+.%0A++++FILTER+(+%3Fevent+%3D+%3Chttp%3A%2F%2Fexample.com%2FEvent%2FE755363%3E+)%0A%7D%0A)

## Other
1. Show linking from event action to description, article, photo and video.

## Corrections
1. How does the model cope, if the data supplier makes a mistake and sends through a correction several minutes after the original data was published? +
This happens frequently - either a goalscorer was named incorrectly in football or the wrong person was named as a substitute etc
1. Eg Harry Kane was named as the goalscorer in the 85th minute of a Spurs v West Ham EPL match +
After a VAR review in the 87th minute, a correction is sent through from Opta saying it has been designated an own goal.
1. As a Football Editor, I need the data model to cope with multiple corrections to data sent to us from external suppliers, 
during the course of a match and post match. + 
So I can ensure we are showing the correct information to users
1. Real world example - December 2020
PSG v Istanbul Basaksehir Champions league match was abandoned 14 mins into the match and then rescheduled for the next day: 
https://www.bbc.co.uk/sport/football/55242656
https://www.bbc.co.uk/sport/football/55219529
The incident happened just 14 minutes into the Group H tie, which was still goalless. The match recommenced from the 14th minute the following day's kick-off at 17:55 GMT. Opta reused the same match ID (g2170557) over both days with different kick off times, the status moved from mid-event through abandoned then pre-event when rescheduled. 

## Edge Cases
1. Disciplinary action before event started. Real world example - 2017-11-02 Vitória Guimarães v Marseille in Europa League. Evra, starting on the bench for Marseille, received red card ejection before the soccer match started.
1. Score recorded after the event concluded. Real world example - 2020-10-26 Brighton and Hove Albion v Manchester United, English Premier League. Bruno Fernandes scored a penalty that was awarded (by the video assistant referee) after the final whistle.

## eSports (aka "Competitive Gaming")

TBC

## Positions

1. Where is player X at time Y during Event E?
2. Where is the hockey puck at time Y during Event E?

## Objects

1. What horse was jockey X riding at Event E?