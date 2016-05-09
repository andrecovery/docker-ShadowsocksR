# ubuntu-ShadowsocksR
ShadowsocksR Server (https://github.com/breakwa11/shadowsocks/tree/manyuser) for Docker
由于大多数docker服务的限制,只能通过ssl vpn(例如openvpn和SoftEtherVPN)来连接
这个集合了SSH,SSR和SoftEtherVPN的服务端(兼容OpenVPN)
其中SSH使用22端口,用户名是root,密码可以通过建立docker的时候增加变量ROOT_PASS来指定
SSR使用8388端口,各项参数可以参考dockerfile中的参数来在建立时指定相应变量
至于VPN,我指定的是TCP 443端口,请通过ssh连接你的服务器,然后
1:~# cd SoftEtherVPN/
2:~# ./vpnserver stop
3:~# rm -rf vpn_server.config //这是我个人的设置,先删除
4:~# ./vpnserver start
然后可以通过vpncmd或者到官网下载windows上的SoftEtherVPN远程管理程序来新建配置或管理服务器,并可以导出openvpn配置文件(需要手动修改一下你自己的服务器地址和端口)
然后就可以通过SoftEtherVPN的客户端在或者openvpn来进行连接.
如果希望固化自己的SS和VPN设置,可以fork后上传自己导出的vpn_server.config和SS参数来修改.
