#!/bin/bash

## Basic code to start up a EC2 instance.
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello from instance $(hostname -f) " > /var/www/html/index.html
