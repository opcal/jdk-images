ARG BASE_IMAGE

FROM --platform=${TARGETPLATFORM} ${BASE_IMAGE} AS builder 

ARG JDK_VERSION
ARG JAVA_VERSION

RUN apt-get update; \
    apt-get install -y --no-install-recommends tar gzip; \
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
    curl -L "https://download.oracle.com/java/${JDK_VERSION}/archive/jdk-${JAVA_VERSION}_linux-${BIN_ARCH}_bin.tar.gz" -o /tmp/graalvm.tar.gz ; \
    tar -xvzf /tmp/graalvm.tar.gz -C /opt/ 


FROM --platform=${TARGETPLATFORM} ${BASE_IMAGE} 

ARG JDK_VERSION
ARG JAVA_VERSION

LABEL org.opencontainers.image.authors="opcal@outlook.com"

ENV JAVA_HOME=/opt/jdk-${JAVA_VERSION} \
    PATH="/opt/jdk-${JAVA_VERSION}/bin:$PATH"

COPY --from=builder /opt/jdk-${JAVA_VERSION} /opt/jdk-${JAVA_VERSION}

RUN echo ${JAVA_HOME}; echo ${PATH}; ls -lah /opt ; ls -lah /opt/jdk-${JAVA_VERSION} ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential libz-dev zlib1g-dev ; \
    apt-get clean; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/* ; \
    java --version

CMD ["jshell"]