---
title: Android L 网络图标感叹号去除方法
tags:
  - Android 5.0
  - Android L
  - Exclamation mark
  - 感叹号
  - 网络
categories:
  - 网络相关
date: 2015-02-05 11:16:04
---

大致意思是Android 5.0连上WIFI后会访问 `clients3.google.com/generate_204` 这个网址

如果能正常访问, 则不会在通知栏出现 "此WIFI需要登录才能使用"

而你也知道, 谷歌在国内基本是不能访问的

所以找一个替换一下就OK了

`clients3.google.com/generate_204` 会给你返回一个204状态, 你也可以自己搭建一个这样的服务

解决方法(无需root):

1. 完全屏蔽网络检查功能, 最简单快速, 但是就没有办法提示wifi登录:
`adb shell "settings put global captive_portal_detection_enabled 0"`
2. 使用g.cn替换掉被墙的google服务器:
`adb shell "settings put global captive_portal_server g.cn"`
上面的方法需要电脑执行adb命令, 当然你也可以在手机上安装类似本地Shell的APP执行:
`settings put global captive_portal_server g.cn`

btw: g.cn中的g.cn/generate_204也同样会返回204状态所以建议使用