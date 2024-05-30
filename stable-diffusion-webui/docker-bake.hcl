variable "IMAGE_REPOSITORY" {
    default = "pmikus/stable-diffusion-webui"
}

variable "RELEASE" {
    default = "0.0.1"
}

variable "CU_VERSION" {
    default = "cu121"
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
    targets = ["cpu"]
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
        FORGE_COMMIT = "29be1da7cf2b5dccfc70fbdd33eb35c56a31ffb7"
        CIVITAI_DOWNLOADER_VERSION = "2.1.0"
        VENV_PATH = "/workspace/venv/stable-diffusion-webui-forge"
        WEBUI_VERSION = "v1.8.0"
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
        FORGE_COMMIT = "29be1da7cf2b5dccfc70fbdd33eb35c56a31ffb7"
        CIVITAI_DOWNLOADER_VERSION = "2.1.0"
        VENV_PATH = "/workspace/venv/stable-diffusion-webui-forge"
        WEBUI_VERSION = "v1.8.0"
    }
}
