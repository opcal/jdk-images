group "default" {
    targets = ["jre-alpine"]
}

variable "PROJECT_DIR" {
    type = string
}

variable "CI_REGISTRY" {
    type = string
}

variable "TIMESTAMP" {
    type = string
}

variable "GOSU_VERSION" {
    type = string
}

target "jre-alpine" {
    name = "${item.version}"
    matrix = {
        item = [
            {
                base = "eclipse-temurin:11-jre-alpine"
                version = "11-jre-alpine"
            },
            {
                base = "eclipse-temurin:17-jre-alpine"
                version = "17-jre-alpine"
            },
            {
                base = "eclipse-temurin:21-jre-alpine"
                version = "21-jre-alpine"
            }
        ]
    }
    context = "${PROJECT_DIR}/jre/eclipse-temurin"
    dockerfile = "base/alpine/Dockerfile"
    args = {
        BASE_IMAGE = item.base,
        GOSU_VERSION = "${GOSU_VERSION}"
    }
    # there are no arm64 alpine version jre
    platforms = ["linux/amd64"]
    tags = [
        "${CI_REGISTRY}/opcal/eclipse-temurin:${item.version}"
    ]
}
