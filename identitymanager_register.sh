#!/bin/bash
#Rhel IDM Register record.
sunucuadi=$(hostname);

#installation ipa package
yum install ipa-client -y

#register with ipa client
#answer usernanme and password.
ipa-client-install --mkhomedir --server=idmserver.domain.com --domain domain.com --realm DOMAIN.COM --principal=admin --password=PASSWORD --fixed-primary -U --hostname=$sunucuadi

#create automatically user folder
authconfig --enablemkhomedir --update
