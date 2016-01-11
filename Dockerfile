# About ShadowsocksR of Docker
# 
# Version:1.2

FROM ubuntu:14.04
MAINTAINER cms88168 "cms88168@outlook.com"

ENV REFRESHED_AT 2016-1-11

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
ENV SS_PASSWORD 19941008
ENV SS_METHOD aes-256-cfb
ENV SS_TIMEOUT 300
ENV SS_PROTOCOL verify_deflate
ENV SS_PROTOCOLP \"\"
ENV SS_OBFS http_simple_compatible
ENV SS_OBFSP \"baidu.com\"
ENV SS_REDIRECT \"www.cgam.tk/404.html\"
ENV SS_DNSIPV6 false

#add VPN
RUN wget http://www.packetix-download.com/files/packetix/v4.19-9599-beta-2015.10.19-tree/Linux/PacketiX_VPN_Server/64bit_-_Intel_x64_or_AMD64/vpnserver-v4.19-9599-beta-2015.10.19-linux-x64-64bit.tar.gz && \
    tar -zxvf vpnserver-v4.19-9599-beta-2015.10.19-linux-x64-64bit.tar.gz && \
    rm -f vpnserver-v4.19-9599-beta-2015.10.19-linux-x64-64bit.tar.gz && \
    cd vpnserver && \
    make i_read_and_agree_the_license_agreement

ADD vpn_server.config ~/vpnserver/vpn_server.config

VOLUME ["~/"]

ADD start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

EXPOSE $SS_SERVER_PORT/tcp
EXPOSE 443/tcp
EXPOSE 53/udp

CMD ["sh", "-c", "start.sh"]
