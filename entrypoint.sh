#!/bin/bash

# TODO:
# copy keys into image
/hooks/bin/generate_keys.sh
openvpn --config /etc/openvpn/server.conf
#smartvpn activate

