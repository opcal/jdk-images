group "default" {
    targets = ["openjdk"]
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

target "openjdk" {
    name = "openjdk-${jdk_version}"
    matrix = {
        jdk_version = ["11-slim", "17-slim", "21-slim", "25-slim"]
    }
    context = "${PROJECT_DIR}/jdk/openjdk"
    dockerfile = "base/Dockerfile"
    args = {
        BASE_IMAGE = "openjdk:${jdk_version}"
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/openjdk:${jdk_version}",
    ]
}
