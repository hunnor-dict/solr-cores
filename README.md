# HunNor dictionary &mdash; Solr cores

Configuration for the Solr cores of the dictionary.

The image is based on the [official Solr Docker image](https://hub.docker.com/_/solr/).

To load data into the cores, either connect from the editor and start saving entries, or use bulk import with Solr's DataImportHandler.

## Bulk import

Data from the dictionary is exported 2 separate XML files. Go to [the download page](https://dict.hunnor.net/about) for the download links.

The location where Solr looks for these files by default is

- /tmp/hunnor.hu.xml
- /tmp/hunnor.nb.xml

To configure the file locations, use the following environment variables:

- HUNNOR_DUMP_DIR: the base directory
- HUNNOR_DUMP_FILE_HU: the file name for the Hungarian export
- HUNNOR_DUMP_FILE_NB: the file name for the Norwegian export

Configure a location using these environment variables, and make the files available in the container at that location, e.g. with volumes.

### Example

If you downloaded the files HunNor-XML-HN.xml and HunNor-XML-NH.xml to /home/hunnor, use

    docker run \
    -p 8983:8983 \
    -e HUNNOR_DUMP_DIR=/hunnor \
    -e HUNNOR_DUMP_FILE_HU=HunNor-XML-HN.xml \
    -e HUNNOR_DUMP_FILE_NB=HunNor-XML-NH.xml \
    -v /home/hunnor:/hunnor hunnordict/solr-cores

When the container is running, go to http://localhost:8983 and use data import from the menu of each core.
