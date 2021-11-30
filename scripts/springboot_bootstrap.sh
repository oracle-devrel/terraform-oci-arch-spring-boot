#!/bin/bash

# Install Java JDK and prepare for SpringBoot/Tomcat
yum install -y java-1.8.0-openjdk
setsebool -P tomcat_can_network_connect_db 1

# MySQL Shell
yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y mysql-shell

rm -rf /tmp/create_db.sql
echo 'create database ocidb;' | sudo tee -a /tmp/create_db.sql
echo 'use ocidb;' | sudo tee -a /tmp/create_db.sql
echo 'GRANT ALL ON ocidb.* TO admin@"%";' | sudo tee -a /tmp/create_db.sql
mysqlsh --user ${db_user_name} --password=${db_user_password} --host ${db_server_ip_address} --file /tmp/create_db.sql --sqlc
rm -rf /tmp/query_db.sql
echo 'use ocidb;' | sudo tee -a /tmp/query_db.sql
echo 'select * from customer;' | sudo tee -a /tmp/query_db.sql
mysqlsh --user ${db_user_name} --password=${db_user_password} --host ${db_server_ip_address} --file /tmp/query_db.sql --sqlc

# Download ocispringbootdemo
wget -O /home/opc/ocispringbootdemo-0.0.1-SNAPSHOT.jar ${springboot_download_url}
chown opc:opc /home/opc/ocispringbootdemo-0.0.1-SNAPSHOT.jar

# Adding SpringBoot as systemd service
cp /home/opc/springboot.service /etc/systemd/system/
chown root:root /etc/systemd/system/springboot.service
cat /etc/systemd/system/springboot.service
systemctl daemon-reload
systemctl enable springboot
systemctl start springboot
sleep 20
ps -ef | grep springboot
systemctl status springboot --no-pager

# Stop and disable firewalld 
service firewalld stop
systemctl disable firewalld