variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion-comfy-ui"
}

variable "RELEASE" {
    default = "0.0.1"
}

variable "CU_VERSION" {
    default = "cu118"
}

variable "CUDA_VERSION" {
    default = "cuda12.4.1"
}

variable "TORCH_VERSION" {
    default = "2.3.0"
}

variable "XFORMERS_VERSION" {
    default = "0.0.26.post1"
}

group "default" {
    targets = [
      "cuda"
    ]
}

target "cuda" {
    dockerfile = "Dockerfile"
    tags = [
      "${IMAGE_REPOSITORY}:latest",
      "${IMAGE_REPOSITORY}:${RELEASE}-${CUDA_VERSION}"
    ]
    platforms = [
      "linux/amd64"
    ]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-${CUDA_VERSION}"
        CU_VERSION = "${CU_VERSION}"
        TORCH_VERSION = "${TORCH_VERSION}+${CU_VERSION}"
        XFORMERS_VERSION = "${XFORMERS_VERSION}"
    }
}
