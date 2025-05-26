group "default" {
    targets = ["git-jdk"]
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

target "git-jdk-11" {
    context = "${PROJECT_DIR}/jdk/git-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        BASE_IMAGE = "ghcr.io/opcal/eclipse-temurin:11-jdk"
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/git-jdk:11",
    ]
}

target "git-jdk-17" {
    context = "${PROJECT_DIR}/jdk/git-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        BASE_IMAGE = "ghcr.io/opcal/eclipse-temurin:17-jdk"
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/git-jdk:17",
    ]
}

target "git-jdk-21" {
    context = "${PROJECT_DIR}/jdk/git-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        BASE_IMAGE = "ghcr.io/opcal/eclipse-temurin:21-jdk"
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/git-jdk:21",
    ]
}

target "git-jdk" {
    name = "git-jdk-${item.version}"
    matrix = {
        item = [
            {
                base = "ghcr.io/opcal/eclipse-temurin:11-jdk"
                version = "11"
            },
            {
                base = "ghcr.io/opcal/eclipse-temurin:17-jdk"
                version = "17"
            },
            {
                base = "ghcr.io/opcal/eclipse-temurin:21-jdk"
                version = "21"
            },
        ]
    }
    context = "${PROJECT_DIR}/jdk/git-jdk"
    dockerfile = "base/Dockerfile"
    args = {
        BASE_IMAGE = item.base
    }
    platforms = ["linux/amd64", "linux/arm64"]

    tags = [
        "${CI_REGISTRY}/opcal/git-jdk:${item.version}",
    ]
}
