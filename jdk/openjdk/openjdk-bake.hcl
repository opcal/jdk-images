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
        jdk_version = ["11-jdk-slim", "17-jdk-slim", "21-jdk-slim"]
    }
    context = "${PROJECT_DIR}/jdk/eclipse-temurin"
    dockerfile = "base/ubuntu/Dockerfile"
    args = {
        BASE_IMAGE = "openjdk:${jdk_version}"
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/openjdk:${jdk_version}",
    ]
}
