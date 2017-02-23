FROM debian:stretch-slim
MAINTAINER Ed Robinson<ed@a10e.org>

COPY bin/* /usr/local/bin/
COPY fluent.conf /etc/fluent/fluent.conf
RUN setup

WORKDIR /home/fluent
ENV LD_PRELOAD=/usr/lib/libjemalloc.so.2 \
    BUNDLE_SILENCE_ROOT_WARNING=1
