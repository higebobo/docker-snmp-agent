FROM ubuntu:18.04

ARG ADMIN

RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    snmp snmpd snmp-mibs-downloader ca-certificates unzip && \
    rm -rf /var/cache/apk/*

ENV ADMIN $ADMIN

COPY entrypoint.sh /

ENTRYPOINT ["sh", "/entrypoint.sh"]
