---
title: Ubuntu永久修改主机名称。
tags:
  - Ubuntu
  - 修改主机名称
id: 279
categories:
  - 网络相关
date: 2012-02-15 21:34:20
---

* 修改etc下的hostname文件

`vi /etc/hostname`

a,第一行输入你的主机名称

`esc ,: ,x,`回车保存<!--more-->

* ` vi /etc/hosts`

第一行的 `localhost.localdomain    localhost`

修改成 如` www.baidu     baidu`

经实践，第二步可以忽略 (:E