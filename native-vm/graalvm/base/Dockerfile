ARG BASE_IMAGE

FROM ${BASE_IMAGE} AS builder 

ARG GRAALVM_VERSION
ARG JAVA_VERSION
ARG TARGETPLATFORM
ARG GRAALVM_PKG=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${JAVA_VERSION}-${TARGETPLATFORM}-${GRAALVM_VERSION}.tar.gz

RUN apt-get update; \
    apt-get install -y --no-install-recommends tar gzip; \
    curl -L ${GRAALVM_PKG} -o /tmp/graalvm.tar.gz ; \
    tar -xvzf /tmp/graalvm.tar.gz -C /opt/ ; \
    /opt/graalvm-ce-${JAVA_VERSION}-${GRAALVM_VERSION}/bin/gu install native-image

FROM ${BASE_IMAGE} 

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