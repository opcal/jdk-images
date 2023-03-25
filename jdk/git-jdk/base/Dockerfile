ARG BASE_IMAGE

FROM ${BASE_IMAGE} as builder

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl

RUN curl -sL https://raw.githubusercontent.com/gissily/properties-tools/main/install.sh | sudo bash


FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="opcal@outlook.com"

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl less ssh zlib1g git bc xmlstarlet ; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/props /usr/local/bin/props

CMD [ "/bin/bash" ]