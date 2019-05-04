FROM debian:stretch-slim
LABEL maintainer="Martin Smola"

# Install dependencies.
RUN apt-get update \
    && apt-get -y full-upgrade \
    && apt-get install -y --no-install-recommends \
       sudo systemd \
       build-essential libffi-dev libssl-dev \
       python-pip python-dev python-setuptools python-wheel \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
