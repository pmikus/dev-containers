ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ENV SHELL=/bin/bash
ENV PYTHONUNBUFFERED=True
ENV DEBIAN_FRONTEND=noninteractive

# Set the base release version
ARG BASE_RELEASE_VERSION
ENV BASE_RELEASE_VERSION=${BASE_RELEASE_VERSION}

ENV INVOKEAI_ROOT=/workspace/invokeai

RUN python3 -m venv ${INVOKEAI_ROOT}/venv
ENV PATH="${INVOKEAI_ROOT}/venv/bin:$PATH"

WORKDIR ${INVOKEAI_ROOT}
ARG GPU_DRIVER
ARG TARGETPLATFORM="linux/amd64"

RUN python3 -m pip install --upgrade pip && \
    if [ "$TARGETPLATFORM" = "linux/arm64" ] || [ "$GPU_DRIVER" = "cpu" ]; then \
        extra_index_url_arg="--extra-index-url https://download.pytorch.org/whl/cpu"; \
    else \
        extra_index_url_arg="--extra-index-url https://download.pytorch.org/whl/cu121"; \
    fi && \
    pip install $extra_index_url_arg "InvokeAI[xformers]" && \
    pip install pypatchmatch && \
    mv ${INVOKEAI_ROOT} /invokeai

# Start Scripts
COPY pre_start.sh /
RUN chmod +x /pre_start.sh

CMD ["/start.sh"]
