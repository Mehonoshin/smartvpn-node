FROM ruby:2.3.4
MAINTAINER Stanislav Mekhonoshin <ejabberd@gmail.com>

RUN apt-get -y update
RUN apt-get -y install openvpn iptables vim nmap
RUN gem install smartvpn-http-hooks -v '1.0.9'

WORKDIR /hooks
COPY ./ .
COPY ./config/openvpn.conf /etc/openvpn/server.conf
COPY ./config/firewall.sh /etc/openvpn/server.up.sh

ENTRYPOINT ["/hooks/entrypoint.sh"]
