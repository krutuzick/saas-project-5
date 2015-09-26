#!/usr/bin/env bash

# Update apt-get
apt-get -yqq update
apt-get -yqq install python-software-properties
apt-get -yqq install software-properties-common

add-apt-repository -y ppa:ondrej/php5-5.6
add-apt-repository -y ppa:nginx/stable
echo "deb http://www.rabbitmq.com/debian/ testing main"  | tee /etc/apt/sources.list.d/rabbitmq.list > /dev/null
wget -q http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc

apt-get -yqq update


# Setup timezone and date
timedatectl set-timezone Europe/Moscow
date --set="${1}"


# Install mc
apt-get -yqq install mc


# Install nginx
apt-get -yqq install nginx


# Install mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root123456'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root123456'
apt-get -yqq install mysql-server mysql-client


# Install php 5.6
apt-get -yqq install php5 php5-fpm php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-xsl


# Install rabbitMQ
apt-get -yqq install rabbitmq-server
service rabbitmq-server start
rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart
