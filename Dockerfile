FROM ruby:2.1
MAINTAINER Stanislav Mekhonoshin <ejabberd@gmail.com>

RUN apt-get -y update
RUN apt-get -y install openvpn
RUN gem install openvpn-http-hooks

# TODO: copy config
# update config via envsubst

WORKDIR /hooks
COPY ./ .

#CMD rm -f /app/tmp/pids/server.pid && rails db:migrate && foreman start -f Procfile
