FROM ubuntu:20.10

ARG GCE_ZONE=asia-northeast1
RUN cp /etc/apt/sources.list /etc/apt/sources.list.orig && \
    sed -i "s/archive.ubuntu.com/${GCE_ZONE}.gce.archive.ubuntu.com/g" /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && apt install -y \
        x11-xserver-utils \
        xserver-xorg-video-dummy \
        x11vnc \
        dbus-x11 \
        libxrandr-dev \
        pciutils && \
    rm -rf /var/lib/apt/lists/

RUN apt remove -y libnss-systemd

ENV DISPLAY :0

COPY xorg.conf /etc/X11/
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
