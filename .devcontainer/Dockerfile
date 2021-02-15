# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.159.0/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

ENV PACKAGES \
    build-essential \
    flex \
    bison \
    ccache \
    clang-10\
    gcc \
    qemu-system-arm \
    genisoimage \
    gettext \
    git \
    tmux \
    glusterfs-common \
    libaio-dev \
    libattr1-dev \
    libbrlapi-dev \
    libbz2-dev \
    libcacard-dev \
    libcap-ng-dev \
    libcurl4-gnutls-dev \
    libdrm-dev \
    libepoxy-dev \
    libfdt-dev \
    libgbm-dev \
    libgtk-3-dev \
    libibverbs-dev \
    libiscsi-dev \
    libjemalloc-dev \
    libjpeg-turbo8-dev \
    liblttng-ust-dev \
    liblzo2-dev \
    libncurses5 \
    libncurses5-dev \
    libncursesw5-dev \
    libnfs-dev \
    libnss3-dev \
    libnuma-dev \
    libpixman-1-dev \
    librados-dev \
    librbd-dev \
    librdmacm-dev \
    libsasl2-dev \
    libsdl2-dev \
    libseccomp-dev \
    libslirp-dev \
    libsnappy-dev \
    libspice-protocol-dev \
    libspice-server-dev \
    libssh-dev \
    libusb-1.0-0-dev \
    libusbredirhost-dev \
    libvdeplug-dev \
    libvte-2.91-dev \
    libxen-dev \
    libzstd-dev \
    make \
    netcat-openbsd \
    ninja-build \
    python3-numpy \
    python3-opencv \
    python3-pil \
    python3-pip \
    python3-sphinx \
    python3-venv \
    python3-yaml \
    rpm2cpio \
    sparse \
    tesseract-ocr \
    tesseract-ocr-eng \
    xfslibs-dev\
    vim
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
RUN dpkg -l $PACKAGES | sort > /packages.txt
ENV FEATURES clang tsan pyyaml sdl2

# Apply patch https://reviews.llvm.org/D75820
# This is required for TSan in clang-10 to compile with QEMU.
RUN sed -i 's/^const/static const/g' /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h

RUN curl -sJLo- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-x86_64-linux.tar.bz2 | tar jxv -C /usr --strip-components=1
