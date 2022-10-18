FROM registry.gitlab.com/opcal-project/containers/alpine:latest as builder

ARG JDK_URL

RUN set -eux; \
    curl -L ${JDK_URL} -o /tmp/openjdk.tar.gz ; \
    mkdir -p /opt/java/openjdk; \
    tar --extract \
	      --file /tmp/openjdk.tar.gz \
	      --directory /opt/java/openjdk \
	      --strip-components 1 \
	      --no-same-owner 

FROM docker:latest

ARG LATEST

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apk add --no-cache tzdata musl-locales musl-locales-lang bash ; \
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

CMD ["jshell"]
