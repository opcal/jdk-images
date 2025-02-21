FROM ghcr.io/opcal/ubuntu:noble AS builder

LABEL org.opencontainers.image.authors="opcal@outlook.com"

ARG FEATURE_VERSION

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
    LATEST=$(curl "https://api.adoptium.net/v3/info/release_versions?architecture=${BIN_ARCH}&heap_size=normal&image_type=jdk&jvm_impl=hotspot&lts=true&os=linux&page=0&page_size=1&project=jdk&release_type=ga&semver=false&sort_method=DEFAULT&sort_order=DESC&vendor=eclipse&version=%5B${FEATURE_VERSION}%2C$((${FEATURE_VERSION} + 1))%29" | jq '.versions[0].openjdk_version' | cut -d '"' -f 2) ; \
    API_URL=https://api.adoptium.net/v3/binary/latest/${FEATURE_VERSION}/ga/linux/${BIN_ARCH}/jdk/hotspot/normal/eclipse ; \
    FETCH_URL=$(curl -s -w %{redirect_url} "${API_URL}") ; \
    FILENAME=$(curl -OLs -w %{filename_effective} "${FETCH_URL}") ; \
    curl -Ls "${FETCH_URL}.sha256.txt" | sha256sum -c - ; \
    echo "Downloaded successfully as ${FILENAME}" ; \
    mkdir -p /opt/java/openjdk; \
    echo ${LATEST} > /opt/java/JAVA_VERSION ; \
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
    PATH="/opt/java/openjdk/bin:$PATH" \
    JAVA_VERSION="$(cat /opt/java/JAVA_VERSION)"

RUN echo Verifying install ... \
    && echo javac --version && javac --version \
    && echo java --version && java --version \
    && echo Complete.

VOLUME /var/lib/docker

ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]