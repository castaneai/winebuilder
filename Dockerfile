FROM ubuntu:20.10

# Use GCE apt servers
ARG GCE_ZONE=asia-northeast1
RUN cp /etc/apt/sources.list /etc/apt/sources.list.orig && \
    sed -i "s/archive.ubuntu.com/${GCE_ZONE}.gce.archive.ubuntu.com/g" /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && dpkg --add-architecture i386 \
    && apt-get update -y \
	&& apt-get install -y \
    make gcc ccache gcc-multilib flex bison gcc-mingw-w64 pkg-config \
    libx11-dev:i386 libfreetype6-dev:i386 libfreetype-dev:i386 \
    libxcursor-dev:i386 libxi-dev:i386 libxext-dev:i386 \
    libxxf86vm-dev:i386 libxrandr-dev:i386 libxinerama-dev:i386 \
    libxcomposite-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dri:i386 \
    libosmesa6-dev:i386 libpcap-dev:i386 libdbus-1-dev:i386 libsane-dev:i386 \
    libusb-1.0-0-dev:i386 libv4l-dev:i386 libgphoto2-dev:i386 \
    liblcms2-dev:i386 libpulse-dev:i386 libgstreamer-plugins-base1.0-dev:i386 \
    oss4-dev libudev-dev:i386 libsdl2-dev:i386 libfaudio-dev:i386 \
    libcapi20-dev:i386 libcups2-dev:i386 libfontconfig-dev:i386 \
    libgsm1-dev:i386 libkrb5-dev:i386 libjxr-dev \
    libmpg123-dev:i386 libopenal-dev:i386 libvulkan-dev:i386 \
    libvkd3d-dev:i386 libldap2-dev:i386 \
    gettext libxml2-dev:i386 libxslt1-dev:i386 libgnutls28-dev:i386


WORKDIR /wine
