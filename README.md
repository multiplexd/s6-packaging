# Unofficial s6 Debian packaging

This repository contains infrastructure to package s6 and other skarnet 
software for Debian.

## Current packages

This is the skarnet software which is currently packaged in this 
repository:

* skalibs 2.6.4.0
* execline 2.3.0.4
* s6 2.7.1.1
* s6-rc 0.4.0.0
* s6-portable-utils 2.2.1.1
* s6-linux-utils 2.4.0.1
* s6-linux-init 0.4.0.0
* s6-dns 2.3.0.0
* s6-networking 2.3.0.2 (without TLS support)


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

## Dependencies

All of the skarnet packages depend on skalibs. s6 and s6-rc both require
execline and s6-rc requires s6. This requires the generated -dev packages to 
be installed; for example, compiling s6 requires the skalibs, skalibs-dev,
execline and execline-dev packages. s6-linux-init requires skalibs, execline,
s6, s6-portable-utils and s6-linux-utils. s6-networking requires s6, execline
and s6-dns.

## Disclaimer

I have little experience with the Debian packaging system, so a lot of the work
I have done here is merely extending the infrastructure implemented by 
previous maintainers.
