ARG UBUNTU_VERSION=22.04

FROM arm64v8/ubuntu:${UBUNTU_VERSION} as base

ENV DEBIAN_FRONTEND=non-interactive

# Install required dependencies.
RUN apt-get update -qq \
  && apt-get install -y \
        apt-utils \
        locales \
  && sed -i 's/# \(en_US\.UTF-8 .*\)/\1/' /etc/locale.gen \
  && locale-gen en_US.UTF-8 \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && update-locale LANG=en_US.UTF-8 \
  && TZ=Etc/UTC && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && rm -r /var/lib/apt/lists/*
ENV LANG="en_US.UTF-8" LANGUAGE="en_US" LC_ALL="en_US.UTF-8"

RUN apt-get update -y \
 && apt-get upgrade --no-install-recommends -y \
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
    ruby \
    software-properties-common \
    ssh \
    sshpass \
    sudo \
    tmux \
    unzip \
    vim \
    wget \
 && python3 -m pip install \
    virtualenv \
    git-review \
    awswrangler \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb \
 && apt-get autoremove \
 && apt-get clean

# Install Hashicorp Packer
RUN wget https://releases.hashicorp.com/packer/1.8.6/packer_1.8.6_linux_arm64.zip \
 && unzip packer_1.8.6_linux_arm64.zip \
 && mv packer /usr/bin/ \
 && rm packer_1.8.6_linux_arm64.zip

# Install Hashicorp Terraform
RUN wget https://releases.hashicorp.com/terraform/1.4.5/terraform_1.4.5_linux_arm64.zip \
 && unzip terraform_1.4.5_linux_arm64.zip \
 && mv terraform /usr/bin/ \
 && rm terraform_1.4.5_linux_arm64.zip

# Install Hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_extended_0.111.3_linux-arm64.deb \
 && dpkg -i hugo_extended_0.111.3_linux-arm64.deb \
 && rm hugo_extended_0.111.3_linux-arm64.deb

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo "$SNIPPET" >> "/root/.bashrc"

FROM base

COPY postCreateCommand.sh /

# Initialize.
CMD ["/bin/bash"]
