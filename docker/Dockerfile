FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN --mount=type=cache,target=/var/cache/apt,sharing=private \
    sed -i 's@//.*.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list \
    && apt update \
    && apt install -y hashalot \
        # from ci
        ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
        bzip2 ccache clang cmake cpio curl device-tree-compiler ecj fastjar flex gawk gettext gcc-multilib \
        g++-multilib git gnutls-dev gperf haveged help2man intltool lib32gcc-s1 libc6-dev-i386 libelf-dev \
        libglib2.0-dev libgmp3-dev libltdl-dev libmpc-dev libmpfr-dev libncurses-dev libpython3-dev \
        libreadline-dev libssl-dev libtool libyaml-dev libz-dev lld llvm lrzsz mkisofs msmtp nano \
        ninja-build p7zip p7zip-full patch pkgconf python3 python3-pip python3-ply python3-docutils \
        python3-pyelftools qemu-utils re2c rsync scons squashfs-tools subversion swig texinfo uglifyjs \
        upx-ucl unzip vim wget xmlto xxd zlib1g-dev zstd \
    && true
ENV PATH="/usr/lib/ccache:$PATH"
ARG PGID=1000
ENV PGID=${PGID}
ARG PUID=1000
ENV PUID=${PUID}
RUN groupadd -g $PGID builder && \
    useradd -m -u $PUID -g builder -s /bin/bash builder \
    && mkdir -p /home/builder \
    && chown -R builder:builder /home/builder \
    && mkdir -p /home/builder/.ccache \
    && chown -R builder:builder /home/builder/.ccache

RUN mkdir -p /home/builder/openwrt
WORKDIR /home/builder/openwrt
USER builder
