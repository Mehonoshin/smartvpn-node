#!/bin/bash

# TODO: we need to substitute ENV variables in this script with those, that we
# received from docker
cp $HOOKS_PATH/bin/load_env.sh.template $HOOKS_PATH/bin/load_env.sh
$HOOKS_PATH/bin/generate_keys.sh
$HOOKS_PATH/bin/make_dev_tun.sh

smartvpn-activate

openvpn --config /etc/openvpn/server.conf

