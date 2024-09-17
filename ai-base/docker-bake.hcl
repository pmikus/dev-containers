variable "IMAGE_REPOSITORY" {
    default = "pmikus/ai-base"
}

variable "RELEASE" {
    default = "0.0.1"
}

group "default" {
    targets = [
      "cpu",
      "cuda-12-6-1"
    ]
}

target "cpu" {
    dockerfile = "Dockerfile"
    tags = [
      "${IMAGE_REPOSITORY}:${RELEASE}-cpu"
    ]
    platforms = [
      "linux/amd64",
      "linux/arm64"
    ]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "ubuntu:22.04"
        PYTHON_VERSION = "3.10"
    }
}

target "cuda-12-4-1" {
    dockerfile = "Dockerfile"
    tags = [
      "${IMAGE_REPOSITORY}:${RELEASE}-cuda12.4.1"
    ]
    platforms = [
      "linux/amd64",
      "linux/arm64"
    ]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "nvidia/cuda:12.4.1-devel-ubuntu22.04"
        PYTHON_VERSION = "3.10"
    }
}

target "cuda-12-6-1" {
    dockerfile = "Dockerfile"
    tags = [
      "${IMAGE_REPOSITORY}:${RELEASE}-cuda12.6.1"
    ]
    platforms = [
      "linux/amd64",
      "linux/arm64"
    ]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "nvidia/cuda:12.6.1-devel-ubuntu22.04"
        PYTHON_VERSION = "3.10"
    }
}
