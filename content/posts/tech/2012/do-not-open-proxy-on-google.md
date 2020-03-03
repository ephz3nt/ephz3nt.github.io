---
title: 不开代理上谷歌。
tags:
  - Google
  - 代理
  - 谷歌
id: 250
categories:
  - 网络相关
date: 2012-02-07 22:44:13
---

国内的www.google.com.hk虽然一般情况下都可以打开，但是搜索了几下就无法打开了，不知道可能是搜索了不和谐内容还是什么的

方法比较简单，上不了的时候就

ping一下 gmail.com
```
C:\WINDOWS>ping gmail.com

Pinging gmail.com [74.125.71.18] with 32 bytes of data:

Reply from 74.125.71.18: bytes=32 time=49ms TTL=50
Reply from 74.125.71.18: bytes=32 time=46ms TTL=50
```

取74.125.71.18直接在浏览器输入 - 回车

ping 谷歌其他站点也是可以的呵呵

```
C:\WINDOWS>ping code.google.com

Pinging code.l.google.com [74.125.71.101] with 32 bytes of data:

Reply from 74.125.71.101: bytes=32 time=48ms TTL=50
Reply from 74.125.71.101: bytes=32 time=44ms TTL=50
```