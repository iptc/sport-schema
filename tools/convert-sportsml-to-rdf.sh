#!/bin/bash

echo -n "Creating N3 files from SportsML using XSLT processor..."
tools/process-sportsml.sh samples/xml/sportsml/soccer-match-g2-generic.xml >samples/n3/soccer-match-01.n3
tools/process-sportsml.sh samples/xml/sportsml/2128610-post-event.xml >samples/n3/soccer-match-02.n3
tools/process-sportsml.sh samples/xml/sportsml/2128607-post-event.xml >samples/n3/soccer-match-03.n3
tools/process-sportsml.sh samples/xml/sportsml/2128609-post-event.xml >samples/n3/soccer-match-04.n3
tools/process-sportsml.sh samples/xml/sportsml/2128611-post-event.xml >samples/n3/soccer-match-05.n3
tools/process-sportsml.sh samples/xml/sportsml/schedule-epl-3.xml >samples/n3/league-schedule.n3
tools/process-sportsml.sh samples/xml/sportsml/standings-epl-3.xml >samples/n3/soccer-standings.n3
tools/process-sportsml.sh samples/xml/sportsml/horse-meet-3.xml >samples/n3/horse-meet.n3
tools/process-sportsml.sh samples/xml/sportsml/roster-g2.xml >samples/n3/team-roster.n3
echo " done."

echo -n "Creating Turtle files from N3 using Jena's command-line tool riot..."
# Note that "riot" needs to be findable on on $PATH
# we use the file "tools/prefixes.ttl" to add the prefix section at the beginning of the file
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-01.n3 >samples/ttl/soccer-match-01.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-02.n3 >samples/ttl/soccer-match-02.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-03.n3 >samples/ttl/soccer-match-03.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-04.n3 >samples/ttl/soccer-match-04.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-05.n3 >samples/ttl/soccer-match-05.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/league-schedule.n3 >samples/ttl/league-schedule.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-standings.n3 >samples/ttl/soccer-standings.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/horse-meet.n3 >samples/ttl/horse-meet.ttl
riot -q --formatted=TURTLE tools/prefixes.ttl samples/n3/team-roster.n3 >samples/ttl/team-roster.ttl
echo " done."

echo -n "Creating JSON-LD files from Turtle using Jena riot..."
# Note that the @context sections are added to the bottom of these files, not the top!
riot --formatted=JSONLD samples/ttl/soccer-match-01.ttl >samples/json-ld/soccer-match-01.jsonld
riot --formatted=JSONLD samples/ttl/soccer-match-02.ttl >samples/json-ld/soccer-match-02.jsonld
riot --formatted=JSONLD samples/ttl/soccer-match-03.ttl >samples/json-ld/soccer-match-03.jsonld
riot --formatted=JSONLD samples/ttl/soccer-match-04.ttl >samples/json-ld/soccer-match-04.jsonld
riot --formatted=JSONLD samples/ttl/soccer-match-05.ttl >samples/json-ld/soccer-match-05.jsonld
riot --formatted=JSONLD samples/ttl/league-schedule.ttl >samples/json-ld/league-schedule.jsonld
riot --formatted=JSONLD samples/ttl/soccer-standings.ttl >samples/json-ld/soccer-standings.jsonld
riot --formatted=JSONLD samples/ttl/horse-meet.ttl >samples/json-ld/horse-meet.jsonld
riot --formatted=JSONLD samples/ttl/team-roster.ttl >samples/json-ld/team-roster.jsonld
echo " done."

