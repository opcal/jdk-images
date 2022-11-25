ARG BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL Author="OPCAL"

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl less libbrotli1 libcom-err2 libcurl4 libffi7 \
        libgcrypt20 libgmp10 libgnutls30 libgpg-error0 libgssapi-krb5-2 \
        libhogweed6 libidn2-0 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 \
        libldap-2.4-2 libnettle8 libnghttp2-14 libp11-kit0 libpsl5 librtmp1 libsasl2-2 \
        libssh2-1 libssl1.1 libtasn1-6 libunistring2 procps ssh zlib1g git xmlstarlet ; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]