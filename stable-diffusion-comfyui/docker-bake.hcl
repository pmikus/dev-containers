variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion-comfy-ui"
}

variable "RELEASE" {
    default = "0.2.4"
}

variable "TORCH_VERSION" {
    default = "2.4.1"
}

variable "XFORMERS_VERSION" {
    default = "0.0.28.post1"
}

group "default" {
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
        CU_VERSION = "cpu"
        TORCH_VERSION = "${TORCH_VERSION}+cpu"
        XFORMERS_VERSION = "${XFORMERS_VERSION}"
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
        CU_VERSION = "cu124"
        TORCH_VERSION = "${TORCH_VERSION}+cu124"
        XFORMERS_VERSION = "${XFORMERS_VERSION}"
    }
}
