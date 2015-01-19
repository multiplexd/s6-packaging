REVISION := 1
ARCH := $(shell dpkg --print-architecture)

skalibs_version := 2.2.0.0
s6_version := 2.0.1.0
execline_version := 2.0.1.1

skalibs_revision := $(REVISION)
s6_revision := $(REVISION)
execline_revision := $(REVISION)

skalibs_debs = $(addsuffix _$(skalibs_version)-$(skalibs_revision)_$(ARCH).deb,skalibs skalibs-dev)
execline_debs = execline_$(execline_version)-$(execline_revision)_$(ARCH).deb
s6_debs = s6_$(s6_version)-$(s6_revision)_$(ARCH).deb

skalibs: $(skalibs_debs)

execline: $(execline_debs)

s6: $(s6_debs)

clean: 
	git clean -fdx

$(skalibs_debs): skalibs_$(skalibs_version).orig.tar.gz
	tar xzf skalibs_$(skalibs_version).orig.tar.gz
	cd skalibs-$(skalibs_version) && \
		debuild -uc -us

skalibs_$(skalibs_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/skalibs/skalibs-$(skalibs_version).tar.gz

$(execline_debs): execline_$(execline_version).orig.tar.gz
	tar xzf execline_$(execline_version).orig.tar.gz
	cd execline-$(execline_version) && \
		debuild -uc -us

execline_$(execline_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/execline/execline-$(execline_version).tar.gz

s6_$(s6_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/s6/s6-$(s6_version).tar.gz

$(s6_debs): s6_$(s6_version).orig.tar.gz
	tar xzf s6_$(s6_version).orig.tar.gz
	cd s6-$(s6_version) && \
		debuild -uc -us

