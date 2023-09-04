FROM debian:bookworm as base

ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies.
RUN apt-get update -y \
 && apt-get --no-install-recommends -y upgrade \
 && apt-get install --no-install-recommends -y \
    apt-transport-https \
    curl \
    gcc \
    git \
    iputils-ping \
    iproute2 \
    python3 \
    python3-apt \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-software-properties \
    python3-wheel \
    tmux \
    wget \
 && rm -f /usr/lib/python3.11/EXTERNALLY-MANAGED \
 && python3 -m pip install --no-cache-dir -U pip wheel \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb \
 && apt-get autoremove \
 && apt-get clean

WORKDIR /root

RUN wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz \
 && tar xzvf nvim-linux64.tar.gz --strip-components=1 \
 && rm nvim-linux64.tar.gz

FROM base

# Initialize.
CMD ["/bin/tmux", "new-session", "-d", "-s", "container"]
