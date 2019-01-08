
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

install:
	apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
	echo "deb http://deb.whonix.org stretch main" | tee /etc/apt/sources.list.d/whonix.list
	#apt-key --keyring /etc/apt/trusted.gpg.d/sid.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 7638D0442B90D010
	#echo "deb http://deb.debian.org/debian sid main" | tee /etc/apt/sources.list.d/sid.list
	apt-get update
	adduser user
	apt-get install -y tb-starter tb-updater tb-default-browser open-link-confirmation
