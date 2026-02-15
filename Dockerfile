FROM maven:3.6-jdk-11 AS maven

COPY tester /opt/hunnor-dict/solr-cores/tester
COPY hunnor.hu /opt/hunnor-dict/solr-cores/hunnor.hu
COPY hunnor.nb /opt/hunnor-dict/solr-cores/hunnor.nb

WORKDIR /opt/hunnor-dict/solr-cores/tester
RUN mvn verify





FROM solr:9.10.1

USER root

RUN printf "\n" >> /etc/default/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dsolr.allow.unsafe.resourceloading=true\"" >> /etc/default/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dsolr.config.lib.enabled=true\"" >> /etc/default/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dlucene.match.version=9.10.1\"" >> /etc/default/solr.in.sh
RUN echo "SOLR_OPTS=\"\$SOLR_OPTS -Dsolr.allowPaths=/var/opt/solr/data\"" >> /etc/default/solr.in.sh
RUN echo "SOLR_HEAP=2048m" >> /etc/default/solr.in.sh

RUN rm -r server/solr/*

RUN mkdir -p /opt/hunnor-dict/solr-cores
COPY solr.xml /opt/hunnor-dict/solr-cores
COPY field-types.xml /opt/hunnor-dict/solr-cores
COPY hunnor.hu /opt/hunnor-dict/solr-cores/hunnor.hu
COPY hunnor.nb /opt/hunnor-dict/solr-cores/hunnor.nb
COPY lib /opt/hunnor-dict/solr-cores/lib

ENV SOLR_HOME=/opt/hunnor-dict/solr-cores

RUN mkdir -p /var/opt/solr/data
RUN chown -R $SOLR_USER:$SOLR_USER /var/opt/solr/data

RUN chown -R $SOLR_USER:$SOLR_USER /opt/hunnor-dict/solr-cores

USER $SOLR_USER
