#!/usr/bin/env python

import argparse
import sys
from itertools import chain
from pathlib import Path
from rdflib import Graph, DCTERMS, RDF, RDFS, OWL
from jinja2 import Environment, FileSystemLoader, select_autoescape

TEMPLATES_DIR = "tools/templates"

 
class DocsGenerator:
    graph = None

    """
    Save parameters and parse the data file.
    """
    def __init__(self,
            ontology_file = None,
            include_inverse = None,
            include_inherited = None,
            generate_jekyll_header = None,
            jekyll_nav_name = None,
            jekyll_nav_parent = None,
            jekyll_nav_order = None,
            jekyll_nav_link = None):
        self.ontology_file = ontology_file
        self.include_inverse = include_inverse
        self.include_inherited = include_inherited
        self.generate_jekyll_header = generate_jekyll_header
        self.jekyll_nav_name = jekyll_nav_name
        self.jekyll_nav_parent = jekyll_nav_parent
        self.jekyll_nav_order = jekyll_nav_order
        self.jekyll_nav_link = jekyll_nav_link
        self.graph = Graph()
        self.graph.parse(self.ontology_file)

    """
    Traverse the graph of parents via subClassOf
    to obtain all properties of all parent classes.
    """
    def get_inherited_properties(self, classuri):
        g = self.graph
        parentclasses = g.triples((classuri, RDFS.subClassOf, None))
        parentclasseslist = [parentclassuri for (s, p, parentclassuri) in parentclasses]
        inherited_properties = {}
        for parentclassuri in parentclasseslist:
            parentclassname = str(g.value(parentclassuri, RDFS.label))
            inherited_properties[parentclassname] = []
            parentclassproperties = g.triples((None, RDFS.domain, parentclassuri))
            parentclasspropertieslist = [propertyuri for (propertyuri, p, o) in parentclassproperties]
            for propertyuri in parentclasspropertieslist:
                propertyname = str(g.value(propertyuri, RDFS.label))
                inherited_properties[parentclassname].append(propertyname)
            # recurse to get properties from parents of parents
            inherited_properties.update(self.get_inherited_properties(parentclassuri))
        return inherited_properties
 
    """
    Generate ontology description data set.
    """
    def get_data(self) :
        g = self.graph
        ontologydata = {}
        ontologyuri = g.value(None, RDF.type, OWL.Ontology)
        ontologydata['ontologyuri'] = ontologyuri
        ontologydata['ontologyname'] = g.value(ontologyuri, RDFS.label)
        ontologydata['createddate'] = g.value(ontologyuri, DCTERMS.created)
        ontologydata['creator'] = g.value(ontologyuri, DCTERMS.creator)
        ontologydata['license'] = g.value(ontologyuri, DCTERMS.license)
        ontologydata['rights'] = g.value(ontologyuri, DCTERMS.rights)
        ontologydata['description'] = g.value(ontologyuri, DCTERMS.description)

        ontologydata['classes'] = []

        # Set parameters based on jekyll arguments
        ontologydata['jekyll'] = self.generate_jekyll_header
        ontologydata['jekyll_nav_name'] = self.jekyll_nav_name
        ontologydata['jekyll_nav_parent'] = self.jekyll_nav_parent
        ontologydata['jekyll_nav_order'] = self.jekyll_nav_order
        ontologydata['jekyll_nav_link'] = self.jekyll_nav_link

        for classuri, p, o in g.triples((None, RDF.type, OWL.Class)):
            classdata = {}
            classname = g.value(classuri, RDFS.label)
            classdata['name'] = classname
            classdata['uri'] = classuri

            classdescription = g.value(classuri, RDFS.comment)
            classdata['description'] = classdescription

            # superclasses row
            classdata['superclasses'] = []
            classsuperclasses = g.triples((classuri, RDFS.subClassOf, None))
            superclasseslist = [superclassuri for (s, p, superclassuri) in classsuperclasses]
            if superclasseslist:
                for superclassuri in superclasseslist:
                    superclassname = g.value(superclassuri, RDFS.label)
                    classdata['superclasses'].append(superclassname)

            # subclasses row
            classdata['subclasses'] = []
            classsubclasses = g.triples((None, RDFS.subClassOf, classuri))
            subclasseslist = [subclassuri for (subclassuri, p, o) in classsubclasses]
            if subclasseslist:
                for subclassuri in subclasseslist:
                    subclassname = g.value(subclassuri, RDFS.label)
                    classdata['subclasses'].append(subclassname)

            # properties row
            classdata['properties'] = []
            classproperties = g.triples((None, RDFS.domain, classuri))
            propertieslist = [propertyuri for (propertyuri, p, o) in classproperties]
            if propertieslist:
                for propertyuri in propertieslist:
                    propertyname = g.value(propertyuri, RDFS.label)
                    classdata['properties'].append(propertyname)

            # include inherited properties
            if self.include_inherited:
                classdata['inherited_properties'] = self.get_inherited_properties(classuri)

            ontologydata['classes'].append(classdata)

        ontologydata['properties'] = []

        # Properties section
        # Note: here we mix object properties and data properties, like BBC docs do
        # TODO: make this configurable with an argument
        allproperties = chain(g.triples((None, RDF.type, OWL.ObjectProperty)), g.triples((None, RDF.type, OWL.DatatypeProperty)))
        sortedpropertyuris = sorted([propertyuri for propertyuri, p, o in allproperties], key=str)
        for propertyuri in sortedpropertyuris:
            propertydata = {}
            propertyname = g.value(propertyuri, RDFS.label)
            propertydata['name'] = propertyname
            propertydata['uri'] = propertyuri

            # description row
            propertydescription = g.value(propertyuri, RDFS.comment)
            propertydata['description'] = propertydescription

            # domain row
            propertydomain = g.triples((propertyuri, RDFS.domain, None))
            propertydomainlist = [propertydomainuri for (s, p, propertydomainuri) in propertydomain]
            if propertydomainlist:
                propertydata['domains'] = []
                for propertydomainuri in propertydomainlist:
                    propertydomainname = g.value(propertydomainuri, RDFS.label)
                    propertydata['domains'].append(propertydomainname)

            # range row
            propertyrange = g.triples((propertyuri, RDFS.range, None))
            propertyrangelist = [propertyrangeuri for (s, p, propertyrangeuri) in propertyrange]
            if propertyrangelist:
                propertydata['ranges'] = []
                for propertyrangeuri in propertyrangelist:
                    propertyrangename = g.value(propertyrangeuri, RDFS.label)
                    # if there's no label, it's an XSD core type
                    if not propertyrangename:
                        propertyrangename = str(propertyrangeuri)
                    propertydata['ranges'].append(propertyrangename)

            # inverse row
            propertyinverse = g.value(propertyuri, OWL.inverseOf)
            propertyinversename = g.value(propertyinverse, RDFS.label)
            propertydata['inverseof'] = propertyinversename

            ontologydata['properties'].append(propertydata)
        return ontologydata


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--include-inverse",
                        help="Include inverse relationships rows in property tables (default: false)",
                        action='store_true')
    parser.add_argument("--include-inherited",
                        help="Include properties defined in parent classes (default: false)",
                        action='store_true')
    parser.add_argument("--jekyll",
                        help="Include Jekyll navigation header (default: false)",
                        action='store_true')
    parser.add_argument("--jekyllnavname",
                        help="Name of this page to be used in Jekyll navigation config")
    parser.add_argument("--jekyllnavparent",
                        help="Name of parent page to use in Jekyll navigation config")
    parser.add_argument("--jekyllnavorder",
                        help="Numerical order of page to use in Jekyll navigation config")
    parser.add_argument("--jekyllnavlink",
                        help="Link to use in Jekyll navigation config")
    parser.add_argument("--template",
                        help="Jinja2 template (in templates folder) to be used to create the docs (default: bbc-style.html)",
                        default="bbc-style.html")
    parser.add_argument("ontologyfile", help="Turtle version of ontology file to be parsed")
    parser.add_argument("outfile", help="Output file")

    args = parser.parse_args()

    generator = DocsGenerator(
        ontology_file = args.ontologyfile,
        include_inverse = args.include_inverse,
        include_inherited = args.include_inherited,
        generate_jekyll_header = args.jekyll,
        jekyll_nav_name = args.jekyllnavname,
        jekyll_nav_parent = args.jekyllnavparent,
        jekyll_nav_order = args.jekyllnavorder,
        jekyll_nav_link = args.jekyllnavlink
    )

    ontologydata = generator.get_data()

    jinjaenv = Environment(
        loader=FileSystemLoader(TEMPLATES_DIR),
        autoescape=select_autoescape()
    )

    template = jinjaenv.get_template(args.template)

    outfile = open(args.outfile, "w")
    outfile.write(template.render(data=ontologydata))
    outfile.close()

# old version did multiple files, new versino does one file. Handle multiple files in a wrapper script    
#ONTOLOGIES_DIR = "ontologies"
#for ttl_file in chain(Path(ONTOLOGIES_DIR).glob("*ontology.ttl"), Path(ONTOLOGIES_DIR).glob("*statistics.ttl")):
#    html_filename = Path(ONTOLOGIES_DIR / Path(ttl_file.stem + "-test.html")).absolute()
#    print(f"(re)generating {html_filename}")

# TODO: add "inherited properties" 
# Future feature idea: one page per class/property, a la schema.org docs
