FROM ubuntu:lucid

## I currently support ubuntu lucid/trusty/vivid and debian jessie/sid.
## of these, ubuntu lucid is the hardest to support

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        debhelper \
        devscripts \
        build-essential \
        quilt \
        fakeroot \
        # for uscan
        libwww-perl \
        libcrypt-ssleay-perl \
        # testing
        autopkgtest \
        piuparts \
        lintian \
        # for getting our make4 source
        wget \
        # simplifies the makefile
        sudo \
        # shows me which distro we're building debs for
        lsb-release \
        # I got tired of installing this myself repeatedly
        vim-tiny \
    && apt-get clean

# building s6 requires a quite new GNU make
ADD make-4.1 /opt/make
WORKDIR /opt/make
RUN ./configure && make -j20

# allow anyone to do whatever via sudo
RUN echo 'ALL ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /opt/s6-packaging
