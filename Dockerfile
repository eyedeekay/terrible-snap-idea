FROM ubuntu:18.04
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install snapcraft* -y
RUN adduser --home /home/snap --disabled-password --gecos 'snap,snap,snap,snap,snap' snap
COPY . /home/snap/snap
WORKDIR /home/snap/snap
RUN chown snap:snap -R /home/snap/snap
RUN snapcraft
CMD tail -f snapcraft.yaml
