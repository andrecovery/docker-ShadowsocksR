#!/bin/bash
if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
fi

if [ ! -f /.root_pw_set ]; then
	/set_root_pw.sh
fi

echo "========================================================================"
echo " You can now connect to this ShadowSocksR server at port: $SS_SERVER_PORT "
echo " timeout: $SS_TIMEOUT  protocol: $SS_PROTOCOL , $SS_PROTOCOLP  obfs: $SS_OBFS , $SS_OBFSP "
echo " encryption method: $SS_METHOD  redirect: $SS_REDIRECT  dnsv6: $SS_DNSIPV6 "
echo " Please remember the password: $SS_PASSWORD "
echo "========================================================================"

echo '{"server":"0.0.0.0","server_ipv6":"::","server_port":'$SS_SERVER_PORT',"local_address":"127.0.0.1","local_port":1080,"password":"'$SS_PASSWORD'","timeout":'$SS_TIMEOUT',"method":"'$SS_METHOD'","protocol":"'$SS_PROTOCOL'","protocol_param":'$SS_PROTOCOLP',"obfs":"'$SS_OBFS'","obfs_param":'$SS_OBFSP',"redirect":'$SS_REDIRECT',"dns_ipv6":'$SS_DNSIPV6',"fast_open": true,"workers": 1}'>/shadowsocksr.json

(sleep 2;/usr/sbin/sshd -D)&
(sleep 1;python ~/shadowsocks/shadowsocks/server.py -c /shadowsocksr.json)&
~/SoftEtherVPN/./vpnserver start
wait
exit 0
