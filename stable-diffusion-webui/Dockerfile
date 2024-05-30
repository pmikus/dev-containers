ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG WEBUI_VERSION
ARG TORCH_VERSION
ARG CU_VERSION
ARG XFORMERS_VERSION

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=on
ENV SHELL=/bin/bash
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu
ENV PATH="/workspace/venv/bin:$PATH"

WORKDIR /workspace

# Install system dependencies
RUN apt update --yes && \
    apt upgrade --yes && \
    apt install --yes --no-install-recommends \
    libglib2.0-0 libxrender1 psmisc bc \
    pkg-config libcairo2 libcairo2-dev libgoogle-perftools4 libtcmalloc-minimal4 apt-transport-https && \
    update-ca-certificates

# Cache Models
RUN mkdir /sd-models && mkdir /cn-models 
#    && \
#    wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned.ckpt -O /sd-models/v1-5-pruned.ckpt && \
#    wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors -O /sd-models/sd_xl_base_1.0.safetensors && \
#    wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors -O /sd-models/sd_xl_refiner_1.0.safetensors && \
#    wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth -O /cn-models/control_v11p_sd15_canny.pth

# Create a virtual environment
RUN python3 -m venv /workspace/venv && \
    pip install -U --no-cache-dir jupyterlab jupyterlab_widgets ipykernel ipywidgets

# Install Automatic1111's WebUI
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
    cd stable-diffusion-webui && \
    git checkout tags/${WEBUI_VERSION} && \
    pip install -r requirements_versions.txt && \
    python3 -c "from launch import prepare_environment; prepare_environment()" --skip-torch-cuda-test

# Install torch and xformers
RUN cd /workspace/stable-diffusion-webui && \
    pip install torch===${TORCH_VERSION} torchvision torchaudio --index-url https://download.pytorch.org/whl/${CU_VERSION} && \
    pip install xformers==${XFORMERS_VERSION} --index-url https://download.pytorch.org/whl/${CU_VERSION}

# Install DeForum
RUN cd /workspace/stable-diffusion-webui && \
    git clone https://github.com/deforum-art/sd-webui-deforum extensions/deforum && \
    cd extensions/deforum && \
    pip install basicsr && \
    pip install -r requirements.txt

# Install ControlNet
RUN cd /workspace/stable-diffusion-webui && \
    git clone https://github.com/Mikubill/sd-webui-controlnet.git extensions/sd-webui-controlnet && \
    cd extensions/sd-webui-controlnet && \
    pip install -r requirements.txt

COPY forge/cache-sd-model.py /workspace/stable-diffusion-webui/
RUN cd /workspace/stable-diffusion-webui/ && \
    python3 cache-sd-model.py --use-cpu=all --ckpt /sd-models/SDv1-5.ckpt

RUN mv /workspace/venv /venv && \
    mv /workspace/stable-diffusion-webui /stable-diffusion-webui && \
    mkdir /workspace/downloader && git clone https://github.com/jjangga0214/sd-models-downloader.git /workspace/downloader

COPY forge/relauncher.py forge/webui-user.sh /stable-diffusion-webui/

# Start Scripts
COPY pre_start.sh /pre_start.sh

CMD [ "/start.sh" ]
