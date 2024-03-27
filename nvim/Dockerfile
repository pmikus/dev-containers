FROM debian:bookworm as nvim_compile

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
 && apt-get install --no-install-recommends -y \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    file \
    gettext \
    git \
    make \
    ninja-build \
    unzip

WORKDIR /root

RUN git clone https://github.com/neovim/neovim.git \
 && cd neovim \
 && git checkout v0.9.1 -b stable \
 && make CMAKE_BUILD_TYPE=RelWithDebInfo \
 && cd build \
 && cpack -G DEB

FROM python:3.11-slim-bookworm as base

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

RUN apt-get update -y \
 && apt-get install --no-install-recommends -y \
    curl \
    git \
    tmux \
    wget \
 && rm -f /usr/lib/python3.11/EXTERNALLY-MANAGED \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /usr/share/man/* \
 && apt-get autoremove \
 && apt-get clean autoclean \
 && git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm \
 && /root/.tmux/plugins/tpm/bin/install_plugins

COPY --from=nvim_compile /root/neovim/build/nvim-linux64.deb .

RUN dpkg -i nvim-linux64.deb && rm nvim-linux64.deb

# Initialize.
CMD ["/bin/tmux"]
