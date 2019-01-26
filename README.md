# smartvpn-node

<a href="https://imgbb.com/"><img src="https://image.ibb.co/gEVXM9/Screen-Shot-2018-10-14-at-18-34-17.png" alt="smartvpn-billing" border="0"></a>

VPN node configuration that integrates to [smartvpn-billing](https://github.com/Mehonoshin/smartvpn-billing).

## Installation

TBD

## How to run

```
docker run -e SECRET_TOKEN='123' -e API_HOST='157.230.105.228' -e HOSTNAME='VPN' --cap-add=NET_ADMIN mexx/smartvpn-node:latest
```
