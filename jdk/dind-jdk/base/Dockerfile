FROM ghcr.io/opcal/alpine:latest AS builder

ARG JAVA_VERSION
ARG API_URL="https://api.adoptium.net/v3/assets/latest/${JAVA_VERSION}/hotspot?architecture=x64&image_type=jdk&os=alpine-linux&vendor=eclipse"

RUN set -eux; \
    apk --no-cache add jq ; \
    RESULT=$(curl -s "${API_URL}") ; \
    JDK_VERSION=$(echo "${RESULT}" | jq '.[0].version.openjdk_version' | cut -d '"' -f 2) ; \
    CHECKSUM=$(echo "${RESULT}" | jq '.[0].binary.package.checksum' | cut -d '"' -f 2) ;\
    DOWNLOAD_LINK=$(echo "${RESULT}" | jq '.[0].binary.package.link' | cut -d '"' -f 2) ; \
    curl -Ls ${DOWNLOAD_LINK} -o /tmp/openjdk.tar.gz ; \
    echo "${CHECKSUM} */tmp/openjdk.tar.gz" | sha256sum -c - ; \
    echo "Downloaded successfully" ; \
    mkdir -p /opt/java/openjdk; \
    tar --extract \
	      --file /tmp/openjdk.tar.gz \
	      --directory /opt/java/openjdk \
	      --strip-components 1 \
	      --no-same-owner 

FROM docker:dind

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apk add --no-cache \
        bash \
        ca-certificates \
        curl \
        git \
		gnupg \
        musl-locales \
        musl-locales-lang \
        net-tools \
        tzdata ; \
    rm -rf /var/cache/apk/* ; \
    mkdir -p /opt/java/openjdk

COPY --from=builder /opt/java/openjdk /opt/java/openjdk

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

RUN echo Verifying install ... \
    && echo javac --version && javac --version \
    && echo java --version && java --version \
    && echo Complete.

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
