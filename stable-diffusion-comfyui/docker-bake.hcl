variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion-comfy-ui"
}

variable "RELEASE" {
    default = "0.2.4"
}

group "default" {
    targets = [
      "cuda-12-4-1"
    ]
}

group "all" {
    targets = [
      "cpu",
      "cuda-12-4-1"
    ]
}

target "cpu" {
    dockerfile = "Dockerfile"
    tags = [
      "${IMAGE_REPOSITORY}:latest",
      "${IMAGE_REPOSITORY}:${RELEASE}-cpu"
    ]
    platforms = [
      "linux/amd64"
    ]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:0.0.1-cpu"
    }
}

target "cuda-12-4-1" {
    dockerfile = "Dockerfile"
    tags = [
      "${IMAGE_REPOSITORY}:latest",
      "${IMAGE_REPOSITORY}:${RELEASE}-cuda12.4.1"
    ]
    platforms = [
      "linux/amd64"
    ]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:0.0.1-cuda12.4.1"
    }
}
