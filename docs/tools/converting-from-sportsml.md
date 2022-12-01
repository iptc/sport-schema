---
permalink: /tools/converting-from-sportsml/
title: Converting from SportsML
layout: page
nav_order: 5
parent: Working with IPTC Sport Schema
---

# Converting from SportsML to IPTC Sport Schema

IPTC created the first version of SportsML back in the 2000s, when XML was the main
format used for information markup. Many news and sports data providers have adopted
SportsML so we want to make it easy for SportsML users to convert their data files
to IPTC Sports Schema if they choose to do so.

We have created an XSLT stylesheet that converts many of the standard SportsML
patterns to the equivalent in Sports Schema: in particular tournament structures,
team rosters, event schedules, results, statistics and actions (play-by-play
information that can be used to track goals or even individual player movements
across a pitch or field).

We have used the XSLT stylesheet to generate all the example triples that we use
to test our use cases.

The XSLT is available at [the IPTC Sport Schema GitHub repository](https://github.com/iptc/sport-schema/blob/main/tools/sportsML-to-n3.xsl).
It is licensed under a CC-BY 4.0 licence, as are all IPTC materials.
