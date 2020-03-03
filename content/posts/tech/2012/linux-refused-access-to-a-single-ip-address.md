---
title: Linux拒绝单个IP地址访问。
tags:
  - Linux
  - 拒绝单个IP
id: 263
categories:
  - 网络相关
date: 2012-02-12 22:05:51
---

从博客开始就一直有垃圾评论，点开看看发现大部分都是一个IP地址的，在Ubuntu添加一条规则拒绝垃圾评论的IP这样它的IP就无法访问啦 (:O

屏蔽单个IP：

```iptables -A INPUT -p tcp -s ip地址 -j DROP```

-A是添加一条新规则add缩写我想是，INPUT 进 ，-p 协议 是 tcp 网站80端口就是tcp，-s - source 源IP ，-j DROP 拒绝的意思吧 呵呵。<!--more-->

例子：拒绝192.168.1.1 ip访问

`iptables -A INPUT -p tcp -s 192.168.1.1 -j DROP`

######封整个段即从192.0.0.1到192.255.255.254的命令
`iptables -I INPUT -s 192.0.0.0/8 -j DROP`

######封IP段即从192.45.0.1到192.45.255.254的命令
`iptables -I INPUT -s 124.45.0.0/16 -j DROP`

######封IP段即从192.45.6.1到192.45.6.254的命令
`iptables -I INPUT -s 192.45.6.0/24 -j DROP`

注意如命令错误注意大小写。

删除iptables规则：

先查看规则编号

`iptables -L -n --line-number`

[![](/images/2012/02/1-300x96.jpg "Linux拒绝单个IP地址访问。")](/images/2012/02/1.jpg)

如图，我的DROP规则是1，

输入`iptables -D INPUT 1`

[![](/images/2012/02/21-300x101.jpg "Linux拒绝单个IP地址访问。")](/images/2012/02/21.jpg)

已经删除了，iptables规则重启后会失效

编辑/etc/rc.local

添加协议

`iptables -A INPUT -p tcp -s 8.8.8.8 -j DROP`

[![](http://img.painso.com/image/5052-iptables.jpg "Linux拒绝单个IP地址访问")](http://img.painso.com/image/5052-iptables.jpg)