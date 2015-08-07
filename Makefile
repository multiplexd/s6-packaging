REVISION := 1
ARCH := $(shell dpkg --print-architecture)

skalibs_version := 2.2.0.0
s6_version := 2.0.1.0
execline_version := 2.0.1.1

skalibs_revision := $(REVISION)
s6_revision := $(REVISION)
execline_revision := $(REVISION)

skalibs_debs = $(addsuffix _$(skalibs_version)-$(skalibs_revision)_$(ARCH).deb,skalibs skalibs-dev)
execline_debs = $(addsuffix _$(execline_version)-$(execline_revision)_$(ARCH).deb,execline execline-dev)
s6_debs = $(addsuffix _$(s6_version)-$(s6_revision)_$(ARCH).deb,s6 s6-dev)

skalibs: $(skalibs_debs)

execline: $(execline_debs)

s6: $(s6_debs)

clean: 
	git clean -fdx

$(skalibs_debs): skalibs_$(skalibs_version).orig.tar.gz
	tar xzf skalibs_$(skalibs_version).orig.tar.gz
	cd skalibs-$(skalibs_version) && \
		debuild -uc -us
	echo $(skalibs_debs) | xargs -n1 | xargs --replace sh -c 'dpkg -I {}; dpkg -c {}'

skalibs_$(skalibs_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/skalibs/skalibs-$(skalibs_version).tar.gz

$(execline_debs): execline_$(execline_version).orig.tar.gz
	tar xzf execline_$(execline_version).orig.tar.gz
	cd execline-$(execline_version) && \
		debuild -uc -us
	echo $(execline_debs) | xargs -n1 | xargs --replace sh -c 'dpkg -I {}; dpkg -c {}'

execline_$(execline_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/execline/execline-$(execline_version).tar.gz

$(s6_debs): s6_$(s6_version).orig.tar.gz
	tar xzf s6_$(s6_version).orig.tar.gz
	cd s6-$(s6_version) && \
		debuild -uc -us
	echo $(s6_debs) | xargs -n1 | xargs --replace sh -c 'dpkg -I {}; dpkg -c {}'

s6_$(s6_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/s6/s6-$(s6_version).tar.gz


install: skalibs-install execline-install s6-install

skalibs-install: skalibs
	dpkg -i $(skalibs_debs)
execline-install: execline
	dpkg -i $(execline_debs)
s6-install: s6
	dpkg -i $(s6_debs)

dockerimage:
	docker build -t $(USER):s6-packaging .
	docker run $(USER):s6-packaging lsb_release -a

DOCKER=docker run \
    -e USER_ID=$(shell id -u) -e GROUP_ID=$(shell id -g) \
    -v $(PWD):/opt/s6-packaging \
    -ti $(USER):s6-packaging

dockerbuild: dockerimage
	$(DOCKER) make dockerbuild-inner

dockerinteractive: dockerimage
	$(DOCKER) bash -l

s6-user:
	useradd -u $(USER_ID) -g $(GROUP_ID) -d /opt/s6-packaging s6-user

dockerbuild-inner: s6-user
	su s6-user -c 'make skalibs'
	make skalibs-install
	su s6-user -c 'make execline'
	make execline-install
	su s6-user -c 'make s6'
	make s6-install
