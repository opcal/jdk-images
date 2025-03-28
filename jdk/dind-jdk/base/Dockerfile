FROM ghcr.io/opcal/alpine:latest AS builder

ARG API_URL

RUN set -eux; \
    FETCH_URL=$(curl -s -w %{redirect_url} "${API_URL}") ; \
    FILENAME=$(curl -OLs -w %{filename_effective} "${FETCH_URL}") ; \
    curl -Ls "${FETCH_URL}.sha256.txt" | sha256sum -c - ; \
    echo "Downloaded successfully as ${FILENAME}" ; \
    mkdir -p /opt/java/openjdk; \
    tar --extract \
	      --file ${FILENAME} \
	      --directory /opt/java/openjdk \
	      --strip-components 1 \
	      --no-same-owner 

FROM docker:dind

ARG LATEST

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
    PATH="/opt/java/openjdk/bin:$PATH" \
    JAVA_VERSION="${LATEST}"

RUN echo Verifying install ... \
    && echo javac --version && javac --version \
    && echo java --version && java --version \
    && echo Complete.

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
