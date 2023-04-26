#!/usr/bin/bash

#update system
apt update && apt upgrade -y

#install opennssh
apt install openssh -y

#edit config port and allow root login [if not root login change comment line 11.]
sed -i 's/#Port 22/Port 10022/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

#add config match group and chroot directory
echo "Match group sftp" >> /etc/ssh/sshd_config
echo "ChrootDirectory /home" >> /etc/ssh/sshd_config
echo "X11Forwarding no" >> /etc/ssh/sshd_config
echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config

#restart service sshd.service
systemctl restart sshd

#add group for sftp [groupname = sftp] and u can use other name.
addgroup sftp

#add user for sftp and add to sftp group.
useradd -m watanyu_c -g sftp

#change password user after add to system.
passwd watanyu_c

#change permission for directory user. 
chmod 700 /home/watanyu_c

##### END of install and config SFTP by OpenSSH. #####
echo "Setup Complete!!! please login sftp by using command 'sftp -P 10022 watanyu_c@Hostname' and Enter password."
echo "Let's Enjoin!!"