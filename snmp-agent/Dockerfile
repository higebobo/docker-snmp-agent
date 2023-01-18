FROM ubuntu:18.04

ARG ADMIN

RUN apt-get update && apt-get install -y \
    snmp snmpd snmp-mibs-downloader --no-install-recommends ca-certificates unzip && \
    rm -rf /var/cache/apk/*

ENV ADMIN $ADMIN

COPY entrypoint.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]
