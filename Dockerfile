FROM docker-dev.yelpcorp.com/lucid_yelp

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        debhelper \
        devscripts \
        build-essential \
        quilt \
        fakeroot \
        wget \
        # for uscan
        libwww-perl \
         libcrypt-ssleay-perl \
        # simplifies the makefile
        sudo \
        # shows me which distro we're building debs for
        lsb-release \
        # I got tired of installing this myself repeatedly
        vim-tiny \
    && apt-get clean

# building s6 requires a quite new GNU make
RUN cd /opt \
    && wget http://ftp.gnu.org/gnu/make/make-4.1.tar.gz -O- | \
	tar xvz \
    && cd make-4.1 \
    && ./configure --prefix /usr \
    && make -j20 \
    && make install \
    && cd / \
    && rm -rf /opt/make-4.1 \
    && true


# allow anyone to do whatever via sudo
RUN echo 'ALL ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /opt/s6-packaging
