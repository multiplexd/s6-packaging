REVISION := 1
ARCH := $(shell dpkg --print-architecture)

skalibs_version := 2.4.0.2
s6_version := 2.4.0.0
execline_version := 2.2.0.0
s6-rc_version := 0.1.0.0
s6-portable-utils_version := 2.1.0.0

skalibs_revision := $(REVISION)
s6_revision := $(REVISION)
execline_revision := $(REVISION)
s6-rc_revision := $(REVISION)
s6-portable-utils_revision := $(REVISION)

skalibs_debs = $(addsuffix _$(skalibs_version)-$(skalibs_revision)_$(ARCH).deb,skalibs skalibs-dev)
execline_debs = $(addsuffix _$(execline_version)-$(execline_revision)_$(ARCH).deb,execline execline-dev)
s6_debs = $(addsuffix _$(s6_version)-$(s6_revision)_$(ARCH).deb,s6 s6-dev)
s6-rc_debs = $(addsuffix _$(s6-rc_version)-$(s6-rc_revision)_$(ARCH).deb,s6-rc s6-rc-dev)
s6-portable-utils_debs = $(addsuffix _$(s6-portable-utils_version)-$(s6-portable-utils_revision)_$(ARCH).deb,s6-portable-utils s6-portable-utils-dev)

skalibs: $(skalibs_debs)
execline: $(execline_debs)
s6: $(s6_debs)
s6-rc: $(s6-rc_debs)
s6-portable-utils: $(s6-portable-utils_debs)

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
$(s6-portable-utils_debs):
	./bin/makedebs s6-portable-utils $(s6-portable-utils_version) $(s6-portable-utils_revision)


install: skalibs-install execline-install s6-install s6-rc-install s6-portable-utils-install

skalibs-install: skalibs
	sudo dpkg -i $(skalibs_debs)
execline-install: execline
	sudo dpkg -i $(execline_debs)
s6-install: s6
	sudo dpkg -i $(s6_debs)
s6-rc-install: s6-rc
	sudo dpkg -i $(s6-rc_debs)
s6-portable-utils-install:
	sudo dpkg -i $(s6-portable-utils_debs)
