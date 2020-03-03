---
title: Dropbox被墙解决方案。
tags:
  - ChinaDNS
  - Dropbox
  - Facebook
  - 无法连接
  - 被墙
id: 680
categories:
  - 网络相关
date: 2014-11-12 15:16:02
---

Dropbox被墙已经有好几个月了，无论是网页版还是客户端都无法正常工作，之前一直用的SS来访问，但是如果是用别人电脑的时候还是有些麻烦的。
现在使用了@[clowwindy](http://github.com/clowwindy)的ChinaDNS
使用方法：
下载地址：
[https://github.com/clowwindy/ChinaDNS/blob/master/README.md#install](https://github.com/clowwindy/ChinaDNS/blob/master/README.md#install)
解压后运行dnsrelay.exe启动本地DNS服务器<!--more-->
然后把你的网卡DNS设置成127.0.0.1即可使用啦～
其原理为(原文@[chengkai](http://examplecode.github.io/tools/2014/06/20/the-tools-prevent-dns-cache-pollution/))：
GFW对域名进行DNS污染的原理实际上是在正常的DNS服务器返回请求包之前，返回请求者错误的IP地址。而GFW返回的这些错误地址也是有规律可循，根据这个原理就不难写出对抗GFW DNS污染的程序了。所以程序核心内容就有两点：
提供GFW返回IP的一个黑名单列表。
如果服务端返回的DNS响应IP地址在黑名单列表中，则进行忽略并尝试等待真实的ip地址返回。

这样Dropbox就不用走代理，也省了不少流量。
经过测试还可以上FB，推特貌似是直接把IP给墙了。
如果你需要一个Dropbox，请使用该链接注册，[http://db.tt/0xSK4uIc](http://db.tt/0xSK4uIc) 我和你都会额外获得512M的空间。