group "default" {
    targets = ["graalvm"]
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

target "graalvm" {
    name = "${item.version}"
    matrix = {
        item = [
            {
                base = "ghcr.io/opcal/ubuntu:noble"
                version = "21"
            }
        ]
    }
    context = "${PROJECT_DIR}/native-vm/graalvm"
    dockerfile = "base/Dockerfile"
    args = {
        BASE_IMAGE = item.base,
        GOSU_VERSION = "${GOSU_VERSION}"
    }
    platforms = ["linux/amd64", "linux/arm64"]
    tags = [
        "${CI_REGISTRY}/opcal/graalvm:${item.version}"
    ]
}
