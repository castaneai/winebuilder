FROM ubuntu:20.10

# Use GCE apt servers
ARG GCE_ZONE=asia-northeast1
RUN cp /etc/apt/sources.list /etc/apt/sources.list.orig && \
    sed -i "s/archive.ubuntu.com/${GCE_ZONE}.gce.archive.ubuntu.com/g" /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
    && dpkg --add-architecture i386 \
	&& apt-get install -y \
    make gcc gcc-multilib flex bison gcc-mingw-w64 pkg-config \
    libx11-dev:i386 libfreetype6-dev:i386 libfreetype-dev:i386 \
    libxcursor-dev:i386 libxi-dev:i386 libxext-dev:i386

WORKDIR /wine
