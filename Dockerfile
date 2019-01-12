FROM ruby:2.1
MAINTAINER Stanislav Mekhonoshin <ejabberd@gmail.com>

RUN apt-get -y update
RUN apt-get -y install openvpn
RUN gem install smartvpn-http-hooks

WORKDIR /hooks
COPY ./ .

ENTRYPOINT ["/hooks/entrypoint.sh"]
