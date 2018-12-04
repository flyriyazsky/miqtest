#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

chkconfig docker on

touch /var/www/html/index.html
echo '<h1> My MIQ app </h1>' > /tmp/riyaz.html

docker run -d --name my-webapp -v /tmp/riyaz.html:/var/www/html/ -p 80:80 httpd
