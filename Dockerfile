ARG UBUNTU_VERSION=22.04

FROM arm64v8/ubuntu:${UBUNTU_VERSION} as base

ENV DEBIAN_FRONTEND=non-interactive

# Install required dependencies.
RUN apt-get update -y \
 && apt-get --no-install-recommends -y upgrade \
 && apt-get install --no-install-recommends -y \
    apt-transport-https \
    build-essential \
    curl \
    git \
    ipmitool \
    iputils-ping \
    iproute2 \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-software-properties \
    software-properties-common \
    ssh \
    sshpass \
    sudo \
    tmux \
    unzip \
    vim \
    wget \
    xsel \
 && python3 -m pip install --no-cache-dir -U \
      ansible \
      git-review \
      pip \
      wheel \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb \
 && apt-get autoremove \
 && apt-get clean

# Install Hashicorp Packer
RUN wget https://releases.hashicorp.com/packer/1.8.3/packer_1.8.3_linux_arm64.zip \
 && unzip packer_1.8.3_linux_arm64.zip \
 && mv packer /usr/bin/

FROM base

# Initialize.
CMD ["/bin/bash"]