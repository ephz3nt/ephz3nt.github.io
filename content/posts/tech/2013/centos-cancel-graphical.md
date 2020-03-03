---
title: CentOS取消图形化界面及进度条。
tags:
  - CentOS
  - 取消
  - 图形化
  - 进度条
id: 411
categories:
  - 网络相关
date: 2013-05-14 09:13:47
---

新版的CentOS启动方式改成了以图形化进度条的形式启动系统，非常不利于新手学习LINUX，所以建议取消掉，采用正常的命令行形式启动。
```
vi /boot/grub/grub.conf


default=0

timeout=5

splashimage=(hd0,0)/boot/grub/splash.xpm.gz

hiddenmenu

title centos (2.6.32-71.el6.i686)

root (hd0,0)

kernel /boot/vmlinuz-2.6.32-71.el6.i686 ro root=UUID=0ecaaa50-2f52-490b-a9b5-a22918c9f485 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYBOARDTYPE=pc KEYTABLE=us crashkernel=auto rhgb quiet

initrd /boot/initramfs-2.6.32-71.el6.i686.img
```
把上方红色字体部分删除`rhgb`（redhat graphics boot）保存即可

另外如果想取消图形化界面的可以更改init运行级别
```
vi /etc/inittab


id:5:initdefault:
```
把上方的5改为3即可

init级别：

- 0 - 停机(千万不能把initdefault 设置为0)
- 1 - 单用户模式
- 2 - 多用户，没有 NFS
- 3 - 完全多用户模式(标准的运行级)
- 4 - 没有用到
- 5 - X11 （xwindow)
- 6 - 重新启动 （千万不要把initdefault 设置为6 ）