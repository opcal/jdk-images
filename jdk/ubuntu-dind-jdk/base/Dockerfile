FROM ghcr.io/opcal/ubuntu:noble AS builder

LABEL org.opencontainers.image.authors="opcal@outlook.com"

ARG JDK_VERSION

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive ; \
    apt-get update; \
    apt-get install -y --no-install-recommends gzip jq tar; \
    ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    case "${ARCH}" in \
        aarch64|arm64) \
            BIN_ARCH=aarch64 ; \
            ;; \
        amd64|x86_64) \
            BIN_ARCH=x64 ; \
            ;; \
        *) \
            echo "Unsupported arch: ${ARCH}"; \
            exit 1; \
            ;; \
    esac; \
    API_URL="https://api.adoptium.net/v3/assets/latest/${JDK_VERSION}/hotspot?architecture=${BIN_ARCH}&image_type=jdk&os=linux&vendor=eclipse" ; \ 
    RESULT=$(curl -s "${API_URL}") ; \
    JAVA_VERSION=$(echo "${RESULT}" | jq '.[0].version.openjdk_version' | cut -d '"' -f 2) ; \
    CHECKSUM=$(echo "${RESULT}" | jq '.[0].binary.package.checksum' | cut -d '"' -f 2) ;\
    DOWNLOAD_LINK=$(echo "${RESULT}" | jq '.[0].binary.package.link' | cut -d '"' -f 2) ; \
    curl -Ls ${DOWNLOAD_LINK} -o /tmp/openjdk.tar.gz ; \
    echo "${CHECKSUM} */tmp/openjdk.tar.gz" | sha256sum -c - ; \
    echo "Downloaded successfully" ; \
    mkdir -p /opt/java/openjdk; \
    echo ${JAVA_VERSION} > /opt/java/JAVA_VERSION ; \
    tar --extract \
	      --file ${FILENAME} \
	      --directory /opt/java/openjdk \
	      --strip-components 1 \
	      --no-same-owner \
          ; \
    apt-get clean ; \
    apt-get -y autoclean ; \
    apt-get -y autoremove ; \
    rm -rf /var/lib/apt/lists/* ;

FROM cruizba/ubuntu-dind:noble-latest

LABEL org.opencontainers.image.authors="opcal@outlook.com"

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN set -eux; \
    DEBIAN_FRONTEND=noninteractive ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
        binutils \
        ca-certificates \
        curl \
        dnsutils \
        fontconfig \
        git \
        gnupg2 \
        gosu \
        locales \
        netcat-openbsd \
        p11-kit \
        tzdata \
    ; \
    apt-get clean ; \
    apt-get -y autoclean ; \
    apt-get -y autoremove ; \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen; \
    locale-gen en_US.UTF-8; \
    rm -rf /var/lib/apt/lists/* ; \
    mkdir -p /opt/java/openjdk

COPY --from=builder /opt/java /opt/java

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

RUN echo Verifying install ... \
    && echo javac --version && javac --version \
    && echo java --version && java --version \
    && echo Complete.

VOLUME /var/lib/docker

ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]