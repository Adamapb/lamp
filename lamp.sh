#!/bin/bash
sudo -1
#Enter password
#
#Variables, change as needed
DBNAME=SiteOne
DBUSER=src1
DBPASSWD=12345
#
#Installs reqs and configures for firewall
apt-get update
apt-get upgrade -y
apt install apache2 -y
apt install mysql-server -y
ufw allow in "Apache"
ufw allow in "Apache Full"
apt install php libapache2-mod-php php-mysql 
#For phpBB
#sudo apt install libapache2-mod-php7.4 php7.4-gd php7.4-curl openssl php-imagick php7.4-intl php7.4-json php7.4-ldap php7.4-common php7.4-mbstring php7.4-mysql php7.4-imap php7.4-sqlite3 php-net-ftp php7.4-zip unzip php7.4-pgsql php-ssh2 php7.4-xml
#
#runs mysql and apache on startup
systemctl enable apache2
systemctl enable mysql
#
#php setup
cat > /etc/apache2/mods-enabled/dir.conf <<"__EOF__"
<IfModule mod_dir.c>
	DirectoryIndex index.php index.cgi index.pl index.html index.xhtml index.htm
</IfModule>
# vim syntax=apache ts=4 sw=4 sts=4 sr noet
__EOF__
#
#Configure MySQL
mysql -u root -e "CREATE DATABASE $DBNAME;"
mysql -u root -e "CREATE USER '$DBUSER'@'%' IDENTIFIED BY '$DBPASSWD';"
mysql -u root -e "GRANT ALL ON *.* TO '$DBUSER'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
#
#reload MySQL and Apache
service apache2 restart
service mysql restart
echo "LAMP is set up"
