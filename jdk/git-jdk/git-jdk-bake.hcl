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

target "git-jdk" {
    name = "git-jdk-${item.version}"
    matrix = {
        item = [
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
