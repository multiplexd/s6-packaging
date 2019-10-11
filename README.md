# Unofficial s6 Debian packaging

This repository contains infrastructure to package s6 and other
[skarnet.org](https://skarnet.org) software for Debian.

**WARNING**: This repository's packaging is no longer updated, and has been
deprecated in favour of the packaging provided in the
[s6-debs](https://github.com/s6-debs/s6-debs) meta-repository.

## Current packages

This is the skarnet software which is currently packaged in this 
repository:

* skalibs 2.8.1.0
* execline 2.5.1.0
* s6 2.8.0.1
* s6-rc 0.5.0.0
* s6-portable-utils 2.2.1.3
* s6-linux-utils 2.5.0.1
* s6-linux-init 1.0.2.0
* s6-dns 2.3.0.2
* s6-networking 2.3.0.4 (without TLS support)


## Build instructions

The _devscripts_, _quilt_, _debhelper_ and _wget_ packages are required by the
build infrastructure to build the packages.

In order to build any of the packages, issue "make _package\_name_".

For example, to build skalibs (which is required by all the other packages),
issue:

```shell
make skalibs
```

Then install the skalibs and skalibs-dev packages with _dpkg -i_

