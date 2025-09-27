group "default" {
    targets = ["jdk-ubuntu"]
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
    default = "noble"
}

target "jdk-ubuntu" {
    name = "${item.version}-${item.os}"
    matrix = {
        item = [
            {
                version = "11-jdk"
                os = "jammy"
            },
            {
                version = "11-jdk"
                os = "noble"
            },
            {
                version = "17-jdk"
                os = "jammy"
            },
            {
                version = "17-jdk"
                os = "noble"
            },
            {
                version = "21-jdk"
                os = "jammy"
            },
            {
                version = "21-jdk"
                os = "noble"
            },
            {
                version = "25-jdk"
                os = "jammy"
            },
            {
                version = "25-jdk"
                os = "noble"
            }
        ]
    }
    context = "${PROJECT_DIR}/jdk/eclipse-temurin"
    dockerfile = "base/ubuntu/Dockerfile"
    args = {
        BASE_IMAGE = "eclipse-temurin:${item.version}-${item.os}"
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/eclipse-temurin:${item.version}-${item.os}",
        equal(item.os, LATEST_OS) ? "${CI_REGISTRY}/opcal/eclipse-temurin:${item.version}" : ""
    ]
}
