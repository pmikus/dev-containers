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

WORKDIR /workspace

# Install necessary Python packages
RUN python3 -m venv /workspace/venv && \
    pip install --upgrade --no-cache-dir pip && \
    pip install --upgrade setuptools && \
    pip install --upgrade wheel && \
    pip install --upgrade --no-cache-dir \
      jupyterlab \
      ipywidgets \
      jupyter-archive \
      jupyter_contrib_nbextensions \
      triton \
      gdown

RUN pip install --upgrade --no-cache-dir \
      torch==${TORCH_VERSION} \
      torchvision \
      torchaudio \
      xformers==${XFORMERS_VERSION} --index-url https://download.pytorch.org/whl/${CU_VERSION}

# Install ComfyUI and ComfyUI Manager
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip install -r requirements.txt && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager && \
    cd custom_nodes/ComfyUI-Manager && \
    pip install -r requirements.txt

# Create necessary directories and copy necessary files
RUN mkdir -p /root/.cache/huggingface && \
    mkdir -p /comfy-models

# Start Scripts
COPY pre_start.sh /pre_start.sh

CMD [ "/start.sh" ]
