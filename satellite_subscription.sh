#!/bin/bash
#Suncuyu satellite kaydini yapar ve sistemi gunceller.
echo "##### => Sunucu Kontrol ediliyor"
result=$(subscription-manager status | grep "Overall Status:");

if [[ "$result" == *"Unknown"* ]];then
    echo "##### => Uyelik Durumu Bilinmiyor yada Kayitli Degil"
    echo "##### => Eski Katello kaldiriliyor"
       yum remove katello-ca-consumer-satellite.domain.com-1.0-1.noarch -y
    echo "##### => Eski Sunucu Ayarlari kaldiriliyor"
       rm -f /etc/rhsm/facts/katello.facts
       rm -f /etc/machine-id
       systemd-machine-id-setup
    echo "##### => Eski Uyelik kaldiriliyor"
       subscription-manager clean
    echo "##### => Yum Cache Klasoru Bosaltiliyor"
     rm -rf /var/cache/yum
    echo "##### => Yeni Katello Paketi ekleniyor"
       ##rpm -Uvh http://satellite.domain.com/pub/katello-ca-consumer-latest.noarch.rpm
       yum localinstall http://satellite.domain.com/pub/katello-ca-consumer-latest.noarch.rpm -y
    echo "##### => Yeni Uyelik ekleniyor"
       subscription-manager register --org="DOMAINIT" --activationkey="LIVE_76"
    echo "##### => Surum Set ediliyor"
       subscription-manager release --set 7.6
       subscription-manager refresh
       subscription-manager attach --auto
    echo "##### => Yum Kontrol ediliyor"
       yum clean all
       yum repolist
    echo "##### => Paketler Guncelleniyor"
       yum upgrade -y
    echo "##### => Kayit ve Guncellenme Tamamlandi"
elif [[ "$result" == *"Subscribed"* ]];then
    echo "##### => Sunucu Satellite ve RHEL Uyeligiline Kayıtlı"
    echo "##### => Paketler Guncelleniyor"
       yum upgrade -y
    echo "##### => Guncellenme Tamamlandi"
elif [[ "$result" == *"Not Subscribed"* ]];then
    echo "##### => Sunucu Satellite ve RHEL Uyeligiline Kayitli Degil"
    echo "##### => Uyelik kaldiriliyor"
       subscription-manager clean
    echo "##### => Yeni Katello Paketi ekleniyor"
       rpm -Uvh http://satellite.domain.com/pub/katello-ca-consumer-latest.noarch.rpm
    echo "##### => Eski Sunucu Ayarlari kaldiriliyor"
       rm -f /etc/rhsm/facts/katello.facts
       rm -f /etc/machine-id
       systemd-machine-id-setup
    echo "##### => Yeni Uyelik ekleniyor"
       subscription-manager register --org="DOMAINIT" --activationkey="LIVE_76"
    echo "##### => Surum Set ediliyor"
       subscription-manager release --set 7.6
       subscription-manager refresh
       subscription-manager attach --auto
    echo "##### => Yum Kontrol ediliyor"
       yum clean all
       yum repolist
    echo "##### => Paketler Guncelleniyor"
       yum upgrade -y
    echo "##### => Kayit ve Guncellenme Tamamlandi"
elif [[ "$result" == *"Current"* ]];then
    echo "##### => Sunucu Satellite ve RHEL Uyeligiline Kayitli ve Gecerli"
    echo "##### => Paketler Guncelleniyor"
       yum upgrade -y
    echo "##### => Guncellenme Tamamlandi"
else
    echo "##### => Sorgulama Hatali"
fi
