FROM maven:3.6-jdk-13 as maven

COPY tester /opt/hunnor-dict/solr-cores/tester
COPY hunnor.hu /opt/hunnor-dict/solr-cores/hunnor.hu
COPY hunnor.nb /opt/hunnor-dict/solr-cores/hunnor.nb

WORKDIR /opt/hunnor-dict/solr-cores/tester
RUN mvn verify





FROM solr:8.4.0

USER root

RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dsolr.allow.unsafe.resourceloading=true\"" >> /etc/default/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dlucene.match.version=8.4.0\"" >> /etc/default/solr.in.sh

ENV HUNNOR_DUMP_FILE_HU /hunnor/hunnor-hu.xml
ENV HUNNOR_DUMP_FILE_NB /hunnor/hunnor-nb.xml

RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dhunnor.dump.file.hu=\$HUNNOR_DUMP_FILE_HU\"" >> /etc/default/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dhunnor.dump.file.nb=\$HUNNOR_DUMP_FILE_NB\"" >> /etc/default/solr.in.sh

RUN echo "SOLR_HEAP=1024m" >> /etc/default/solr.in.sh

RUN rm -r server/solr/*

RUN mkdir -p /opt/hunnor-dict/solr-cores
COPY solr.xml /opt/hunnor-dict/solr-cores
COPY field-types.xml /opt/hunnor-dict/solr-cores
COPY hunnor.hu /opt/hunnor-dict/solr-cores/hunnor.hu
COPY hunnor.nb /opt/hunnor-dict/solr-cores/hunnor.nb
COPY lib /opt/hunnor-dict/solr-cores/lib

ENV SOLR_HOME /opt/hunnor-dict/solr-cores

RUN mkdir -p /var/opt/solr/data
RUN chown -R $SOLR_USER:$SOLR_USER /var/opt/solr/data

RUN chown -R $SOLR_USER:$SOLR_USER /opt/hunnor-dict/solr-cores

USER $SOLR_USER
