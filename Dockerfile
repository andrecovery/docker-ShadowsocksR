# About ShadowsocksR of Docker
# 
# Version:1.2

FROM debian:jessie
MAINTAINER cms88168 "cms88168@outlook.com"

ENV REFRESHED_AT 2016-1-11

COPY sources.list /etc/apt/sources.list
RUN apt-get -qq update && \
    apt-get install -q -y wget build-essential python-m2crypto git openssh-server pwgen && \
    apt-get clean && \
    mkdir /var/run/sshd  
    echo 'root:rootroot' |chpasswd  
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config  
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config  
    
    
    
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

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
ENV SS_REDIRECT \"cmsg.cf/404.html\"
ENV SS_DNSIPV6 false

#add VPN
RUN cd ~ && \
    git clone https://github.com/cms88168/SoftEtherVPN.git && \
    cd SoftEtherVPN && \
    make i_read_and_agree_the_license_agreement

ADD set_root_pw.sh /set_root_pw.sh
RUN chmod +x /*.sh
ADD start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22/tcp
EXPOSE $SS_SERVER_PORT/tcp
EXPOSE 443/tcp
EXPOSE 53/udp

CMD ["sh", "-c", "start.sh"]
