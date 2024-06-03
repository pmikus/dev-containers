variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion-comfyui"
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
    targets = ["cpu", "12-4-1"]
}

target "cpu" {
    dockerfile = "Dockerfile"
    tags = ["${IMAGE_REPOSITORY}:${RELEASE}-cpu"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-cpu"
        CU_VERSION = ""
        TORCH_VERSION = "${TORCH_VERSION}"
        XFORMERS_VERSION = "${XFORMERS_VERSION}"
    }
}

target "12-4-1" {
    dockerfile = "Dockerfile"
    tags = ["${IMAGE_REPOSITORY}:${RELEASE}-${CUDA_VERSION}"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-${CUDA_VERSION}"
        CU_VERSION = "${CU_VERSION}"
        TORCH_VERSION = "${TORCH_VERSION}+${CU_VERSION}"
        XFORMERS_VERSION = "${XFORMERS_VERSION}"
    }
}
