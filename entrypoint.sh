#!/bin/bash

/hooks/bin/generate_keys.sh
/hooks/bin/make_dev_tun.sh

#smartvpn activate

openvpn --config /etc/openvpn/server.conf

