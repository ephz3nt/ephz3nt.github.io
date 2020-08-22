---
title: "Manjaro 添加自定义快捷方式"
date: 2020-08-22T21:19:42+08:00
tags: 
  - manjaro
  - shortcut
categories:
  - Linux
---

今天装了个Goland, 由于没有像Ubuntu那样的deb包导致每次启动都需shell进相应目录执行

```shell
./goland.sh
```

非常麻烦

稍微找了下资料

首先进入 "/usr/share/applications" 目录, 可以看到里面有很多的 .desktop 文件, 这就是快捷方式文件了

可以随便找一个复制出来, 如:

```shell
sudo cp idea.desktop goland.desktop
```

文件大概长这样, 怎么改一目了然了 路径按照自己实际目录修改就行.

> goland.desktop

```shell
[Desktop Entry]
Version=1.0
Type=Application
Name=Goland
Comment=Develop with pleasure!
Exec=/home/ephz3nt/Downloads/GoLand-2020.2.2/bin/goland.sh %f
Icon=/home/ephz3nt/Downloads/GoLand-2020.2.2/bin/goland.png
Terminal=false
StartupNotify=true
StartupWMClass=jetbrains-goland
Categories=Development;IDE;Go;
```

顺便贴一下Typora的配置吧, 正好今天在用 

```shell
[Desktop Entry]
Version=1.0
Type=Application
Name=Typora
Comment=Typora Markdown Editor
Exec=/home/ephz3nt/Downloads/Typora-linux-x64/Typora %f
Icon=/home/ephz3nt/Downloads/Typora-linux-x64/resources/app/asserts/icon/icon_128x128.png
Terminal=false
StartupNotify=true
#StartupWMClass=jetbrains-goland
Categories=Development;Markdown;Typora;
```

![image-20200822212806112](manjaro-custom-shortcut.assets/image-20200822212806112.png)

![image-20200822212825943](manjaro-custom-shortcut.assets/image-20200822212825943.png)