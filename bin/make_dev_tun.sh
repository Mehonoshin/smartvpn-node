#!/bin/bash

# Creates /dev/net/tun unless it exists

mkdir -p /dev/net
mknod /dev/net/tun c 10 200
