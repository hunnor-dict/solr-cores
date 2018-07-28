Configuration for the Solr cores of the dictionary.

# Usage

Run the Solr server with docker:

`docker run --name solr-cores --publish 8983:8983 hunnordict/solr-cores`

Data can be loaded either directly by sending documents to Solr, or with the Solr `DataImportHandler` that is configured for each core.

To use data import, the XML dump files of the dictionary have to be made available to Solr. The files Solr looks for are defined by the following environment variables:

- `hunnor.dump.dir.hu`: the directory of the Hungarian export, default `/hunnor`
- `hunnor.dump.file.hu`: the file of the Hungarian export, default `hunnor-hu.xml`
- `hunnor.dump.dir.nb`: the directory of the Norwegian export, default `/hunnor`
- `hunnor.dump.file.nb`: the file of the Norwegian export, default `hunnor-nb.xml`

Follow the instructions in the [`export-ant`](https://github.com/hunnor-dict/export-ant) repository do download the XML dump files.

Start Solr with the files made available to the container, e.g. with volumes, and their locations properly configured. The following environment variables define the file locations:

- `HUNNOR_DUMP_FILE_HU`: sets `hunnor.dump.dir.hu` and `hunnor.dump.file.hu`
- `HUNNOR_DUMP_FILE_NB`: sets `hunnor.dump.dir.nb` and `hunnor.dump.file.nb`

For example, if the files are `$HOME/hunnor/data/HunNor-XML-HN.xml` and `$HOME/hunnor/data/HunNor-XML-NH.xml`, use:

`docker run --env HUNNOR_DUMP_FILE_HU=HunNor-XML-HN.xml --env HUNNOR_DUMP_FILE_NB=HunNor-XML-NH.xml --name solr-cores --publish 8983:8983 --volume $HOME/hunnor/data:/hunnor hunnordict/solr-cores`

When the container is running, go to http://localhost:8983 and use data import from the menu of each core.

# Tests

XSPec tests for indexing both cores are included in the `test` directory.
