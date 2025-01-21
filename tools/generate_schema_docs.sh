#!/bin/sh

echo "Generating schema docs for iptc-sport-ontology.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Main ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/main" --jekyllnavorder 1 ontologies/iptc-sport-ontology.ttl docs/ontologies/iptc-sport-ontology.html
echo "Generating schema docs for corestatistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Core Statistics" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/corestatistics" --jekyllnavorder 2 ontologies/iptc-sport-core-statistics.ttl docs/ontologies/corestatistics.html
echo "Generating schema docs for american-football-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "American Football ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/american-football" --jekyllnavorder 3 ontologies/iptc-sport-american-football-statistics.ttl docs/ontologies/american-football-statistics.html
echo "Generating schema docs for baseballstatistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Baseball ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/baseball" --jekyllnavorder 4 ontologies/iptc-sport-baseball-statistics.ttl docs/ontologies/baseball-statistics.html
echo "Generating schema docs for basketball-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Basketball ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/basketball" --jekyllnavorder 5 ontologies/iptc-sport-basketball-statistics.ttl docs/ontologies/basketball-statistics.html
echo "Generating schema docs for esports-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "esports ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/esports" --jekyllnavorder 6 ontologies/iptc-sport-esports-statistics.ttl docs/ontologies/esports-statistics.html
echo "Generating schema docs for golf.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Golf ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/golf" --jekyllnavorder 7 ontologies/iptc-sport-golf.ttl docs/ontologies/golf.html
echo "Generating schema docs for motor-racing-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Motor Racing ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/motor-racing" --jekyllnavorder 9 ontologies/iptc-sport-motor-racing-statistics.ttl docs/ontologies/motor-racing-statistics.html
echo "Generating schema docs for rugby-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Rugby ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/rugby" --jekyllnavorder 10 ontologies/iptc-sport-rugby-statistics.ttl docs/ontologies/rugby-statistics.html
echo "Generating schema docs for soccer-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Soccer ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/soccer" --jekyllnavorder 11 ontologies/iptc-sport-soccer-statistics.ttl docs/ontologies/soccer-statistics.html
echo "Generating schema docs for tennis-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Tennis ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/tennis" --jekyllnavorder 12 ontologies/iptc-sport-tennis-statistics.ttl docs/ontologies/tennis-statistics.html
echo "Generating schema docs for volleyball-statistics.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "Volleyball ontology" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/volleyball" --jekyllnavorder 13 ontologies/iptc-sport-volleyball-statistics.ttl docs/ontologies/volleyball-statistics.html
echo "Generating schema docs for iptc-sport-merged-ontology.ttl"
tools/generate_schema_docs.py --include-inherited --include-inverse --jekyll --jekyllnavname "All ontologies" --jekyllnavparent "Ontology reference" --jekyllnavlink "/ontologies/merged" --jekyllnavorder 14 ontologies/iptc-sport-merged-ontology.ttl docs/ontologies/iptc-sport-merged-ontology.html
