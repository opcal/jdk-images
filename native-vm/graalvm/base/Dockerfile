ARG BASE_IMAGE

FROM --platform=${TARGETPLATFORM} ${BASE_IMAGE} AS builder 

ARG GRAALVM_VERSION
ARG JAVA_VERSION

RUN apt-get update; \
    apt-get install -y --no-install-recommends tar gzip; \
    ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF })"; \
    case "${ARCH}" in \
        aarch64|arm64) \
            BIN_ARCH=aarch64 ; \
            ;; \
        amd64|x86_64) \
            BIN_ARCH=amd64 ; \
            ;; \
        *) \
            echo "Unsupported arch: ${ARCH}"; \
            exit 1; \
            ;; \
    esac; \
    curl -L "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${JAVA_VERSION}-linux-${dpkBIN_ARCHgArch}-${GRAALVM_VERSION}.tar.gz" -o /tmp/graalvm.tar.gz ; \
    tar -xvzf /tmp/graalvm.tar.gz -C /opt/ ; \
    /opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION}/bin/gu install native-image

FROM --platform=${TARGETPLATFORM} ${BASE_IMAGE} 

ARG GRAALVM_VERSION
ARG JAVA_VERSION

LABEL org.opencontainers.image.authors="opcal@outlook.com"

ENV JAVA_HOME=/opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION} \
    PATH="/opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION}/bin:$PATH"

COPY --from=builder /opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION} /opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION}

RUN echo ${JAVA_HOME}; echo ${PATH}; ls -lah /opt ; ls -lah /opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION} ; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential libz-dev zlib1g-dev ; \
    apt-get clean; \
    apt-get -y autoclean; \
    apt-get -y autoremove; \
    rm -rf /var/lib/apt/lists/* ; \
    gu --version && java --version

CMD ["jshell"]