FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get install -y \
        x11-xserver-utils \
        xserver-xorg-video-dummy \
        x11vnc \
        dbus-x11 \
        libxrandr-dev \
        pciutils && \
    rm -rf /var/lib/apt/lists/

RUN apt-get remove -y libnss-systemd

ENV DISPLAY :0

COPY xorg.conf /etc/X11/
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
