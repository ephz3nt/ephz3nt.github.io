---
title: 解决MYSQL不能远程访问。
tags:
  - Dropmysite
  - mysql
  - PHPMYADMIN
  - 远程访问
id: 303
categories:
  - 网络相关
date: 2012-02-28 16:54:23
---

最近在网上找了个免费网站备份的网站，Dropmysite.com 提供2.3个G的备份空间，提供网站数据、数据库数据以及邮箱数据的自动备份，可按月，周，日，时为单位来备份，很方便，但是在用到MYSQL备份的时候老是提示不能访问远程数据库，网上找了一下资料，经实践 最简单的方法就是在PHPMYADMIN后台改一下数据表，应为我的是lnmp的环境默认带phpmysql这个网页数据库管理的功能 ，打开PHPMYADMIN后台登陆，选择mysql数据库里面最下面的user数据表，把第一行的localhost改成%即可。

[![](/images/2012/02/mysql.jpg)](/images/2012/02/mysql.jpg)

[![](/images/2012/02/mysql-300x114.jpg "解决MYSQL不能远程访问。")](/images/2012/02/mysql-300x114.jpg)

这个dropmysite.com不错哟，有兴趣的朋友可以试试。

[![](/images/2012/02/dropmysite-300x102.jpg "dropmysite")](/images/2012/02/dropmysite.jpg)