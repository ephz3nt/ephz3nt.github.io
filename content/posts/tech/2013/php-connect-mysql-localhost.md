---
title: '[转]PHP连接MySQL主机127.0.0.1与localhost的区别'
tags:
  - 127.0.0.1
  - localhost
  - mysql
  - php
id: 458
categories:
  - 网络相关
date: 2013-07-12 23:45:53
---

发现问题

昨天在帮同事编译安装Linux环境时，遇到一个问题：
WEB服务器是apache，数据库是MySQL。
于是写了一个测试连接数据库的PHP页面：
`$mysql = mysql_connect('localhost','root','');`
打开 http://localhost/test.php 测试
提示：`Can’t connect to local MySQL server through socket...`
检查环境正常
以为是数据库没有启动，于是查看一下进程，MySQL在进程里，重启了一下MySQL.
使用mysql -u root -p 可以进入MySQL操作界面
直接使用/usr/local/php5/bin/php /web/test.php执行可以连上数据库
apache也重启了，一样无效
疑点：为何网页执行失败，命令执行却成功
这下就郁闷了，使用php命令直接执行就成功，通过网页执行就失败。难道是apache导致？网上搜索了大堆资料也没找到解决方案，重新编译安装apache问题依旧。
把localhost改成127.0.0.1成功
把localhost改成127.0.0.1后竟然连接成功了，开始陷入思考困局：localhost失败127.0.0.1却成功？
ping localhost 地址是127.0.0.1没错
打开hosts加入
127.0.0.1 qttc
使用qttc当主机连接也正常，唯独就不认localhost。
localhost连接方式不同导致
为了了解PHP连接数据库时，主机填写localhost与其它的区别阅读了大量资料，最后得知：
当主机填写为localhost时mysql会采用 unix domain socket连接
当主机填写为127.0.0.1时mysql会采用tcp方式连接
这是linux套接字网络的特性，win平台不会有这个问题
<span style="color: #ff0000;">解决方法</span>
<span style="color: #ff0000;">在my.cnf的[mysql]区段里添加</span>
<span style="color: #ff0000;">protocol=tcp</span>
<span style="color: #ff0000;">保存重启MySQL，问题解决！</span>

原文链接：[http://www.qttc.net/201210228.html](http://www.qttc.net/201210228.html)