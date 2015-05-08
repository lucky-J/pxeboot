#!/bin/bash
#Setup hostname. It's need for inventory
echo "Enter PC inventory number. For example '00000'. U can find it on your PC."
echo -n "Inventory number is:  "
read inv
hostname  $inv
>/etc/hosts
echo "127.0.0.1    localhost" >> /etc/hosts
echo "127.0.1.1    $inv" >> /etc/hosts
echo "# The following lines are desirable for IPv6 capable hosts" >> /etc/hosts
echo "::1     localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "ff02::1 ip6-allnodes" >> /etc/hosts 
echo "ff02::2 ip6-allrouters" >> /etc/hosts 

#make variables for installing
path=/install/
folder=temp
url=http://www.example.com/tftboot/packets/fusioninventory-agent/
file1=fusioninventory-agent
file2=agent.cfg
ext_packets="flashplugin-installer filezilla unrar unace zip rar google-chrome-stable skype ethtool sysstat htop git virtualbox-4.3"

#prepare for package install
apt-get update > /dev/null 2>&1 && apt-get upgrade  > /dev/null 2>&1
cd $path
mkdir $folder
cd  $folder
wget $url$file1  > /dev/null 2>&1
wget $url$file2  > /dev/null 2>&1
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"  > /dev/null 2>&1
sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list'
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -  > /dev/null 2>&1
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -  > /dev/null 2>&1
apt-get update  > /dev/null 2>&1

#installing selected packeges
apt-get -y --force-yes install $file1 $ext_packets  > /dev/null 2>&1
apt-get -f install  > /dev/null 2>&1
dpkg -i virtualbox*  > /dev/null 2>&1
cp $file1  /etc/default/
cp $file2 /etc/fusioninventory/$file2
rm -rf  $path/$folder
/etc/init.d/fusioninventory-agent start  > /dev/null 2>&1
fusioninventory-agent -force  > /dev/null 2>&1
