#!/usr/bin/env bash

dnf -y install dnf-plugins-core
dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
dnf -y install \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	docker-compose-plugin

systemctl enable --now docker.service

docker volume create --driver=local --opt type=ext4 --opt device=/dev/disk/by-uuid/3a56790c-2373-4a93-915e-8a568bbe3fe4 docker_repo

docker build --file ol9.Dockerfile --tag manull/ol9:latest .

reposync \
    --newest-only \
    --download-metadata \
    --exclude='*.src' \
    --download-path=/docker_repo \
    --repoid=ol9_baseos_latest \
    --repoid=ol9_appstream \
    --repoid=ol9_UEKR7 \
    --repoid=ol9_developer_EPEL \
    --repoid=remi-modular \
    --repoid=remi-safe \
    --repoid=pgdg-common \
    --repoid=pgdg11 \
    --repoid=pgdg12 \
    --repoid=pgdg13 \
    --repoid=pgdg14 \
    --repoid=pgdg15



