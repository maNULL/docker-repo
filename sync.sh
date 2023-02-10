### SYSTEM

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

docker build --file ol9.Dockerfile --tag manull/ol9repo:latest .
docker build --file deb11.Dockerfile --tag manull/deb11repo:latest .

### OracleLinux
docker run --rm -it -v docker_repo:/docker_repo \
	manull/ol9:latest \
        reposync \
            --newest-only \
            --download-metadata \
            --exclude='*.src' \
            --download-path=/docker_repo/OracleLinux/9 \
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
            --repoid=pgdg15 \
            --repoid=zabbix \
            --repoid=zabbix-agent2-plugins \
            --repoid=zabbix-non-supported


### Debian
docker run --rm -it \
    -v $(pwd)/proxmox-offline-mirror.cfg:/etc/proxmox-offline-mirror.cfg \
    -v docker_repo:/docker_repo \
    manull/deb11repo bash
    
# add folder to mirror
mkdir -p /docker_repo/debian/{debian_bullseye_main,debian_bullseye_security,debian_bullseye_updates,debian_bullseye_backports,pve_bullseye_no_subscription,pbs_bullseye_no_subscription,pmg_bullseye_no_subscription}/.pool
mkdir -p /docker_repo/debian/.pool
