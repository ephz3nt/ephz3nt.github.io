---
title: CentOS桌面环境安装
tags:
  - CentOS
  - 桌面环境
id: 500
categories:
  - 网络相关
date: 2013-09-30 12:41:48
---

由于历史悠久，本篇文章图片已失效

***

#### 测试环境 CentOS6.4 64位

#### 首先需要安装桌面环境包

```
yum -y groupinstall "KDE Desktop"
yum -y groupinstall "X Window System"
```

#### 默认源里好像只有KDE需要GNOME的可自行GOOGLE

#### 等待安装完毕

安装完毕后再安装一下语言支持
`yum -y groupinstall "Chinese Support"`

装VNC
`yum -y install tigervnc-server`

编辑一下配置文件
`vim /etc/sysconfig/vncservers`
修改如图

输入vncpasswd设置管理密码

启动服务

现在你已经可以使用vnc client来连接你的服务器了

这里使用的是TigerVNC,你可以去官方下载：[http://www.tightvnc.com/download.php](http://www.tightvnc.com/download.php)

官方默认是安装包（服务端和客户端一起的）

设置桌面语言

选择左下CENTOS图标-点击`System Settings`

进入面板后选择 `Regional Language`

点击`Add Lanuage`下拉菜单的`Simplified Chinese(简体中文)`

然后点击右下的`Apply`按钮应用，这时候系统会提示你需要重启 按照它说的办吧！

OK现在已经全部显示成中文了，高端大气上档次！