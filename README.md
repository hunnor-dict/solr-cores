# HunNor Dictionary - Solr Cores

Configuration for the Solr cores of the dictionary.

## Tests

XSPec tests for indexing both cores are included in the `test` directory.

## Usage

Copy the configuration files to the appropriate directory of a Solr instance and start the server.

The configuration of the cores refer to shared resources that are outside the directories of the cores. Such resources are the shared field type definitions and the Hungarian spelling library. To allow loading these resources, start Solr with `-Dsolr.allow.unsafe.resourceloading=true`.

After Solr is running and the cores are configured, data can be loaded either directly by sending documents to Solr, or with the Solr `DataImportHandler` that is configured for each core.

Data from the dictionary is exported 2 separate XML files. Both can be downloaded from the dictionary's Dropbox account. Links are available on [the download page](https://dict.hunnor.net/about).

The data import handler is configured for both cores to import these files. Which file Solr looks for are defined by environment variables:

- `hunnor.dump.dir`: the common base directory of the files
- `hunnor.dump.file.hu`: the file of the Hungarian export
- `hunnor.dump.file.nb`: the file of the Norwegian export

Pass these environment variables to Solr with the values that are appropriate for the location to where the files are downloaded on the server that runs Solr.

## Docker

The repository includes a `Dockerfile` for creating an image for a Solr instance with both cores configured. The image is based on the [official Solr Docker image](https://hub.docker.com/_/solr/). The official `hunnordict/solr-cores` image is built with this file.

When running the image, the location where Solr looks for the dump files by default is:

- `/tmp/hunnor.hu.xml`
- `/tmp/hunnor.nb.xml`

To configure the file locations, use the following environment variables:

- `HUNNOR_DUMP_DIR`: sets `hunnor.dump.dir`
- `HUNNOR_DUMP_FILE_HU`: sets `hunnor.dump.file.hu`
- `HUNNOR_DUMP_FILE_NB`: sets `hunnor.dump.file.nb`

Make the files available in the container at that location, e.g. with volumes. For example, If you downloaded the files `HunNor-XML-HN.xml` and `HunNor-XML-NH.xml` to `/home/hunnor`, use:

    docker run \
    -p 8983:8983 \
    -e HUNNOR_DUMP_DIR=/hunnor \
    -e HUNNOR_DUMP_FILE_HU=HunNor-XML-HN.xml \
    -e HUNNOR_DUMP_FILE_NB=HunNor-XML-NH.xml \
    -v /home/hunnor:/hunnor hunnordict/solr-cores

When the container is running, go to http://localhost:8983 and use data import from the menu of each core.
