FROM debian

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        debhelper \
        devscripts \
        build-essential \
        quilt \
        fakeroot \
        wget \
        sudo \
        lsb-release \
        vim-tiny \
    && apt-get clean

# building s6 requires a quite new GNU make
ADD make-4.1 /opt/make
WORKDIR /opt/make
RUN ./configure && make -j20 && make install

# allow anyone to do whatever via sudo
RUN echo 'ALL ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV DEB_BUILD_OPTIONS=parallel=20
WORKDIR /opt/s6-packaging
