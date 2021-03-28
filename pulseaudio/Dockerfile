FROM ubuntu:20.10

# Use GCE apt servers
ARG GCE_ZONE=asia-northeast1
RUN cp /etc/apt/sources.list /etc/apt/sources.list.orig && \
    sed -i "s/archive.ubuntu.com/${GCE_ZONE}.gce.archive.ubuntu.com/g" /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends pulseaudio \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY default.pa /etc/pulse/default.pa
CMD ["/usr/bin/pulseaudio", "--exit-idle-time=-1", "--verbose", "--log-target=stderr"]