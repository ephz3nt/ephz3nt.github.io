---
title: ocserv 安装记录。
tags:
  - anyconnect
  - cisco
  - iPhone
  - ocserv
  - OpenConnect
  - VPN
  - 全局
id: 721
categories:
  - 网络相关
date: 2016-06-03 17:53:05
---

ocserv 全称是 OpenConnect VPN Server。实现了 AnyConnect SSL VPN 协议，兼容 OpenConnection VPN 客户端。特点是体积小、安全和可配置。依赖标准协议如 TLS 1.2 和数据报文 TLS。

它通过实现Cisco的AnyConnect协议，用DTLS作为主要的加密传输协议。

它的主要好处在于:

*   AnyConnect的VPN协议默认使用UDP DTLS作为数据传输，但如果有什么网络问题导致UDP传输出现问题，它会利用最初建立的TCP TLS通道作为备份通道，降低VPN断开的概率。
*   AnyConnect作为Cisco新一代的VPN解决方案，被用于许多大型企业，这些企业依赖它提供正常的商业运作，这些正常运作对应的经济效益（读作GDP），是我们最好的伙伴。
*   OpenConnet的架设足够麻烦，我的意思是，如果你不是大型企业，你会用AnyConnect的概率无限趋近于零。再者，如果它足够简单，我就不用写这篇文章了。(摘自[比特客栈](https://bitinn.net/11084/))

支持平台：Windows、Mac、Android、iOS、Windows Phone 基本是全平台支持, 我为什么会用他而不用Shadowsocks，因为我一个朋友用的iPhone，而且未越狱又想全局，所以才想到ocserv。

系统版本：CentOS release 6.7 x64

安装前置关联库：
```
yum -y install autoconf automake gcc libtasn1-devel zlib zlib-devel trousers trousers-devel gmp-devel gmp xz texinfo libnl-devel libnl tcp_wrappers-libs tcp_wrappers-devel tcp_wrappers dbus dbus-devel ncurses-devel pam-devel readline-devel bison bison-devel flex gcc automake autoconf wget expat-devel openssl-devel
```

nettle
```
wget http://ftp.gnu.org/gnu/nettle/nettle-2.7.1.tar.gz
tar zxf nettle-2.7.1.tar.gz && cd nettle-2.7.1
./configure && make && make install
cd ..
```

unbound
```
wget http://unbound.nlnetlabs.nl/downloads/unbound-1.4.22.tar.gz
tar zxf unbound-1.4.22.tar.gz && cd unbound-1.4.22
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd ..
```
安装后执行程序将会出现动态库文件找不到的问题：
```
unbound-anchor: error while loading shared libraries: libunbound.so.2: cannot open shared object file: No such file or directory
```
这是因为系统默认没有找/usr/local/lib目录下的库文件，为了一劳永逸，我们把将路径加入到配置文件中：
```
echo '/usr/local/lib/' > /etc/ld.so.conf.d/local-libraries.conf && ldconfig
echo '/usr/local/lib64/' >> /etc/ld.so.conf.d/local-libraries.conf && ldconfig

```
生成配置文件：
```
mkdir /etc/unbound/ && unbound-anchor -a "/etc/unbound/root.key"
```
这是为了消除之后编译gnutls时遇到的警告信息：

[![gnutls-warning](/images/2016/06/gnutls-warning-300x62.png)](/images/2016/06/gnutls-warning.png)

添加环境变量(为安装gnutls)：
```
32bit

export LD_LIBRARY_PATH=/usr/local/lib/:/usr/local/lib64/ NETTLE_CFLAGS="-I/usr/local/include/" NETTLE_LIBS="-L/usr/local/lib64/ -lnettle" HOGWEED_CFLAGS="-I/usr/local/include" HOGWEED_LIBS="-L/usr/local/lib64/ -lhogweed"

export LD_LIBRARY_PATH=/usr/local/lib/:/usr/local/lib64/ LIBGNUTLS_CFLAGS="-I/usr/local/include/" LIBGNUTLS_LIBS="-L/usr/local/lib/ -lgnutls" LIBNL3_CFLAGS="-I/usr/local/include" LIBNL3_LIBS="-L/usr/local/lib/ -lnl-3 -lnl-route-3"

64bit

export LD_LIBRARY_PATH=/usr/lib/:/usr/lib64/ NETTLE_CFLAGS="-I/usr/include/" NETTLE_LIBS="-L/usr/lib64/ -lnettle" HOGWEED_CFLAGS="-I/usr/include" HOGWEED_LIBS="-L/usr/lib64/ -lhogweed"

export LD_LIBRARY_PATH=/usr/lib/:/usr/lib64/ LIBGNUTLS_CFLAGS="-I/usr/include/" LIBGNUTLS_LIBS="-L/usr/lib/ -lgnutls" LIBNL3_CFLAGS="-I/usr/include" LIBNL3_LIBS="-L/usr/lib/ -lnl-3 -lnl-route-3"
```
```
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH
```

gnutls
```
wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.2/gnutls-3.2.15.tar.xz
tar xvf gnutls-3.2.15.tar.xz
cd gnutls-3.2.15
./configure && make && make install
cd ..
```

LibNL
```
wget http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-3.2.24.tar.gz
tar xvf libnl-3.2.24.tar.gz
cd libnl-3.2.24
./configure && make && make install
cd ..
```
ocserv
```
wget ftp://ftp.infradead.org/pub/ocserv/ocserv-0.8.1.tar.xz
tar xvf ocserv-0.8.1.tar.xz && cd ocserv-0.8.1
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd ..
```

至此安装完毕，下面配置
创建CA证书和服务器证书

```
certtool --generate-privkey --outfile ca-key.pem
cat << _EOF_ > ca.tmpl
cn = "example VPN"
organization = "example.com"
serial = 1
expiration_days = 3650
ca
signing_key
cert_signing_key
crl_signing_key
_EOF_
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca-cert.pem
certtool --generate-privkey --outfile server-key.pem
cat << _EOF_ > server.tmpl
cn = "example VPN"
o = "example"
serial = 2
expiration_days = 3650
signing_key
encryption_key #only if the generated key is an RSA one
tls_www_server
_EOF_
certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.tmpl --outfile server-cert.pem
```

把证书复制到ocserv的配置目录

```
mkdir -p /etc/ocserv/;cp server-cert.pem /etc/ocserv/ && cp server-key.pem /etc/ocserv/
```

编辑配置文件

```
vim /etc/ocserv/ocserv.conf
```

```
#认证方式,这里选择的是帐号密码认证
auth = "plain[/etc/ocserv/ocpasswd]"

#允许同时连接的客户端数量
max-clients = 100
#限制同一客户端的并行登陆数量
max-same-clients = 4
#服务监听的TCP/UDP端口
tcp-port = 443
udp-port = 443
#自动优化VPN的网络性能
try-mtu-discovery = true
#服务器证书与密钥
server-cert = /etc/ocserv/server-cert.pem
server-key = /etc/ocserv/server-key.pem
#客户端连上vpn后使用的dns
dns = 8.8.8.8
dns = 8.8.4.4
#注释掉所有的route,让服务器成为gateway
#route = 192.168.1.0/255.255.255.0
#启用cisco客户端兼容性支持
cisco-client-compat = true
pid-file = /var/run/ocserv.pid
socket-file = /var/run/ocserv-socket
run-as-user = ocserv
run-as-group = ocserv
device = vpns
#分配内网IP地址段
ipv4-network = 172.16.200.0
ipv4-netmask = 255.255.255.0
```

添加帐号

```
ocpasswd -c /etc/ocserv/ocpasswd your-username
```

开启内核ipv4转发

```
vim /etc/sysctl.conf
```

将net.ipv4.ip_forward 设置为1

```
net.ipv4.ip_forward = 1
```

保存执行 sysctl -p

添加防火墙流量转发(网卡名称以实际情况为准)

```
iptables -t nat -A POSTROUTING -s 172.16.200.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -s 172.16.200.0/24 -j ACCEPT
service iptables save
```