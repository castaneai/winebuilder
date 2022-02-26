FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends pulseaudio \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY default.pa /etc/pulse/default.pa
CMD ["/usr/bin/pulseaudio", "--exit-idle-time=-1", "--verbose", "--log-target=stderr"]
