FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && dpkg --add-architecture i386 \
    && apt-get update -y \
	&& apt-get install -y \
    make gcc ccache gcc-multilib flex bison gcc-mingw-w64 pkg-config \
    libx11-dev:* libfreetype-dev:* \
    libxcursor-dev:* libxi-dev:* libxext-dev:* \
    libxxf86vm-dev:* libxrandr-dev:* libxinerama-dev:* \
    libxcomposite-dev:* libgl1-mesa-glx:* libgl1-mesa-dri:* \
    libosmesa6-dev:* libpcap-dev:* libdbus-1-dev:* libsane-dev:* \
    libusb-1.0-0-dev:* libv4l-dev:* libgphoto2-dev:* \
    liblcms2-dev:* libpulse-dev:* libgstreamer-plugins-base1.0-dev:* \
    libudev-dev:* libsdl2-dev:* libfaudio-dev:* \
    libcapi20-dev:* libcups2-dev:* libfontconfig-dev:* \
    libgsm1-dev:* libkrb5-dev:* libjxr-dev:* \
    libmpg123-dev:* libvulkan-dev:* \
    libvkd3d-dev:* libldap2-dev:* \
    libxml2-dev:* libxslt1-dev:* libgnutls28-dev:* \
    oss4-dev gettext

RUN apt-get update -y \
	&& apt-get install -y --no-install-recommends wget locales tzdata \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN wget http://winetricks.org/winetricks \
	&& chmod +x winetricks \
	&& mv winetricks /usr/bin/winetricks
RUN locale-gen ja_JP.UTF-8

RUN apt-get update -y \
    && apt-get install -y gstreamer1.0-plugins-base:* gstreamer1.0-plugins-good:* gstreamer1.0-plugins-bad:* gstreamer1.0-plugins-ugly:* gstreamer1.0-libav:*
