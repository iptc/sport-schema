#!/usr/bin/env python

import sys
from itertools import chain
from pathlib import Path
from pylode import OntDoc

ONTOLOGIES_DIR = "ontologies"

for ttl_file in chain(Path(ONTOLOGIES_DIR).glob("*ontology.ttl"), Path(ONTOLOGIES_DIR).glob("*statistics.ttl")):
    html_filename = Path(ONTOLOGIES_DIR / Path(ttl_file.stem + ".html")).absolute()
    print(f"(re)generating {html_filename}")
    od = OntDoc(ontology=ttl_file)
    od.make_html(destination=html_filename, include_css=False)
