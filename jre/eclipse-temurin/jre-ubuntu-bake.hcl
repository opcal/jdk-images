group "default" {
    targets = ["jre-ubuntu"]
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

variable "LATEST_OS" {
    default = "resolute"
}

target "jre-ubuntu" {
    name = "${item.version}-${item.os}"
    matrix = {
        item = [
            {
                version = "11-jre"
                os = "jammy"
            },
            {
                version = "11-jre"
                os = "noble"
            },
            {
                version = "11-jre"
                os = "resolute"
            },
            {
                version = "17-jre"
                os = "jammy"
            },
            {
                version = "17-jre"
                os = "noble"
            },
            {
                version = "17-jre"
                os = "resolute"
            },
            {
                version = "21-jre"
                os = "jammy"
            },
            {
                version = "21-jre"
                os = "noble"
            },
            {
                version = "21-jre"
                os = "resolute"
            },
            {
                version = "25-jre"
                os = "jammy"
            },
            {
                version = "25-jre"
                os = "noble"
            },
            {
                version = "25-jre"
                os = "resolute"
            }
        ]
    }
    context = "${PROJECT_DIR}/jre/eclipse-temurin"
    dockerfile = "base/ubuntu/Dockerfile"
    args = {
        BASE_IMAGE = "eclipse-temurin:${item.version}-${item.os}"
    }
    platforms = ["linux/amd64", "linux/arm64/v8"]

    tags = [
        "${CI_REGISTRY}/opcal/eclipse-temurin:${item.version}-${item.os}",
        equal(item.os, LATEST_OS) ? "${CI_REGISTRY}/opcal/eclipse-temurin:${item.version}" : ""
    ]
}
