FROM openjdk:8u212-jdk-alpine3.9
LABEL maintainer="Anandan"
STOPSIGNAL SIGKILL
ENV MIRROR https://www-eu.apache.org/dist/jmeter/binaries
ENV JMETER_VERSION 5.4.2
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV ALPN_VERSION 8.1.13.v20181017
ENV PATH ${JMETER_BIN}:$PATH
#COPY jmeterbase/entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/entrypoint.sh \
RUN apk add --no-cache \
    curl \
    fontconfig \
    net-tools \
    shadow \
    su-exec \
    tcpdump  \
    ttf-dejavu \
 && cd /tmp/ \
 && curl --location --silent --show-error --output apache-jmeter-${JMETER_VERSION}.tgz ${MIRROR}/apache-jmeter-${JMETER_VERSION}.tgz \
 && curl --location --silent --show-error --output apache-jmeter-${JMETER_VERSION}.tgz.sha512 ${MIRROR}/apache-jmeter-${JMETER_VERSION}.tgz.sha512 \
 && sha512sum -c apache-jmeter-${JMETER_VERSION}.tgz.sha512 \
 && mkdir -p /opt/ \
 && tar x -z -f apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
 && rm -R -f apache* \
 && sed -i '/RUN_IN_DOCKER/s/^# //g' ${JMETER_BIN}/jmeter \
 && sed -i '/PrintGCDetails/s/^# /: "${/g' ${JMETER_BIN}/jmeter && sed -i '/PrintGCDetails/s/$/}"/g' ${JMETER_BIN}/jmeter \
 && chmod +x ${JMETER_HOME}/bin/*.sh \
 && curl --location --silent --show-error --output /opt/alpn-boot-${ALPN_VERSION}.jar https://repo1.maven.org/maven2/org/mortbay/jetty/alpn/alpn-boot/${ALPN_VERSION}/alpn-boot-${ALPN_VERSION}.jar \
 && rm -fr /tmp/*
 # Copy any tests to the jmeter directory
ADD jmetertests /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests
ADD data /opt/apache-jmeter-${JMETER_VERSION}/bin/jmetertests/data
# Required for HTTP2 plugins
ENV JVM_ARGS -Xms3072M -Xmx3072M -Xmn1792M -Xbootclasspath/p:/opt/alpn-boot-${ALPN_VERSION}.jar
WORKDIR /jmeter
#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#CMD ["jmeter", "--?"]

ENV JMETER_PLUGINS_MANAGER_VERSION 1.4
ENV CMDRUNNER_VERSION 2.2
ENV JSON_LIB_VERSION 2.4
ENV JSON_LIB_FULL_VERSION ${JSON_LIB_VERSION}-jdk15
ENV NUMBER_OF_FILES_UNDER_LIB 166
ENV NUMBER_OF_FILES_UNDER_LIB_EXT 81
RUN cd /tmp/ \
 && curl --location --silent --show-error --output ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar http://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar \
 && curl --location --silent --show-error --output ${JMETER_HOME}/lib/cmdrunner-${CMDRUNNER_VERSION}.jar http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar \
 && curl --location --silent --show-error --output ${JMETER_HOME}/lib/json-lib-${JSON_LIB_FULL_VERSION}.jar https://search.maven.org/remotecontent?filepath=net/sf/json-lib/json-lib/${JSON_LIB_VERSION}/json-lib-${JSON_LIB_FULL_VERSION}.jar \
 && java -cp ${JMETER_HOME}/lib/ext/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
 && PluginsManagerCMD.sh install \
    blazemeter-debugger=0.6,\
    bzm-hls=3.0.1,\
    bzm-http2=1.5,\
    bzm-jmeter-citrix-plugin=0.5.5,\
    bzm-parallel=0.9,\
    bzm-random-csv=0.6,\
    bzm-rte=2.3,\
    bzm-siebel=0.1.0-beta,\
    custom-soap=1.3.3,\   
    jmeter.backendlistener.azure=0.2.1,\
    jmeter.backendlistener.elasticsearch=2.6.10,\
    jmeter.backendlistener.kafka=1.0.0,\
    jmeter-datadog-backend-listener=0.2.0,\
    jmeter.pack-listener=1.7,\
    jmeter-pubsub-sampler=1.0,\
    jpgc-autostop=0.1,\
    jpgc-casutg=2.9,\
    jpgc-cmd=2.2,\
    jpgc-csl=0.1,\
    jpgc-csvars=0.1,\
    jpgc-dbmon=0.1,\
    jpgc-directory-listing=0.3,\
    jpgc-dummy=0.4,\
    jpgc-ffw=2.0,\
    jpgc-fifo=0.2,\
    jpgc-filterresults=2.2,\
    jpgc-functions=2.1,\
    jpgc-ggl=2.0,\
    jpgc-graphs-additional=2.0,\
    jpgc-graphs-basic=2.0,\
    jpgc-graphs-composite=2.0,\
    jpgc-graphs-dist=2.0,\
    jpgc-graphs-vs=2.0,\
    jpgc-hadoop=2.0,\
    jpgc-httpraw=0.1,\
    jpgc-jms=0.2,\
    jpgc-jmxmon=0.3,\
    jpgc-json=2.7,\
    jpgc-lockfile=0.1,\
    jpgc-mergeresults=2.1,\
    # jpgc-oauth=0.1,\
    jpgc-pde=0.1,\
    jpgc-perfmon=2.1,\
    jpgc-plancheck=2.4,\
    # jpgc-plugins-manager=${JMETER_PLUGINS_MANAGER_VERSION},\
    jpgc-plugins-manager=1.6,\
    jpgc-prmctl=0.4,\
    jpgc-redis=0.3,\
    jpgc-rotating-listener=0.2,\
    jpgc-sense=3.5,\
    jpgc-standard=2.0,\
    jpgc-sts=2.4,\
    jpgc-synthesis=2.2,\
    jpgc-tst=2.5,\
    jpgc-udp=0.4,\
    jpgc-webdriver=3.1,\
    jpgc-wsc=0.7,\
    jpgc-xml=0.1,\
    jpgc-xmpp=1.5.1,\
    kafkameter=0.2.0,\
	log4j-1.2-api=2.17.0,\
	log4j-api=2.17.0,\
	log4j-core=2.17.0,\
	log4j-slf4j-impl=2.17.0,\
    mqtt-sampler=0.0.1-SNAPSHOT,\
    netflix-cassandra=0.2-SNAPSHOT,\
    ssh-sampler=1.1.1-SNAPSHOT,\
    tilln-iso8583=1.1,\
    tilln-sshmon=1.2,\
    tilln-wssecurity=1.7,\
    websocket-sampler=1.0.2-SNAPSHOT,\
    websocket-samplers=1.2.2 \
 && jmeter --version \
 && cd /opt/apache-jmeter-${JMETER_VERSION}/lib/ \
 && rm -f /opt/apache-jmeter-${JMETER_VERSION}/lib/log4j-1.2-api-2.16.0.jar \
 && rm -f /opt/apache-jmeter-${JMETER_VERSION}/lib/log4j-api-2.16.0.jar \
 && rm -f /opt/apache-jmeter-${JMETER_VERSION}/lib/log4j-core-2.16.0.jar \
 && rm -f /opt/apache-jmeter-${JMETER_VERSION}/lib/log4j-slf4j-impl-2.16.0.jar \
 && wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.17.0/log4j-core-2.17.0.jar \
 && wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j-impl/2.17.0/log4j-slf4j-impl-2.17.0.jar \
 && wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.17.0/log4j-api-2.17.0.jar \
 && wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-1.2-api/2.17.0/log4j-1.2-api-2.17.0.jar \
 && /opt/apache-jmeter-${JMETER_VERSION}/bin/PluginsManagerCMD.sh install jpgc-casutg \
 && /opt/apache-jmeter-${JMETER_VERSION}/bin/PluginsManagerCMD.sh install jpgc-tst   \
 && cd /opt/apache-jmeter-${JMETER_VERSION}/lib/ext/ \
 && wget https://github.com/DataDog/jmeter-datadog-backend-listener/releases/download/0.2.0/jmeter-datadog-backend-listener-0.2.0.jar \
 && wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-cmn-jmeter/0.6/jmeter-plugins-cmn-jmeter-0.6.jar \
 && PluginsManagerCMD.sh status \
 && chmod +x ${JMETER_HOME}/bin/*.sh \
 && rm -fr /tmp/*
