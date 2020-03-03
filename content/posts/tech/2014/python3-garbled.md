---
title: Python3方向键乱码问题。
tags:
  - Backspace
  - Python3
  - 方向键
id: 592
categories:
  - 网络相关
date: 2014-02-16 14:01:15
---

最近开始学习python,由于书中版本为3,所以重新安装了个3版本后发现运行后不管是方向键还是Backspace（退格键）都无法正常使用

[![python3](/images/2014/02/python3-300x80.png)](/images/2014/02/python3.png)

&nbsp;

查阅资料后发现原因是readline的问题

做下软连接重新启动正常

```
ln -s  /lib64/libreadline.so.6 /usr/lib64/
ln -s  /lib64/libreadline.so.6.0 /usr/lib/
ln -s  /lib64/libreadline.so.6.0 /usr/lib64/
```

如果还是不行就需要重新编译安装py了