FROM ruby:2.1
MAINTAINER Stanislav Mekhonoshin <ejabberd@gmail.com>

RUN apt-get -y update
RUN apt-get -y install openvpn
RUN gem install smartvpn-http-hooks

WORKDIR /hooks
COPY ./ .
COPY ./config/openvpn.conf /etc/openvpn/server.conf
COPY ./config/firewall.sh /etc/openvpn/server.up.sh

ENTRYPOINT ["/hooks/entrypoint.sh"]
