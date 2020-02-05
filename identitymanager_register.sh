#!/bin/bash
#Rhel IDM Sunucusuna kayit yapar
sunucuadi=$(hostname);

#ipa paketi kurulumu
yum install ipa-client -y

#ipa client ile register
#sorulara yes ve username olarak admin girilir.
ipa-client-install --mkhomedir --server=idmserver.domain.com --domain domain.com --realm DOMAIN.COM --principal=admin --password=PASSWORD --fixed-primary -U --hostname=$sunucuadi

#otomatik user folder'i olusturma
authconfig --enablemkhomedir --update
