# check=skip=InvalidDefaultArgInFrom

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="opcal@outlook.com"

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        git \
        gnupg2 \
        gosu \
        netcat-openbsd ;\
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*

CMD ["jshell"]