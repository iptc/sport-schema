'use strict';

const jsonld = require('jsonld');

const path = require("path");
const fs = require('fs');

const sampleDir = '../../samples/';

async function ntriplesToJSONLD(nquads, context, filename) {
    const toCompact = await jsonld.fromRDF(nquads,);
    let compacted = await jsonld.compact(toCompact, context, { 'processingMode': 'json-ld-1.1' });
    fs.writeFileSync(sampleDir + filename + '.jsonld', JSON.stringify(compacted, null, 2));
}

let samples = fs.readdirSync(sampleDir).filter(fn => fn.endsWith('.n3'));
samples.forEach(filename => {
    const data = fs.readFileSync(sampleDir + filename, { 'encoding':'utf8'});
    const context = {
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "sch": "https://schema.org/",
        "sport": "http://www.iptc.org/ontologies/Sport/",
        "spstat": "http://cv.iptc.org/newscodes/spstat/",
        "spsocstat": "http://cv.iptc.org/newscodes/spsocstat/"
    };

    (async function () {
        await ntriplesToJSONLD(data, context, filename.replace('.n3', ''));
    })();
});