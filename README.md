# Unofficial s6 Debian packaging

This repository contains infrastructure to package s6 and other skarnet 
software for Debian.

## Current packages

This is the skarnet software which is currently packaged in this 
repository:

* skalibs 2.4.0.2
* execline 2.2.0.0
* s6 2.4.0.0
* s6-rc 0.1.0.0
* s6-portable-utils 2.1.0.0
* s6-linux-utils 2.2.0.0
* s6-linux-init 0.2.0.0

## Build instructions

The _devscripts_, _quilt_ and _debhelper_ packages are required by the build
infrastructure to build the packages. 

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
s6, s6-portable-utils and s6-linux-utils.

## Disclaimer

I have little experience with the Debian packaging system, so a lot of the work
I have done here is merely extending the infrastructure implemented by 
pervious maintainers.
