FROM oraclelinux:9

LABEL maintainer="John Komarov <komarov.j@gmail.com>"

RUN yum-config-manager --set-enabled ol9_UEKR7 && \
  dnf install -y \
    createrepo \
    oracle-epel-release-el9 \
    https://rpms.remirepo.net/enterprise/remi-release-9.rpm  \
    https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm \
    https://repo.zabbix.com/zabbix/6.2/rhel/9/x86_64/zabbix-release-6.2-3.el9.noarch.rpm && \
  dnf clean all    
