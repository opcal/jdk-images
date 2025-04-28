group "default" {
    targets = ["jdk-alpine"]
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

target "jdk-alpine" {
    name = "${item.version}"
    matrix = {
        item = [
            {
                base = "eclipse-temurin:11-jdk-alpine"
                version = "11-jdk-alpine"
            },
            {
                base = "eclipse-temurin:17-jdk-alpine"
                version = "17-jdk-alpine"
            },
            {
                base = "eclipse-temurin:21-jdk-alpine"
                version = "21-jdk-alpine"
            }
        ]
    }
    context = "${PROJECT_DIR}/jdk/eclipse-temurin"
    dockerfile = "base/alpine/Dockerfile"
    args = {
        BASE_IMAGE = "${item.base}",
        GOSU_VERSION = "${GOSU_VERSION}"
    }
    platforms = ["linux/amd64"]
    tags = [
        "${CI_REGISTRY}/opcal/eclipse-temurin:${item.version}"
    ]
}
