# Import necessary base images
ARG BASE_IMAGE
FROM ${BASE_IMAGE} as runtime

ARG TORCH_VERSION
ARG CU_VERSION
ARG XFORMERS_VERSION

# Set working directory and environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=on
ENV SHELL=/bin/bash
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu
ENV PATH="/workspace/venv/bin:$PATH"
ENV PATH="/root/.cargo/bin:$PATH"

WORKDIR /workspace

# Install necessary Python packages
RUN if [ "$CU_VERSION" = "cpu" ]; then \
        extra_packages=""; \
    else \
        extra_packages="xformers==${XFORMERS_VERSION}"; \
    fi && \
    uv venv && \
    pip install --upgrade --no-cache-dir pip && \
    pip install --upgrade setuptools && \
    pip install --upgrade wheel && \
    pip install --upgrade --no-cache-dir \
      torch==${TORCH_VERSION} \
      torchvision \
      torchaudio \
      ${extra_packages} \
      --extra-index-url https://download.pytorch.org/whl/${CU_VERSION}

# Install ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip install -r requirements.txt

WORKDIR /workspace/ComfyUI/custom_nodes/

# Install ComfyUI Manager
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager && \
    cd ComfyUI-Manager && \
    pip install -r requirements.txt

# Install Custom nodes for ComfyUI
RUN git clone https://github.com/Stability-AI/stability-ComfyUI-nodes && \
    cd stability-ComfyUI-nodes && \
    pip install -r requirements.txt

# Install ComfyUI's ControlNet Auxiliary Preprocessors
RUN git clone https://github.com/Fannovel16/comfyui_controlnet_aux && \
    cd comfyui_controlnet_aux && \
    pip install -r requirements.txt

# Install ComfyUI Noise
RUN git clone https://github.com/BlenderNeko/ComfyUI_Noise

# Install UltimateSDUpscale
RUN git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive

# Install Efficiency Nodes
RUN git clone https://github.com/jags111/efficiency-nodes-comfyui && \
    cd efficiency-nodes-comfyui && \
    pip install -r requirements.txt

# Install BNB Nodes & GGUF
RUN git clone https://github.com/comfyanonymous/ComfyUI_bitsandbytes_NF4 && \
    cd ComfyUI_bitsandbytes_NF4 && \
    pip install -r requirements.txt

RUN git clone https://github.com/DenkingOfficial/ComfyUI_UNet_bitsandbytes_NF4 && \
    cd ComfyUI_UNet_bitsandbytes_NF4 && \
    pip install -r requirements.txt

RUN git clone https://github.com/city96/ComfyUI-GGUF && \
    cd ComfyUI-GGUF && \
    pip install -r requirements.txt

WORKDIR /workspace/ComfyUI

CMD [ "python3", "main.py", "--listen", "0.0.0.0", "--output-directory", "/volume/" ]
