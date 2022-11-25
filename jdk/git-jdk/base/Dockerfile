ARG BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL Author="OPCAL"

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl less ssh zlib1g git bc xmlstarlet ; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]