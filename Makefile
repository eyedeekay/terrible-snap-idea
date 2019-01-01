
VERSION=0.0.01

build:
	docker build -f Dockerfile -t eyedeekay/whobrowser .
	make copy-snap

copy-snap:
	docker run -i -t -d --name snapbuild eyedeekay/whobrowser
	sleep 15
	docker cp snapbuild:/home/snap/snap/whobrowser_$(VERSION)_amd64.snap whobrowser_$(VERSION)_amd64.snap
	docker rm -f snapbuild

install:
	apt-get install -y ./*.deb
