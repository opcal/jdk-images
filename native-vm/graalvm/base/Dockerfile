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
    echo ${BIN_ARCH} ; \
    curl -L "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}_linux-${BIN_ARCH}_bin.tar.gz" -o /tmp/graalvm.tar.gz ; \
    tar -xvzf /tmp/graalvm.tar.gz -C /opt/ ; \
    VM_NAME=$(ls /opt/ | grep graalvm-*) ; \
    mv /opt/${VM_NAME} /opt/graalvm-community-openjdk-${JDK_VERSION}


FROM --platform=${TARGETPLATFORM} ${BASE_IMAGE} 

ARG JDK_VERSION
ARG JAVA_VERSION

LABEL org.opencontainers.image.authors="opcal@outlook.com"

ENV JAVA_HOME=/opt/graalvm-community-openjdk-${JDK_VERSION} \
    PATH="/opt/graalvm-community-openjdk-${JDK_VERSION}/bin:$PATH"

COPY --from=builder /opt/graalvm-community-openjdk-${JDK_VERSION} /opt/graalvm-community-openjdk-${JDK_VERSION}

RUN echo ${JAVA_HOME}; echo ${PATH}; ls -lah /opt ; ls -lah /opt/graalvm-community-openjdk-${JDK_VERSION} ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential libz-dev zlib1g-dev ; \
    apt-get clean; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/* ; \
    gu --version && java --version

CMD ["jshell"]