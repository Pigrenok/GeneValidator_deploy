#!/bin/sh

if [ -f ${CERTFOLDER}live/${SSLHOST}/fullchain.pem ] && [ -f ${CERTFOLDER}live/${SSLHOST}/privkey.pem ]; then
	certbot renew #--dry-run #--quiet
	# echo "Renew certifica"
else
	certbot certonly --webroot --webroot-path /var/www/certbot/ --non-interactive --agree-tos -m $LE_USER -d $SSLHOST #--dry-run
	# echo "Generate"
fi

cd /etc/letsencrypt/live/${SSLHOST}/ && aws acm import-certificate --certificate-arn arn:aws:acm:us-east-2:964138189790:certificate/ec04de04-ef86-4388-8e59-2fdc83ab1eaa --certificate fileb://cert.pem --private-key fileb://privkey.pem --certificate-chain fileb://fullchain.pem
