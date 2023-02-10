FROM debian:11

LABEL maintainer="John Komarov <komarov.j@gmail.com>"

RUN apt update && \
  apt install -y wget

RUN wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg \
  -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg && \
  echo "deb http://download.proxmox.com/debian/pbs-client bullseye main" > /etc/apt/sources.list.d/pbs-client.list

RUN apt update && \
  apt install -y proxmox-offline-mirror