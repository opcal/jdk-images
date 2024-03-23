ARG BASE_IMAGE

FROM ${BASE_IMAGE} AS builder

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl

RUN curl -sL https://raw.githubusercontent.com/gissily/properties-tools/main/install.sh | bash; \
      curl -sL https://raw.githubusercontent.com/gissily/versions-tools/main/install.sh | bash;


FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="opcal@outlook.com"

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl less openssh-client zlib1g git bc xmlstarlet netcat ; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/ /usr/local/bin/

CMD [ "/bin/bash" ]
