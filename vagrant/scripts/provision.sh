#!/usr/bin/env bash

sudo apt -y autoremove
sudo apt-get install -y software-properties-common

sudo apt update -y

sudo apt install -y curl unzip python python-requests python-lxml imagemagick dcraw ffmpeg ffmpeg2theora poppler-utils exiftool libwpd-tools ghostscript libreoffice redis-tools postgresql-client screen apache2 git

sudo apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
sudo apt-get update -y
sudo apt-get install -y openjdk-8-jdk

 
echo "deb http://apt.nuxeo.org/ stretch releases" > /etc/apt/sources.list.d/nuxeo.list
curl http://apt.nuxeo.org/nuxeo.key | apt-key add -

sudo apt update -y

sudo apt install -y ffmpeg-nuxeo

# Fake SMTP 
mkdir /tmp/fakesmtp && \
    unzip -q -d /tmp/fakesmtp /vagrant/packages/fakeSMTP-latest.zip && \
    mv /tmp/fakesmtp/$(/bin/ls -1 /tmp/fakesmtp) /usr/lib/fakeSMTP.jar && \
    rm -rf /tmp/fakesmtp
screen -d -m -S smtp java -jar /usr/lib/fakeSMTP.jar --start-server --background

# configuration Apache2
sudo a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers
printf "\nServerName localhost\n" >> /etc/apache2/apache2.conf
rm -f /etc/apache2/sites-enabled/*
cp /vagrant/config/apache/proxy.conf /etc/apache2/sites-available/proxy.conf
a2ensite proxy.conf
service apache2 restart

# prepare nuxeo
useradd -u 1005 -d /opt/nuxeo -m -s /bin/bash nuxeo
cd /opt/nuxeo
wget https://cdn.nuxeo.com/nuxeo-10.10/nuxeo-server-10.10-tomcat.zip
mkdir deploytmp
pushd deploytmp
unzip -q /opt/nuxeo/nuxeo-server-10.10-tomcat.zip
dist=$(/bin/ls -1 | head -n 1)
mv $dist ../
popd
rm -rf deploytmp
ln -s $dist server
chmod +x server/bin/nuxeoctl
# wizard
echo "nuxeo.wizard.done=true" >> server/bin/nuxeo.conf

server/bin/nuxeoctl mp-init
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-jsf-ui
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-dam
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-drive
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-diff

chown -R nuxeo:nuxeo /opt/nuxeo

# install Nuxeo 
sudo apt install nuxeo

# cp /vagrant/config/nuxeo/nuxeo /etc/init.d/nuxeo
# chmod +x /etc/init.d/nuxeo
# update-rc.d nuxeo defaults
# service nuxeo start


# outils de development
apt-get install -y git maven

cd 
apt-get install -y nodejs

apt-get install -y npm

sudo npm install -g yo

sudo npm install -g yo nuxeo/generator-nuxeo

echo "Finished"


