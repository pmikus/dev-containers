# Import necessary base images
ARG BASE_IMAGE
FROM ${BASE_IMAGE:-pmikus/ai-base:0.0.1-cpu}

# Set working directory and environment variables
ENV SHELL=/bin/bash
ENV PYTHONUNBUFFERED=true
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=on
ENV PATH="/workspace/venv/bin:$PATH"

ARG CPU_FLAG

WORKDIR /workspace/

# Install ComfyUI
RUN uv pip install comfy-cli pip && \
    comfy --here --skip-prompt install "$CPU_FLAG" && \
    comfy --here manager enable-gui

CMD ["comfy", "--here", "launch", "--", "$CPU_FLAG", "--listen", "0.0.0.0"]