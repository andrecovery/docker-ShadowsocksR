echo "========================================================================"
echo " You can now connect to this ShadowSocksR server:"
echo " password: $SS_PASSWORD  protocol: $SS_PROTOCOL  obfs: $SS_OBFS "
echo " timeout: $SS_TIMEOUT  encryption method: $SS_METHOD "
echo " Please remember the password!"
echo "========================================================================"

cd ~/shadowsocks/shadowsocks
echo "{"server":"0.0.0.0","server_ipv6": "::","server_port":$SS_SERVER_PORT,"local_address": "127.0.0.1","local_port":1080,"password":"$SS_PASSWORD","timeout":$SS_TIMEOUT,"method":"$SS_METHOD","protocol":"$SS_PROTOCOL","obfs":"$SS_OBFS","obfs_param":$SS_OBFSP,"fast_open": false,"workers": 1}">shadowsocksr.json
python server.py -c shadowsocksr.json
