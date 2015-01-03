# Unofficial s6 Debian packaging

This repository contains infrastructure to package s6 and dependencies
for Debian.

# Build instructions

You need to build and install skalibs in order to build execline and s6.

```shell
make skalibs
ARCH=$(dpkg --print-architecture)
dpkg -i skalibs_2.0.0.0-1_${ARCH}.deb skalibs-dev_2.0.0.0-1_${ARCH}.deb
```

You should now be able to build execline:

```shell
make execline
```

execline is a dependency for s6.

```shell
ARCH=$(dpkg --print-architecture)
dpkg -i execline_2.0.0.0-1_${ARCH}.deb execline-dev_2.0.0.0-1_${ARCH}.deb
```

To build s6:

```shell
make s6
```
