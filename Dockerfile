FROM solr:6.5.0

RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dsolr.allow.unsafe.resourceloading=true\"" >> bin/solr.in.sh

RUN rm -r /opt/solr/server/solr/*

COPY field-types.xml server/solr
COPY hunnor.hu server/solr/hunnor.hu
COPY hunnor.nb server/solr/hunnor.nb
COPY lib server/solr/lib
COPY solr.xml server/solr

USER root

RUN chown -R $SOLR_USER:$SOLR_USER server/solr

USER $SOLR_USER
