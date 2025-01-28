# IPTC Sport Schema

The next generation of sports data, based on IPTC's SportsML and semantic web
principles.

## About the IPTC Sport Schema

The IPTC is proud to present the result of years of work: an RDF-based data model
covering sports schedules, event results and statistics.

Our development process is based on a set of use cases documented
at https://github.com/iptc/sport-model/wiki/Use-Cases .

We have created an RDFS/OWL ontology that represents schedules, statistics and results
for all levels of all sports, for both human and machine consumption.

## Project goals and principles

We want the resulting data model and vocabulary to be:

* **Comprehensive** - it should be able to handle schedules, results and
statistics for many types of sports: team, individual and head-to-head.
* **Easy to use** - should be approachable by non-experts in Semantic Web
technologies. For example, the JSON-LD versions should be simple enough that
they can  be parsed by any competent developer who is comfortable with handling
JSON files.
* **Easy to query** - for those who want to use the power of RDF features such
as SPARQL, querying data should be as simple as possible.
* **Compatible with schema.org** - we want the IPTC Sport Schema to be
self-contained, but it should be possible to use it alongside schema.org in the
future.

## Latest version: Sport Schema 1.1

Released in October 2024, Sport Schema 1.1 contains the following changes:
* Adds Club and TeamMembership types (so a Team can be a member of a Club). This can also be used to express a Team's membership of a Competition, e.g. Arsenal FC's membership of the UK Premier League.
* Add facets support (based on SportsML / NewsCodes facets) so we can now say
that an event is "women's 400 metres relay swimming", not just "swimming"
* Added the ability to link from Athlete to Team via a new teamParticipation
property
* Add an AssociateMembership type so an Associate (such as a coach) can have a
tenure relating to any Agent, including an Athlete or a Team. Previously
Associates were linked to Teams via Participation objects which wasn't
satisfactory.
* Many cleanups to the SHACL Shapes used for validation of data.

## Repository layout

`docs`:

HTML documentation published to sportschema.org using GitHub Pages. Includes
ontology documentation under docs/ontologies/.

The docs use the Jekyll documentation generation system. To run a local server,
run `bundle exec jekyll serve`

`queries`:

Sample SPARQL queries exercising some of the use cases.

`queries/output`:

Expected output from each of the sample SPARQL queries.

`samples/{n3|ttl|jsonld}/`:

Example data files in RDF N3, Turtle (`.ttl`) and JSON-LD formats.

`samples/xml/sportsml`:

Examples in SportsML, to be converted to N3 using the
`convert-sportsml-to-rdf.sh` script in the `tools` folder.

`tools`:

We have created a Bash script which uses the Saxon XSLT processor to convert
SportsML example files in XML to N3 triples and then uses Apache Jena to convert
the N3 to the more readable Turtle (TTL) and JSON-LD formats.

This repository contains the converted files, but if you need to convert them
again, simply run:

```bash
tools/convert-examples-to-rdf.sh
```

If you want to try converting an individual N3 file yourself, you can use Jena's
`riot` tool directly:

```bash
riot --formatted=TURTLE tools/prefixes.ttl samples/n3/soccer-match-01.n3
riot --formatted=JSON-LD samples/ttl/soccer-match-01.ttl
```

Note that the JSON-LD files include the `@context` section at the bottom of the
file, whereas most JSON-LD examples include `@context` at the top. This is an
artefact of the Jena JSON-LD generator and doesn't affect the usefulness of the
data files.

To run the test queries and compare them against the expected output, run

```bash
tools/run-test-queries.sh
```

This will run each of the example SPARQL queries in the `queries` folder against
all the data files in the `samples/ttl` folder. It compares the output of the
SPARQL queries against the corresponding file in the `queries/output` folder.
If there are any discrepancies, they will be displayed inline.

We have also created a test that runs using a local instance of the Fuseki
server, comparing the results against the `queries/fuseki-output` folder.

```bash
tools/run-test-queries-fuseki.sh
```

## More detailed documentation

More documentation is available at https://www.sportschema.org/

To see a local version of the sportschema.org site, do the following:

    cd docs         # go to documentation folder
    bundle install  # install Jekyll for GitHub Pages locally
    bundle exec jekyll serve --baseurl=""  # run local Jekyll server

then the site appears as http://localhost:4000/
