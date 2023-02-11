#### Подготовка системы
```bash
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

docker volume create \
    --driver=local \
    --opt type=ext4 \
    --opt device=/dev/disk/by-uuid/3a56790c-2373-4a93-915e-8a568bbe3fe4 \
    docker_repo

docker build --file ol9.Dockerfile --tag manull/ol9repo:latest .
docker build --file deb11.Dockerfile --tag manull/deb11repo:latest .
```

#### OracleLinux
```bash
docker run --rm -it -v docker_repo:/docker_repo \
	manull/ol9repo:latest \
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
```

#### Debian

```bash
docker run --rm -it \
    -v $(pwd)/proxmox-offline-mirror.cfg:/etc/proxmox-offline-mirror.cfg \
    -v docker_repo:/docker_repo \
    manull/deb11repo bash
```    
##### Конфигурация зеркалирования
```bash
proxmox-offline-mirror config mirror add \
    --id debian_bullseye_main \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /usr/share/keyrings/debian-archive-bullseye-automatic.gpg \
	--repository 'deb http://deb.debian.org/debian bullseye main contrib' \
	--skip-sections cli-mono \
	--skip-sections comm \
	--skip-sections debian-installer \
	--skip-sections debug \
	--skip-sections education \
	--skip-sections electronics \
	--skip-sections embedded \
	--skip-sections games \
	--skip-sections gnome \
	--skip-sections gnu-r \
	--skip-sections gnustep \
	--skip-sections graphics \
	--skip-sections hamradio \
	--skip-sections haskell \
	--skip-sections introspection \
	--skip-sections javascript \
	--skip-sections kde \
	--skip-sections libdevel \
	--skip-sections lisp \
	--skip-sections mail \
	--skip-sections math \
	--skip-sections metapackages \
	--skip-sections news \
	--skip-sections ocaml \
	--skip-sections oldlibs \
	--skip-sections otherosfs \
	--skip-sections science \
	--skip-sections sound \
	--skip-sections tasks \
	--skip-sections tex \
	--skip-sections text \
	--skip-sections video \
	--skip-sections x11 \
	--skip-sections xfce \
	--skip-sections zope \
	--sync true \
	--verify true

proxmox-offline-mirror config mirror add \
    --id debian_bullseye_backports \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /usr/share/keyrings/debian-archive-bullseye-automatic.gpg \
	--repository 'deb http://deb.debian.org/debian bullseye-backports main contrib' \
	--skip-sections cli-mono \
	--skip-sections comm \
	--skip-sections debian-installer \
	--skip-sections debug \
	--skip-sections education \
	--skip-sections electronics \
	--skip-sections embedded \
	--skip-sections games \
	--skip-sections gnome \
	--skip-sections gnu-r \
	--skip-sections gnustep \
	--skip-sections graphics \
	--skip-sections hamradio \
	--skip-sections haskell \
	--skip-sections introspection \
	--skip-sections javascript \
	--skip-sections kde \
	--skip-sections libdevel \
	--skip-sections lisp \
	--skip-sections mail \
	--skip-sections math \
	--skip-sections metapackages \
	--skip-sections news \
	--skip-sections ocaml \
	--skip-sections oldlibs \
	--skip-sections otherosfs \
	--skip-sections science \
	--skip-sections sound \
	--skip-sections tasks \
	--skip-sections tex \
	--skip-sections text \
	--skip-sections video \
	--skip-sections x11 \
	--skip-sections xfce \
	--skip-sections zope \
	--sync true \
	--verify true

proxmox-offline-mirror config mirror add \
    --id debian_bullseye_security \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /usr/share/keyrings/debian-archive-bullseye-security-automatic.gpg \
	--repository 'deb http://deb.debian.org/debian-security bullseye-security main contrib' \
	--skip-sections cli-mono \
	--skip-sections comm \
	--skip-sections debian-installer \
	--skip-sections debug \
	--skip-sections education \
	--skip-sections electronics \
	--skip-sections embedded \
	--skip-sections games \
	--skip-sections gnome \
	--skip-sections gnu-r \
	--skip-sections gnustep \
	--skip-sections graphics \
	--skip-sections hamradio \
	--skip-sections haskell \
	--skip-sections introspection \
	--skip-sections javascript \
	--skip-sections kde \
	--skip-sections libdevel \
	--skip-sections lisp \
	--skip-sections mail \
	--skip-sections math \
	--skip-sections metapackages \
	--skip-sections news \
	--skip-sections ocaml \
	--skip-sections oldlibs \
	--skip-sections otherosfs \
	--skip-sections science \
	--skip-sections sound \
	--skip-sections tasks \
	--skip-sections tex \
	--skip-sections text \
	--skip-sections video \
	--skip-sections x11 \
	--skip-sections xfce \
	--skip-sections zope \
	--sync true \
	--verify true

proxmox-offline-mirror config mirror add \
    --id debian_bullseye_updates \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /usr/share/keyrings/debian-archive-bullseye-automatic.gpg \
	--repository 'deb http://deb.debian.org/debian bullseye-updates main contrib' \
	--skip-sections cli-mono \
	--skip-sections comm \
	--skip-sections debian-installer \
	--skip-sections debug \
	--skip-sections education \
	--skip-sections electronics \
	--skip-sections embedded \
	--skip-sections games \
	--skip-sections gnome \
	--skip-sections gnu-r \
	--skip-sections gnustep \
	--skip-sections graphics \
	--skip-sections hamradio \
	--skip-sections haskell \
	--skip-sections introspection \
	--skip-sections javascript \
	--skip-sections kde \
	--skip-sections libdevel \
	--skip-sections lisp \
	--skip-sections mail \
	--skip-sections math \
	--skip-sections metapackages \
	--skip-sections news \
	--skip-sections ocaml \
	--skip-sections oldlibs \
	--skip-sections otherosfs \
	--skip-sections science \
	--skip-sections sound \
	--skip-sections tasks \
	--skip-sections tex \
	--skip-sections text \
	--skip-sections video \
	--skip-sections x11 \
	--skip-sections xfce \
	--skip-sections zope \
	--sync true \
	--verify true

proxmox-offline-mirror config mirror add \
    --id pve_bullseye_no_subscription \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg \
	--repository 'deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription' \
	--sync true \
	--verify true

proxmox-offline-mirror config mirror add \
    --id pbs_bullseye_no_subscription \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg \
	--repository 'deb http://download.proxmox.com/debian/pbs bullseye pbs-no-subscription' \
	--sync true \
	--verify true

proxmox-offline-mirror config mirror add \
    --id pmg_bullseye_no_subscription \
	--architectures amd64 \
	--architectures all \
	--base-dir /docker_repo/Debian \
	--ignore-errors false \
	--key-path /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg \
	--repository 'deb http://download.proxmox.com/debian/pmg bullseye pmg-no-subscription' \
	--sync true \
	--verify true

proxmox-offline-mirror config media add \
    --id proxmox-bullseye \
    --mirrors debian_bullseye_main \
    --mirrors debian_bullseye_security \
    --mirrors debian_bullseye_backports \
    --mirrors debian_bullseye_updates \
    --mirrors pve_bullseye_no_subscription \
    --mirrors pbs_bullseye_no_subscription \
    --mirrors pmg_bullseye_no_subscription \
    --sync true \
    --verify true \
    --mountpoint /docker_repo/Debian-media
```

##### Создание снимка репозитория
```bash
proxmox-offline-mirror mirror snapshot create-all
```

##### Создание съемного носителя с репозиторием
```bash
proxmox-offline-mirror medium sync proxmox-bullseye
```
