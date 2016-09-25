# Unofficial s6 Debian packaging

This repository contains infrastructure to package s6 and other skarnet 
software for Debian.

## Current packages

This is the skarnet software which is currently packaged in this 
repository:

* skalibs 2.3.10.0
* execline 2.1.5.0
* s6 2.3.0.0
* s6-rc 0.0.3.0

## Build instructions

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
execline and execline-dev packages.
