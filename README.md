# Script-Fix-Snapd-CentOS-8
Script fix bug allow of Snapd 2.53.4 on CentOS 8


For exec script :

admin@centos# sudo chmod +x 0_InstallSnap.sh

admin@centos# sudo ./0_InstallSnap.sh



-----##Code source : ##---------

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


#Source : https://forum.snapcraft.io/t/snapd-unavailable-red-hat-enterprise-linux/28004/11
