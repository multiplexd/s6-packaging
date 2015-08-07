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
	cd skalibs && \
		tar xzf ../skalibs_$(skalibs_version).orig.tar.gz --strip-components=1 && \
		rm -rf .pc && \
		debuild -uc -us
	echo $(skalibs_debs) | xargs -n1 | xargs --replace sh -c 'dpkg -I {}; dpkg -c {}'

skalibs_$(skalibs_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/skalibs/skalibs-$(skalibs_version).tar.gz

$(execline_debs): execline_$(execline_version).orig.tar.gz
	cd execline && \
		tar xzf ../execline_$(execline_version).orig.tar.gz --strip-components=1 && \
		rm -rf .pc && \
		debuild -uc -us
	echo $(execline_debs) | xargs -n1 | xargs --replace sh -c 'dpkg -I {}; dpkg -c {}'

execline_$(execline_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/execline/execline-$(execline_version).tar.gz

$(s6_debs): s6_$(s6_version).orig.tar.gz
	cd s6 && \
		tar xzf ../s6_$(s6_version).orig.tar.gz --strip-components=1 && \
		rm -rf .pc && \
		debuild -uc -us
	echo $(s6_debs) | xargs -n1 | xargs --replace sh -c 'dpkg -I {}; dpkg -c {}'

s6_$(s6_version).orig.tar.gz:
	wget -O$@ http://skarnet.org/software/s6/s6-$(s6_version).tar.gz


install: skalibs-install execline-install s6-install

skalibs-install: skalibs
	sudo dpkg -i $(skalibs_debs)
execline-install: execline
	sudo dpkg -i $(execline_debs)
s6-install: s6
	sudo dpkg -i $(s6_debs)


### dockerization-specific rules ###
DOCKER_VERSION?=$(USER)/$(s6_version)
DOCKER_TAG?=s6-packaging:$(DOCKER_VERSION)
export CMD

docker-debs:
	make docker-shell CMD='make install'
docker-shell: docker-image
	docker run \
	    -e USER_ID=$(shell id -u) \
	    -e GROUP_ID=$(shell id -g) \
	    -e CMD \
	    -v $(PWD):/opt/s6-packaging \
	    -ti $(DOCKER_TAG) \
	    make docker-shell-inner
docker-shell-inner:
	groupadd -g $(GROUP_ID) s6-user
	useradd \
	    -u $(USER_ID) \
	    -g $(GROUP_ID) \
	    -d /opt/s6-packaging \
	    -s /bin/bash \
	    s6-user
	sudo -iu s6-user $(CMD)

docker-image:
	docker build -t $(DOCKER_TAG) .
	docker run $(DOCKER_TAG) lsb_release -a
