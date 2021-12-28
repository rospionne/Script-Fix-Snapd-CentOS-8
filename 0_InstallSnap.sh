#! /bin/bash

#update ref EPEL
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf upgrade

#install snap
yum install snapd
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap

#Fix bug allow
setenforce 0
getenforce
systemctl restart snapd.service snapd.socket
snap refresh
snap version
setenforce 1
ausearch -ts recent --raw | audit2allow -m snapd-selinux
sudo ausearch -ts recent --raw | audit2allow -M snapd-selinux
sudo semodule -i snapd-selinux.pp
getenforce
snap version
