---
title: "snap 设置HTTP代理"
date: 2020-08-22T20:58:13+08:00
tags:
  - snap
categories:
  - 网络相关
---

> 这里由于我用的是V2RAY, 代理端口 "12333"

```shell
sudo snap set system proxy.http="http://127.0.0.1:12333"
sudo snap set system proxy.https="http://127.0.0.1:12333"
```

![](snap-set-proxy.assets/snap-install.png)

酸爽！

