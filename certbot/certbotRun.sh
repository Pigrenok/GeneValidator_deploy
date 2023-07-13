#!/bin/sh

if [ -f ${CERTFOLDER}live/${SSLHOST}/fullchain.pem ] && [ -f ${CERTFOLDER}live/${SSLHOST}/privkey.pem ]; then
	certbot renew #--dry-run #--quiet
	# echo "Renew"
else
	certbot certonly --webroot --webroot-path /var/www/certbot/ --non-interactive --agree-tos -m $LE_USER -d $SSLHOST #--dry-run
	# echo "Generate"
fi

if [ -n $CERTARN ]; then
	cd /etc/letsencrypt/live/${SSLHOST}/ && aws acm import-certificate --certificate-arn $CERTARN --certificate fileb://cert.pem --private-key fileb://privkey.pem --certificate-chain fileb://fullchain.pem