REVISION := 1
ARCH := $(shell dpkg --print-architecture)

skalibs_version := 2.4.0.0
s6_version := 2.4.0.0
execline_version := 2.2.0.0
s6-rc_version := 0.1.0.0

skalibs_revision := $(REVISION)
s6_revision := $(REVISION)
execline_revision := $(REVISION)
s6-rc_revision := $(REVISION)

skalibs_debs = $(addsuffix _$(skalibs_version)-$(skalibs_revision)_$(ARCH).deb,skalibs skalibs-dev)
execline_debs = $(addsuffix _$(execline_version)-$(execline_revision)_$(ARCH).deb,execline execline-dev)
s6_debs = $(addsuffix _$(s6_version)-$(s6_revision)_$(ARCH).deb,s6 s6-dev)
s6-rc_debs = $(addsuffix _$(s6-rc_version)-$(s6-rc_revision)_$(ARCH).deb,s6-rc s6-rc-dev)

skalibs: $(skalibs_debs)
execline: $(execline_debs)
s6: $(s6_debs)
s6-rc: $(s6-rc_debs)

clean: 
	git clean -fdx

$(skalibs_debs):
	./bin/makedebs skalibs $(skalibs_version) $(skalibs_revision)
$(execline_debs):
	./bin/makedebs execline $(execline_version) $(execline_revision)
$(s6_debs):
	./bin/makedebs s6 $(s6_version) $(s6_revision)
$(s6-rc_debs):
	./bin/makedebs s6-rc $(s6-rc_version) $(s6-rc_revision)


install: skalibs-install execline-install s6-install s6-rc-install

skalibs-install: skalibs
	sudo dpkg -i $(skalibs_debs)
execline-install: execline
	sudo dpkg -i $(execline_debs)
s6-install: s6
	sudo dpkg -i $(s6_debs)
s6-rc-install: s6-rc
	sudo dpkg -i $(s6_debs)


### dockerization-specific rules ###
DOCKER_INTERACTIVE:=$(shell tty -s && echo -it)
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
	    $(DOCKER_INTERACTIVE) \
	    $(DOCKER_TAG) \
	    make docker-shell-inner
docker-shell-inner:
	groupadd --force -g $(GROUP_ID) s6-user
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
