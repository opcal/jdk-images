group "default" {
    targets = ["dind-jdk"]
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


target "dind-jdk" {
    name = "dind-jdk-${jdk_version}"
    matrix = {
        jdk_version = ["11", "17", "21"]
    }
    context = "${PROJECT_DIR}/jdk/dind-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        JAVA_VERSION = jdk_version
    }
    platforms = ["linux/amd64"]

    tags = [
        "${CI_REGISTRY}/opcal/dind-jdk:${jdk_version}",
    ]
}
