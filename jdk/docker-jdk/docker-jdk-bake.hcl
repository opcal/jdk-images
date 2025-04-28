group "default" {
    targets = ["docker-jdk"]
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


target "docker-jdk" {
    name = "docker-jdk-${jdk_version}"
    matrix = {
        jdk_version = ["11", "17", "21"]
    }
    context = "${PROJECT_DIR}/jdk/docker-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        JAVA_VERSION = jdk_version
    }
    platforms = ["linux/amd64"]

    tags = [
        "${CI_REGISTRY}/opcal/docker-jdk:${jdk_version}",
    ]
}
