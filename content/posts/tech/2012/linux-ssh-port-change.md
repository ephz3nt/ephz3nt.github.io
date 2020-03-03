---
title: Linux ssh端口更改。
tags:
  - Linux
  - SSH
  - 端口修改
id: 369
categories:
  - 网络相关
date: 2012-09-02 12:12:15
---

为了防止一些蛋疼的人暴力破解SSH密码啥啥的，还是建议大家把SSH端口改一下：

vi /etc/ssh/sshd_config<!--more-->

[![](/images/2012/09/ssh-300x217.jpg "ssh")](/images/2012/09/ssh.jpg)

图中port 22就是了可以把22修改成自己想要的端口，完了之后重启一下就O了。