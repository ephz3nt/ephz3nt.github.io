---
title: Ubuntu永久禁止Ping。
tags:
  - Ubuntu
  - 禁止Ping
id: 283
categories:
  - 网络相关
date: 2012-02-15 21:48:03
---

1. `echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all`
2. 添加上面的规则到启动脚本rc.local

`vi /etc/rc.local`

保存后重启之后也会生效。