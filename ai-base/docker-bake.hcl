variable "RELEASE" {
    default = "0.0.1"
}

group "default" {
    targets = ["cpu", "12-4-1"]
}

target "cpu" {
    dockerfile = "Dockerfile"
    tags = ["pmikus/ai-base:${RELEASE}-cpu"]
    platforms = ["linux/amd64", "linux/arm64"]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "ubuntu:22.04"
        PYTHON_VERSION = "3.10"
    }
}

target "12-4-1" {
    dockerfile = "Dockerfile"
    tags = ["pmikus/ai-base:${RELEASE}-cuda12.4.1"]
    platforms = ["linux/amd64", "linux/arm64"]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "nvidia/cuda:12.4.1-devel-ubuntu22.04"
        PYTHON_VERSION = "3.10"
    }
}
