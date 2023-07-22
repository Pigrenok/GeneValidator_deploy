#!/bin/sh

# Environment variable should contain a list of hosts for which a SINGLE certificate should be obtained!
# The list should be separated by "," and does not contain any extra symbols
# Example list is "www.example1.com,www.example2.com" (without quotes). If only ine domains is needed,
# it should be the value of SSLHOST variable without comma ","

# Also the environment variable LE_HOST should be set to valid email to which Let's Encrypt account is 
# (should be) registered.

FIRSTDOMAIN=$(echo $SSLHOST | cut -d ',' -f1)

certbot certonly --cert-name $FIRSTDOMAIN --webroot --webroot-path /var/www/certbot/ --non-interactive --agree-tos -m $LE_USER -d $SSLHOST #--dry-run

if [ -n $CERTARN ]; then
	cd /etc/letsencrypt/live/${FIRSTDOMAIN}/ && aws acm import-certificate --certificate-arn $CERTARN --certificate fileb://cert.pem --private-key fileb://privkey.pem --certificate-chain fileb://fullchain.pem
fi