---
title: DNSPOD+Incapsula CDN实现文件国内用户可下载Dropbox文件以及外链
tags:
  - DNSPOD
  - Dropbox文件下载
  - Incapsula
id: 224
categories:
  - 网络相关
date: 2012-02-05 23:07:54
---

大家现在都知道Dropbox国内用户无法下载dl.dropbox.com/xxx.xxx 这样以及 dl-web.dropbox.com/xxx.xxx 的文件

现在即可通过Dropbox+DNSPOD+Incapsula实现下载咯<!--more-->

第一步在DNSPOD添加CNAME解析到dl.dropbox.com

我的是解析了dl.dropbox.com的几个节点IP

都一样的啦，然后进入Incapsula.com注册一个账号

注册过程就不说了，直接添加

这里以www.baidu.com为示例，点下一步next，等待一段时间后会提示你继续的，一直点Continue就是啦

点击继续

继续

完了之后会给出叫你解析到他的地址，如我刚刚添加的百度.com的是 eh939.x.incapdns.net 把给你的地址复制下来回到dnspod把刚刚解析到dl.dropbox.com的记录值dl.dropbox.com替换成eh939.x.incapdns.net

然后修改一下Dropbox给出的下载地址，默认是http://dl.dropbox.com/u/6767676/Photo/testimg.jpg

修改成http://你的域名/u/6767676/Photo/testimg.jpg