---
title: Linux Xen和OpenVZ架构安装PPTP VPN。
tags:
  - CentOS
  - Linux
  - OpenVZ
  - VPN
  - Xen
  - 安装pptp
id: 470
categories:
  - 网络相关
date: 2013-08-14 14:25:05
---

之前有好几次安装VPN服务都失败了，最近再次有安装几次发现非常的简单，特写此文章供参考。

Xen系统环境：CentOS release 6.4 (Final) 64位
首先检查是否支持PPP（一般都支持的）
执行modprobe ppp-compress-18 无返回结果则OK

```
[root@localhost ~]# modprobe ppp-compress-18
[root@localhost ~]#
```

下载pptp安装包

官方: (http://poptop.sourceforge.net/yum/stable/packages/) （需翻X）



```
[root@localhost ~]# ls
pptpd-1.3.4-2.el6.x86_64.rpm
[root@localhost ~]# rpm -ivh pptpd-1.3.4-2.el6.x86_64.rpm 
warning: pptpd-1.3.4-2.el6.x86_64.rpm: Header V3 DSA/SHA1 Signature, key ID 862acc42: NOKEY
error: Failed dependencies:
/usr/bin/perl is needed by pptpd-1.3.4-2.el6.x86_64
perl(strict) is needed by pptpd-1.3.4-2.el6.x86_64
```

执行安装的时候出现如上错误，原因是没有安装perl

```
yum -y install perl
```


[![install-perl](/images/2013/08/install-perl-300x201.png)](/images/2013/08/install-perl.png)

编辑ppp配置文件：vim /etc/ppp/options.pptpd

先按键盘上的 dG 清空默认配置添加下面的配置上去保存退出。
```
name pptpd 
refuse-pap 
refuse-chap 
refuse-mschap 
require-mschap-v2 
require-mppe-128 
proxyarp 
lock 
nobsdcomp 
novj 
novjccomp 
nologfd 
ms-dns 8.8.8.8
ms-dns 8.8.4.4
```
编辑IP地址池等信息：vim /etc/pptpd.conf

同样键入dG清空默认配置添加下方配置保存退出。（localip和remoteip可根据自己的需要配置）
```
option /etc/ppp/options.pptpd 
logwtmp 
localip 172.16.0.1 
remoteip 172.16.0.2-254
```
localip：本机PPP网卡IP（作为客户端连接时的网关）

remoteip：客户端获取IP的范围（从2到254个IP顺序获取）

编辑VPN帐号密码信息：vim /etc/ppp/chap-secrets

格式为：登录帐号 协议 登录密码 指定客户端获取的IP

如：vpn pptpd vpn *  - 这样为帐号密码是vpn 获取的ip会从/etc/pptpd.conf配置的地址池中获取

vpn pptpd vpn 172.16.0.55 - 这样我就为该帐号设置了一个固定的IP，请不要设置123.3.4.5这样的IP 否则上不了网。

开启ipv4内核转发：vim /etc/sysctl.conf

把 net.ipv4.ip_forward = 0 修改为 net.ipv4.ip_forward = 1

执行 sysctl -p

[![ipv4-forward](/images/2013/08/ipv4-forward-300x201.png)](/images/2013/08/ipv4-forward.png)

现在我们的VPN服务基本已经配置完毕了，现在执行最后的操作

添加iptables NAT转发规则
```
iptables -A INPUT -p tcp --dport 1723 -j ACCEPT

iptables -A INPUT -p tcp --dport 47 -j ACCEPT

iptables -A INPUT -p gre -j ACCEPT

iptables -t nat -A POSTROUTING -s 172.16.0.0/24 -o eth0 -j MASQUERADE
```
如果你的iptables策略并不需要如此严格其实添加下面这1条就可以了
```
iptables -t nat -A POSTROUTING -s 172.16.0.0/24 -o eth0 -j MASQUERADE
```
保存iptables规则和启动pptp服务并设置开机启动
```
service iptables save

service iptables restart

service pptpd start

chkconfig pptpd on
```
现在你就可以使用你的客户端连接到你的VPN服务开始翻X之旅啦！

[![xen-pptp](/images/2013/08/xen-pptp-266x300.png)](/images/2013/08/xen-pptp.png)

OpenVZ系统环境：CentOS release 6.2 (Final) 32位

安装ppp和pptp
```
yum -y install ppp

rpm -ivh http://soft.painso.com/Linux/pptpd/pptpd-1.3.4-2.el6.i686.rpm
```
同样开始编辑配置文件：
```
vim /etc/ppp/options.pptpd
```
清空粘帖下方配置
```
name pptpd 
refuse-pap 
refuse-chap 
refuse-mschap 
require-mschap-v2 
require-mppe-128 
proxyarp 
lock 
nobsdcomp 
novj 
novjccomp 
nologfd 
ms-dns 8.8.8.8
ms-dns 8.8.4.4
```
```
vim /etc/pptpd.conf
```
清空粘帖下方配置
```
option /etc/ppp/options.pptpd
logwtmp
localip 172.16.0.1
remoteip 172.16.0.2-254
```
```
vim /etc/ppp/chap-secrets
```
添加你的pptp服务帐号

[![pptp](/images/2013/08/pptp-300x55.png)](/images/2013/08/pptp.png)

同样修改内核配置开启ipv4转发
```
vim /etc/sysctl.conf
```
里面的 net.ipv4.ip_forward=0 修改为 net.ipv4.ip_forward=1
```
sysctl -p
```
添加iptables转发规则
```
iptables -t nat -A POSTROUTING -s 172.16.0.0/24 -j SNAT --to-source 67.117.22.35
```
这里的 67.117.22.35 修改为服务器的公网IP

开启相关服务并开机启动
```
service iptables save

service iptables restart

service pptpd start

chkconfig pptpd on
```

大功告成！

[![openvz](/images/2013/08/openvz-300x141.png)](/images/2013/08/openvz.png)

注：

错误1：如果出现错误619则输入命令：
```
rm -r /dev/ppp
mknod /dev/ppp c 108 0
```
然后 reboot 重启。

错误2：如果出现错误800，这是因为虚拟机内核不支持mpPE，无法使用加密，用WINDOWS默认VPN连接会显示“证书信任错误”。解决方法：修改/etc/ppp/options.pptpd文件，在require-mppe-128字段前面加#即可，注释掉require-mppe-128这行就成功了

本地的windows系统的vpn属性改为可选加密，如下图：

[![error](/images/2013/08/error-300x227.png)](/images/2013/08/error.png)

其实到最后你会发现2种虚拟架构配置VPN只是添加到iptables的转发规则不同。

~~我操！浪费老子这么多时间，这Linux还怎么玩。。。~~