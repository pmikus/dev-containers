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
        extra_packages=""; \
    fi && \
    pip install --upgrade --no-cache-dir \
      "InvokeAI[xformers]" \
      ${extra_packages} --use-pep517 --extra-index-url https://download.pytorch.org/whl/${CU_VERSION} && \
    pip install pypatchmatch

# Start Scripts
COPY pre_start.sh /pre_start

CMD ["/start.sh"]
