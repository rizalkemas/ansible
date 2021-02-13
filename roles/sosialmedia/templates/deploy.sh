#!/bin/bash

tomcat_base_dir=/sys/workers
java_base_dir=/usr/lib/java
software_location=/home/softwares/

echo "============================>"
echo "Install WebApps"
echo "============================>"
sudo apt-get update
sudo apt-get -qq install mysql-server > /dev/null
sudo apt-get install mysql-client -y
sudo git-config global user.name "Kemas Rizal"
sudo git-config global user.mail kemasrizal59@gmail.com
echo "=============================>"
echo "Downloading Data"
echo "=============================>"
cd
rm -f master.zip
rm -R sosial-media-master
wget https://github.com/sdcilsy/sosial-media/archive/master.zip
echo "=============================>"
echo "Ekstrak File"
echo "=============================>"
sudo apt-get install -y unzip
unzip master.zip
echo "=============================>"
echo "Memindahkan data"
echo "=============================>"
sudo mv sosial-media-master/* /var/www/html/
echo "=============================>"
echo "Konfig DB"
echo "=============================>"
sudo mysql -u root -pfoo123 -e 'CREATE USER "devopscilsy"@"localhost" IDENTIFIED BY "1234567890";'
sudo mysql -u root -pfoo123 -e 'GRANT ALL PRIVILEGES ON *.* TO "devopscilsy"@"localhost";'
sudo mysql -u root -pfoo123 -e 'FLUSH PRIVILEGES;'
cd /etc/mysql/mysql.conf.d
sudo grep "bind-address" /etc/mysql/mysql.conf.d/mysqld.cnf | sudo sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql -u devopscilsy -p1234567890 -e 'create database dbsosmed;'
cd /var/www/html/
sudo mysql -u devopscilsy -p1234567890 dbsosmed < dump.sql
sudo rm -R /var/www/html/index.nginx-debian.html
echo "=============================>"
echo "Restart Service"
echo "=============================>"
sudo systemctl restart nginx
sudo systemctl restart mysql
exit 0
