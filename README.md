Configuration for the Solr cores of the dictionary.

# Usage

Run the Solr server with docker:

`docker run --name solr-cores --publish 8983:8983 hunnordict/solr-cores`

Data can be loaded by sending documents to Solr. For a bulk import, send the XML dump files to Solr. Follow the instructions in the [`export-ant`](https://github.com/hunnor-dict/export-ant) repository do download the XML dump files.

`curl -X POST http://localhost:8983/solr/hunnor.hu/update --data-binary @/path/to/HunNor-XML-HN.xml --header "Content-Type: text/xml"`

`curl -X POST http://localhost:8983/solr/hunnor.nb/update --data-binary @/path/to/HunNor-XML-NH.xml --header "Content-Type: text/xml"`

XSLT files are configured for each core to transform the HunNor XML data to Solr documents. See `xslt/import.xsl` in the core configuration directories.

The XSLT files leave Solr messages unchanged:

`curl -X POST http://localhost:8983/solr/hunnor.nb/update --data "<delete><query>*:*</query></delete>" --header "Content-Type: text/xml"`

`curl -X POST http://localhost:8983/solr/hunnor.nb/update --data "<commit/>" --header "Content-Type: text/xml"`

# Tests

XSPec tests for indexing both cores are included in the `test` directory.
