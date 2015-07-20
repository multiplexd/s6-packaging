FROM debian

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        debhelper \
        devscripts \
        build-essential \
        quilt \
        fakeroot \
        wget \
    && apt-get clean
