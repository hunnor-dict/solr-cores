FROM solr:6.6.0

RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dsolr.allow.unsafe.resourceloading=true\"" >> bin/solr.in.sh

ENV HUNNOR_DUMP_DIR /tmp
ENV HUNNOR_DUMP_FILE_HU hunnor.hu.xml
ENV HUNNOR_DUMP_FILE_NB hunnor.nb.xml

RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dhunnor.dump.dir=\$HUNNOR_DUMP_DIR\"" >> bin/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dhunnor.dump.file.hu=\$HUNNOR_DUMP_FILE_HU\"" >> bin/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dhunnor.dump.file.nb=\$HUNNOR_DUMP_FILE_NB\"" >> bin/solr.in.sh

RUN rm -r /opt/solr/server/solr/*

COPY field-types.xml server/solr
COPY hunnor.hu server/solr/hunnor.hu
COPY hunnor.nb server/solr/hunnor.nb
COPY lib server/solr/lib
COPY solr.xml server/solr

USER root

RUN chown -R $SOLR_USER:$SOLR_USER server/solr

RUN mkdir /var/solr
RUN chown -R $SOLR_USER:$SOLR_USER /var/solr

USER $SOLR_USER
