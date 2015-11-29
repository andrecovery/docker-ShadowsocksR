echo "========================================================================"
echo " You can now connect to this ShadowSocksR server:"
echo " password: $SS_PASSWORD  protocol: $SS_PROTOCOL  obfs: $SS_OBFS "
echo " timeout: $SS_TIMEOUT  encryption method: $SS_METHOD "
echo " Please remember the password!"
echo "========================================================================"

cd ~/shadowsocks/shadowsocks
python server.py -c /etc/shadowsocksr.json
