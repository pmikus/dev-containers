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
      jupyter_contrib_nbextensions

RUN if [ "$CU_VERSION" = "cpu" ]; then \
        extra_packages=""; \
    else \
        extra_packages="xformers==${XFORMERS_VERSION}"; \
    fi && \
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

# Install Controlnet Preprocessor nodes
RUN cd ComfyUI/custom_nodes && git clone https://github.com/Fannovel16/comfy_controlnet_preprocessors && \
    cd comfy_controlnet_preprocessors && \
    python install.py --no_download_ckpts
RUN cd ComfyUI/custom_nodes && git clone https://github.com/Fannovel16/comfyui_controlnet_aux && \
    cd comfyui_controlnet_aux && \
    pip install -r requirements.txt
RUN cd ComfyUI/custom_nodes && git clone https://github.com/Stability-AI/stability-ComfyUI-nodes && \
    cd stability-ComfyUI-nodes && \
    pip install -r requirements.txt
RUN cd ComfyUI/custom_nodes && git clone https://github.com/EllangoK/ComfyUI-post-processing-nodes

# Install ComfyUI Manager
RUN cd ComfyUI/custom_nodes && git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    cd ComfyUI-Manager && \
    pip install -r requirements.txt

# Start Scripts
COPY pre_start.sh /pre_start.sh

CMD [ "/start.sh" ]
