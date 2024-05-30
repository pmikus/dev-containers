variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion-webui"
}

variable "RELEASE" {
    default = "0.0.1"
}

variable "CU_VERSION" {
    default = "121"
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
    targets = ["12-4-1"]
}

target "12-4-1" {
    dockerfile = "Dockerfile"
    tags = ["${IMAGE_REPOSITORY}:${RELEASE}-${CUDA_VERSION}"]
    args = {
        RELEASE = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-${CUDA_VERSION}"
        TORCH_VERSION = "${TORCH_VERSION}+cu${CU_VERSION}"
        XFORMERS_VERSION = "${XFORMERS_VERSION}"
        FORGE_COMMIT = "29be1da7cf2b5dccfc70fbdd33eb35c56a31ffb7"
        CIVITAI_DOWNLOADER_VERSION = "2.1.0"
        VENV_PATH = "/workspace/venv/stable-diffusion-webui-forge"
        WEBUI_VERSION = "v1.8.0"
    }
}
