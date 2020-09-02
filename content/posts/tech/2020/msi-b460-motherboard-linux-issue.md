---
title: "微星B460主板安装Linux"
date: 2020-09-02T20:14:05+08:00
tags: 
  - 微星
  - B460
  - RTL8125
categories:
  -
---

今天公司到了一台内网测试用服务器，想着直接装好`Ubuntu 16.04`配置好网络直接扔杂物间(没有机房，只能放那边挨着交换机)

没想到我的U盘直接认不到了，我是用`YUMI`把好几个系统装到U盘里的，我自己用的办公电脑是ok的，后面网上查了下说要吧BIOS里面的`UEFI`改成`CMS 兼容模式`，结果直接点不亮了。

没办法，拆开机箱取主板电池下来放电重新来

重新用`YUMI`把ISO刻到U盘后发现竟然神奇的可以了，兴奋的等待安装完毕后蛋疼的事情又来了。

装完后启动黑屏，我折腾了好一会才发现是进入系统黑屏，不是系统没装好。

之前我自己的办公电脑装也是这个样子，我尝试开机后按上下键在Ubuntu启动界面编辑启动项在后面加上`nomodeset`，貌似和显卡有关系。结果能看到启动的界面了，但是卡在磁盘扫描那边。

想着之前自己的办公电脑也差不多是这样，Manjaro、Archlinux 都不行，后面换`Linux Mint`完美运行。接着自己吧它也刻进去，进入到LiveCD桌面，点安装然后下一步下一步。。。到在线更新包的时候提示网络问题，`ifconfig`看了下就一块`lo`网卡，应该是找不到网卡驱动了，`lspci`看了下`ethernet`信息，网卡型号是`RTL8125 Realtek PCIe FE / GBE / 2.5G` ，我先跳过在线更新直接把系统先装了再说。

完事后在自己办公电脑从官网下载驱动 [https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software](https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software) 

选择`Unix (Linux)`下的`2.5G Ethernet LINUX driver r8125 for kernel up to 5.6` 下载后拷贝到U盘，然后插上服务器挂载，解压运行`./autorun.sh`正常执行完后运行`lsmod | grep 8125`应该就可以看到显示了。`ifconfig -a` 也能看到网卡信息。

> 安装驱动需要 `gcc kernel-dev`等包，如果没有的话需要先安装，我是正好有一个USB装RJ45的线。

接着配置好静态IP明天再部署环境。

