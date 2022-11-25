
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

LABEL Author="OPCAL"

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gosu \
        netcat \
        dnsutils \
        bc \
        curl; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*

CMD ["jshell"]