#!/bin/bash

# This script should be run whenever we start the container with this image
# for the first time on machine.
# It generates encryption keys for the openvpn server, and sends them to billing.
# So the billing will be aware of them, and can email a proper connection configuration
# to the SmartVPN user.

if [ -d /hooks/pki ]
then
	echo "PKI already exists"
else
	make-cadir /hooks/pki
	echo "export KEY_NAME=\"EasyRSA\"" >> /hooks/pki/vars
	cd /hooks/pki

	ls -al
	source ./vars

	./clean-all
	./build-ca --batch
	./build-key-server --batch server
	./build-dh

	openvpn --genkey --secret keys/ta.key

	./build-key --batch generic_client
	chmod 755 /etc/openvpn/server.up.sh
fi
