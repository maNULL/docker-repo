FROM oraclelinux:9

LABEL maintainer="John Komarov <komarov.j@gmail.com>"

RUN yum-config-manager --set-enabled ol9_UEKR7 && \
  dnf install -y \
    createrepo \
    oracle-epel-release-el9 \
    https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
  dnf clean all    
