REVISION := 1
ARCH := $(shell dpkg --print-architecture)

skalibs_version := 2.8.0.0
s6_version := 2.7.2.2
execline_version := 2.5.1.0
s6-rc_version := 0.4.1.0
s6-portable-utils_version := 2.2.1.2
s6-linux-utils_version := 2.5.0.0
s6-linux-init_version := 0.4.0.0
s6-dns_version := 2.3.0.1
s6-networking_version := 2.3.0.3

skalibs_revision := $(REVISION)
s6_revision := $(REVISION)
execline_revision := $(REVISION)
s6-rc_revision := $(REVISION)
s6-portable-utils_revision := $(REVISION)
s6-linux-utils_revision := $(REVISION)
s6-linux-init_revision := $(REVISION)
s6-dns_revision := $(REVISION)
s6-networking_revision := $(REVISION)

skalibs_debs = $(addsuffix _$(skalibs_version)-$(skalibs_revision)_$(ARCH).deb,skalibs skalibs-dev)
execline_debs = $(addsuffix _$(execline_version)-$(execline_revision)_$(ARCH).deb,execline execline-dev)
s6_debs = $(addsuffix _$(s6_version)-$(s6_revision)_$(ARCH).deb,s6 s6-dev)
s6-rc_debs = $(addsuffix _$(s6-rc_version)-$(s6-rc_revision)_$(ARCH).deb,s6-rc s6-rc-dev)
s6-portable-utils_debs = $(addsuffix _$(s6-portable-utils_version)-$(s6-portable-utils_revision)_$(ARCH).deb,s6-portable-utils s6-portable-utils-dev)
s6-linux-utils_debs = $(addsuffix _$(s6-linux-utils_version)-$(s6-linux-utils_revision)_$(ARCH).deb,s6-linux-utils s6-linux-utils-dev)
s6-linux-init_debs = $(addsuffix _$(s6-linux-init_version)-$(s6-linux-init_revision)_$(ARCH).deb,s6-linux-init s6-linux-init-dev)
s6-dns_debs = $(addsuffix _$(s6-dns_version)-$(s6-dns_revision)_$(ARCH).deb,s6-dns s6-dns-dev)
s6-networking_debs = $(addsuffix _$(s6-networking_version)-$(s6-networking_revision)_$(ARCH).deb,s6-networking s6-networking-dev)

skalibs: $(skalibs_debs)
execline: $(execline_debs)
s6: $(s6_debs)
s6-rc: $(s6-rc_debs)
s6-portable-utils: $(s6-portable-utils_debs)
s6-linux-utils: $(s6-linux-utils_debs)
s6-linux-init: $(s6-linux-init_debs)
s6-dns: $(s6-dns_debs)
s6-networking: $(s6-networking_debs)

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
$(s6-linux-utils_debs):
	./bin/makedebs s6-linux-utils $(s6-linux-utils_version) $(s6-linux-utils_revision)
$(s6-linux-init_debs):
	./bin/makedebs s6-linux-init $(s6-linux-init_version) $(s6-linux-init_revision)
$(s6-dns_debs):
	./bin/makedebs s6-dns $(s6-dns_version) $(s6-dns_revision)
$(s6-networking_debs):
	./bin/makedebs s6-networking $(s6-networking_version) $(s6-networking_revision)


install: skalibs-install execline-install s6-install s6-rc-install s6-portable-utils-install s6-linux-utils-install s6-linux-init-install s6-dns-install s6-networking-install

skalibs-install: skalibs
	sudo dpkg -i $(skalibs_debs)
execline-install: execline
	sudo dpkg -i $(execline_debs)
s6-install: s6
	sudo dpkg -i $(s6_debs)
s6-rc-install: s6-rc
	sudo dpkg -i $(s6-rc_debs)
s6-portable-utils-install: s6-portable-utils
	sudo dpkg -i $(s6-portable-utils_debs)
s6-linux-utils-install: s6-linux-utils
	sudo dpkg -i $(s6-linux-utils_debs)
s6-linux-init-install: s6-linux-init
	sudo dpkg -i $(s6-linux-init_debs)
s6-dns-install: s6-dns
	sudo dpkg -i $(s6-dns_debs)
s6-networking-install: s6-networking
	sudo dpkg -i $(s6-networking_debs)
