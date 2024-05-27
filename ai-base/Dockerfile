ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ENV SHELL=/bin/bash
ENV PYTHONUNBUFFERED=True
ENV DEBIAN_FRONTEND=noninteractive

# Set the base release version
ARG BASE_RELEASE_VERSION
ENV BASE_RELEASE_VERSION=${BASE_RELEASE_VERSION}

# Override the default huggingface cache directory.
ENV HF_HOME="/volume/.cache/huggingface/"
ENV HF_DATASETS_CACHE="/volume/.cache/huggingface/datasets/"
ENV DEFAULT_HF_METRICS_CACHE="/volume/.cache/huggingface/metrics/"
ENV DEFAULT_HF_MODULES_CACHE="/volume/.cache/huggingface/modules/"
ENV HUGGINGFACE_HUB_CACHE="/volume/.cache/huggingface/hub/"
ENV HUGGINGFACE_ASSETS_CACHE="/volume/.cache/huggingface/assets/"

# Faster transfer of models from the hub to the container
ENV HF_HUB_ENABLE_HF_TRANSFER="1"

# Shared python package cache
ENV VIRTUALENV_OVERRIDE_APP_DATA="/volume/.cache/virtualenv/"
ENV PIP_CACHE_DIR="/volume/.cache/pip/"
ENV UV_CACHE_DIR="/volume/.cache/uv/"

# Set Default Python Version
ARG PYTHON_VERSION
ENV PYTHON_VERSION=${PYTHON_VERSION}

WORKDIR /

# Update, upgrade, install packages and clean up
RUN apt-get update --yes && \
    apt-get upgrade --yes && \

    # Basic Utilities
    apt install --yes --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    file \
    git \
    inotify-tools \
    jq \
    libgl1 \
    lsof \
    vim \
    nano \
    tmux \
    nginx \

    # Required for SSH access
    openssh-server \

    procps \
    rsync \
    sudo \
    software-properties-common \
    unzip \
    wget \
    zip && \

    # Build Tools and Development
    apt install --yes --no-install-recommends \
    build-essential \
    make \
    cmake \
    gfortran \
    libblas-dev \
    liblapack-dev && \

    # Image and Video Processing
    apt install --yes --no-install-recommends \
    ffmpeg \
    libavcodec-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libjpeg-dev \
    libpng-dev \
    libpostproc-dev \
    libswresample-dev \
    libswscale-dev \
    libtiff-dev \
    libv4l-dev \
    libx264-dev \
    libxext6 \
    libxrender-dev \
    libxvidcore-dev && \

    # Deep Learning Dependencies and Miscellaneous
    apt install --yes --no-install-recommends \
    libatlas-base-dev \
    libffi-dev \
    libhdf5-serial-dev \
    libsm6 \
    libssl-dev && \

    # File Systems and Storage
    apt install --yes --no-install-recommends \
    cifs-utils \
    nfs-common \
    zstd && \

    # Add the Python PPA and install Python versions
    apt install --yes --no-install-recommends \
    python${PYTHON_VERSION}-dev \
    python${PYTHON_VERSION}-venv \
    python${PYTHON_VERSION}-distutils && \

    # Cleanup
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \

    # Set locale
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python${PYTHON_VERSION} get-pip.py

# Get the latest pip for all python versions
RUN python${PYTHON_VERSION} -m pip install --upgrade pip

# Install virtualenv
RUN python${PYTHON_VERSION} -m pip install virtualenv

# Install pip drop-in replacement uv (https://github.com/astral-sh/uv)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# NGINX Proxy
COPY nginx.conf /etc/nginx/nginx.conf

# Start Scripts
COPY start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
