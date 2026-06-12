FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# TARGETARCH is set automatically by BuildKit (amd64 / arm64)
ARG TARGETARCH
ARG LLVM_MINGW_VERSION=20260602

RUN apt-get update -y \
    && apt-get install -y \
    make gcc ccache flex bison pkg-config \
    curl ca-certificates xz-utils software-properties-common \
    libx11-dev libfreetype-dev \
    libxcursor-dev libxi-dev libxext-dev \
    libxrandr-dev \
    libxcomposite-dev libgl-dev \
    libosmesa6-dev libpcap-dev libdbus-1-dev libsane-dev \
    libusb-1.0-0-dev libv4l-dev libgphoto2-dev \
    liblcms2-dev libpulse-dev libgstreamer-plugins-base1.0-dev \
    libudev-dev libsdl2-dev libfaudio-dev \
    libcapi20-dev libcups2-dev libfontconfig-dev \
    libgsm1-dev libkrb5-dev libjxr-dev \
    libmpg123-dev libvulkan-dev \
    libvkd3d-dev libldap-dev \
    libxml2-dev libxslt1-dev libgnutls28-dev \
    gettext

# Cross toolchains for PE modules
# - arm64: llvm-mingw (clang-based). GCC mingw cannot produce arm64ec objects,
#          so llvm-mingw is required. It also provides i686/x86_64 compilers.
# - amd64: gcc-mingw-w64 (x86_64 / i386)
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        curl -L "https://github.com/mstorsjo/llvm-mingw/releases/download/${LLVM_MINGW_VERSION}/llvm-mingw-${LLVM_MINGW_VERSION}-ucrt-ubuntu-22.04-aarch64.tar.xz" \
            | tar -xJ -C /opt \
        && ln -s "/opt/llvm-mingw-${LLVM_MINGW_VERSION}-ucrt-ubuntu-22.04-aarch64" /opt/llvm-mingw; \
    else \
        apt-get install -y gcc-mingw-w64; \
    fi
ENV PATH="/opt/llvm-mingw/bin:${PATH}"

# FEX provides the x86 / x86-64 emulation backend DLLs for Wine on ARM64:
#   libwow64fex.dll   -> xtajit.dll   (32bit x86)
#   libarm64ecfex.dll -> xtajit64.dll (x86-64 via ARM64EC)
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        add-apt-repository -y ppa:fex-emu/fex \
        && apt-get update -y \
        && apt-get install -y fex-emu-wine; \
    fi

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends wget locales tzdata \
    && wget -O /usr/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
    && chmod +x /usr/bin/winetricks
RUN locale-gen ja_JP.UTF-8

RUN apt-get update -y \
    && apt-get install -y gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav
