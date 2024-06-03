variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion"
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

group "default" {
    targets = ["cuda"]
}

target "12-4-1" {
    dockerfile = "Dockerfile"
    tags = ["${IMAGE_REPOSITORY}:invokeai-${RELEASE}-${CUDA_VERSION}"]
    platforms = ["linux/amd64"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-${CUDA_VERSION}"
        CU_VERSION = "${CU_VERSION}"
    }
}

