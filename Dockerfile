# About ShadowsocksR of Docker
# 
# Version:1.1

FROM ubuntu:14.04
MAINTAINER cms88168 "cms88168@outlook.com"

ENV REFRESHED_AT 2015-11-30

RUN apt-get -qq update && \
    apt-get install -q -y wget build-essential python-m2crypto git&& \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#add chacha20
RUN wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz && \
    tar zxf LATEST.tar.gz && \
    cd libsodium* && \
    ./configure && make -j2 && make install && \
    ldconfig && \
    cd .. && \
    rm -rf LATEST.tar.gz && \
    rm -rf libsodium*

RUN cd ~ && \
    git clone -b manyuser https://github.com/breakwa11/shadowsocks.git

ENV SS_SERVER_PORT 8388
ENV SS_PASSWORD password
ENV SS_METHOD aes-256-cfb
ENV SS_TIMEOUT 300
ENV SS_PROTOCOL origin
ENV SS_OBFS http_simple_compatible
ENV SS_OBFSP \"baidu.com\"

VOLUME ["~/shadowsocks/shadowsocks"]

ADD start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

EXPOSE $SS_SERVER_PORT
EXPOSE $SS_SERVER_PORT/tcp
EXPOSE $SS_SERVER_PORT/udp

CMD ["sh", "-c", "start.sh"]
