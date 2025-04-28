group "default" {
    targets = ["ubuntu-dind-jdk"]
}

variable "PROJECT_DIR" {
    type = string
}

variable "CI_REGISTRY" {
    type = string
}

target "ubuntu-dind-jdk" {
    name = "ubuntu-dind-jdk-${jdk_version}"
    matrix = {
        jdk_version = ["11", "17", "21"]
    }
    context = "${PROJECT_DIR}/jdk/ubuntu-dind-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        JDK_VERSION = jdk_version
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/ubuntu-dind-jdk:${jdk_version}"
    ]
}
