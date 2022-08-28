#!/bin/bash
# Read IP name
echo -n "Enter IP address for DKIM gen:"
read -r ipaddr
foundaddr=$(find / -name $ipaddr.pem)
echo -n "Full IP address will be $foundaddr Correct? (y/n)"
read -r ipaddrcheck
if [[ "$ipaddrcheck" != "y" ]]; then
echo -n "Aborted..."
echo
exit
fi

#move to pem file folder
#cd /etc/pmta/keys

#move old file to backup
mv $ipaddr.pem $ipaddr._old

#generate news provate key
openssl genrsa -out $ipaddr.private.key 1024

#create publick key
openssl rsa -in $ipaddr.private.key -out $ipaddr.public.key -pubout -outform PEM

#move file from private to pem
mv $ipaddr.private.key $ipaddr.pem

echo -n "Is there another IP for gen? (y/n)"
read -r endcheck
if [[ "$endcheck" = "y" ]]; then

sh ./dkim_update_gen.sh

else 
echo -n "Aborted..."
echo
exit
fi