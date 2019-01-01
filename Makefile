
SNAP_VERSION=0.0.01

DESTDIR ?= /usr

build:
	docker build -f Dockerfile -t eyedeekay/whobrowser .
	make copy-snap

copy-snap:
	docker run -i -t -d --name snapbuild eyedeekay/whobrowser
	sleep 15
	docker cp snapbuild:/home/snap/snap/whobrowser_$(SNAP_VERSION)_amd64.snap whobrowser_$(SNAP_VERSION)_amd64.snap
	docker rm -f snapbuild

install-deb:
	apt-get install -y ./*.deb

GENMKFILE_PATH ?= $(DESTDIR)/share/genmkfile
GENMKFILE_ROOT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

export GENMKFILE_PATH
export GENMKFILE_ROOT_DIR

include $(GENMKFILE_PATH)/makefile-full

install-fix:
	echo '#! /bin/sh' > $(DESTDIR)/bin/makefix
	echo "sed -i 's|/usr/share/genmkfile|$$DESTDIR/share/genmkfile|g' Makefile" >> $(DESTDIR)/bin/makefix
	chmod +x $(DESTDIR)/bin/makefix
