FROM docker-dev.yelpcorp.com/lucid_yelp

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        debhelper \
        devscripts \
        build-essential \
        quilt \
        fakeroot \
        wget \
        sudo \
    && apt-get clean


WORKDIR /opt/s6-packaging
