variable "RELEASE" {
    default = "0.0.1"
}

group "default" {
    targets = ["cpu", "cuda"]
}

target "cpu" {
    dockerfile = "Dockerfile"
    tags = ["pmikus/stable-diffusion:invokeai-${RELEASE}"]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-cpu"
        GPU_DRIVER = "cpu"
    }
}

target "cuda" {
    dockerfile = "Dockerfile"
    tags = ["pmikus/stable-diffusion:invokeai-${RELEASE}"]
    args = {
        BASE_RELEASE_VERSION = "${RELEASE}"
        BASE_IMAGE = "pmikus/ai-base:${RELEASE}-cuda12.4.1"
        GPU_DRIVER = "cuda"
    }
}

