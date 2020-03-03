---
title: IP网络存储iSCSI小试。
tags:
  - CentOS
  - iSCSI
  - 网络存储
id: 531
categories:
  - 网络相关
date: 2013-10-28 02:41:16
---

iSCSI技术是一种由IBM公司研究开发的，是一个供硬件设备使用的可以在IP协议的上层运行的SCSI指令集，这种指令集合可以实现在IP网络上运行SCSI协议，使其能够在诸如高速千兆以太网上进行路由选择。iSCSI技术是一种新储存技术，该技术是将现有SCSI接口与以太网络(Ethernet)技术结合，使服务器可与使用IP网络的储存装置互相交换资料。(详见百科)

搭建环境：

177.208.11.199 iSCSI-Enterprise-Target - CentOS6.4 - 32
177.208.11.234 iSCSI-initiator-utils - CentOS6.4 - 32
177.208.11.103 iSCSI-Initiator - Windows Server 2003 Enterprise Edition SP2

以下以IP后3位为简称吧

199为iSCSI服务端，其他2台分别为客户端，我这里的服务端只是测试用所以只有一块普通的硬盘，如果用户生产环境的话可能需要做一些集群或者RAID之类的，现在开始吧。

首先在199(Target端)安装服务端软件：

你可以在官方网站获取：[http://iscsitarget.sf.net](http://iscsitarget.sf.net/)

```
[root@localhost ~]# tar zxvf iscsitarget-1.4.20.2.tar.gz
[root@localhost ~]# cd iscsitarget-1.4.20.2
[root@localhost iscsitarget-1.4.20.2]# make
```
这里我编译报错：
```
make[1]: Leaving directory `/root/iscsitarget-1.4.20.2/usr'
make -C /lib/modules/2.6.32-358.14.1.el6.i686/build SUBDIRS=/root/iscsitarget-1.4.20.2/kernel modules
make: *** /lib/modules/2.6.32-358.14.1.el6.i686/build: No such file or directory.  Stop.
make: *** [kernel] Error 2
```
安装kernel-devel和patch
```
[root@localhost iscsitarget-1.4.20.2]# yum -y install kernel kernel-devel patch
[root@localhost iscsitarget-1.4.20.2]# reboot
```
```
[root@localhost iscsitarget-1.4.20.2]# rm -rf /lib/modules/`uname -r`/build
[root@localhost iscsitarget-1.4.20.2]# ln -s /usr/src/kernels/2.6.32-358.23.2.el6.i686/ /lib/modules/`uname -r`/build
[root@localhost iscsitarget-1.4.20.2]# make clean
[root@localhost iscsitarget-1.4.20.2]# make
[root@localhost iscsitarget-1.4.20.2]# make install
```

现在iscsitarget就已经安装好了，配置文件位置在: /etc/iet/ietd.conf
编辑该配置文件找到类似 Target iqn.2001-04.com.example:storage.disk2.sys1.xyz 行取消注释

![iscsi-conf1](/images/2013/10/iscsi-conf1.jpg)

命名格式：`iqn.yyyy-mm.<recversed domain name(倒过来写的域名)>[:identifier]`
如：`Target iqn.2013-10.net.hacache.iscsi:storage.disk2.sys1.xyz`
找到类似` Lun 0 Path=/dev/sdc,Type=fileio,ScsiId=xyz,ScsiSN=xyz `行取消注释
`Lun 0 Path=/dev/sdc`，表示块设备0，映射的磁盘为/dev/sdc ，简单来说把/dev/sdc修改成你自己需要共享出去的磁盘路径就好了。
如：`Lun 0 Path=/dev/xvde,Type=fileio,ScsiId=xyz,ScsiSN=xyz`

```
[root@localhost iscsitarget-1.4.20.2]# service iscsi-target restart

Stopping iSCSI Target: Connection refused.
ietd: no process killed
                                                           [FAILED]
Starting iSCSI Target:                                     [  OK  ]
```



iSCSI-Target服务默认端口3260

这样一台简单的iSCSI服务器就已经搭建好了，现在我们来分别在windows和linux上添加target端(199)的磁盘

Windows：

需要安装iSCSI Initiator

可以在这里获取：[http://www.microsoft.com/en-us/download/details.aspx?id=18986](http://www.microsoft.com/en-us/download/details.aspx?id=18986)

选择相应的版本下载和安装完毕打开桌面上的Microsoft iSCSI Initiator

[![iscsi-win](/images/2013/10/iscsi-win-300x263.jpg)](/images/2013/10/iscsi-win.jpg)
如图，选择Discovery选项在Target Portals部分单击add按钮，输入iSCSI Target端的IP地址再单击OK即可

然后在Targets选项卡已经可以看到检测出的iSCSI Target的名称了但是还是inactive的状态

[![iscsi-win2](/images/2013/10/iscsi-win2-300x285.jpg)](/images/2013/10/iscsi-win2.jpg)
点击Log On按钮再次点击确定，现在已经变成Connected状态了

[![iscsi-win3](/images/2013/10/iscsi-win3-251x300.jpg)](/images/2013/10/iscsi-win3.jpg)

现在你已经可以在windows的磁盘管理器中对新添加的共享磁盘进行分区、格式化等操作了。

[![iscsi-win4](/images/2013/10/iscsi-win4-300x209.jpg)](/images/2013/10/iscsi-win4.jpg)

Linux：

Linux中也同样需要安装客户端软件，在CentOS中可使用yum进行安装
```
[root@centos5 ~]# yum -y install iscsi-initiator-utils*
```



可以使用 rpm -ql iscsi-initiator-utils 来查看它安装了哪些程序

iscsi-initiator-utils使用比较多的就是iscsiadm命令了

现在开始挂载Target端的共享磁盘

使用 iscsiadm -m discovery --type sendtargets --portal IP地址 来搜索iSCSI Target主机划分了哪些lun

[![iscsiadm](/images/2013/10/iscsiadm-300x77.jpg)](/images/2013/10/iscsiadm.jpg)


如图，已经搜索出来了我在199上共享出来的磁盘，现在开始连接它

可以使用  iscsiadm -m node -T [target-name] -p [ip-address] -l 格式连接

如：iscsiadm -m node -T iqn.2013-10.net.hacache.iscsi:storage.disk2.sys1.xyz -p 177.208.11.199 -l

[![iscsiadm1](/images/2013/10/iscsiadm1-300x69.jpg)](/images/2013/10/iscsiadm1.jpg)

可以看到图中我已经连接成功了，

[![iscsiadm2](/images/2013/10/iscsiadm2-300x190.jpg)](/images/2013/10/iscsiadm2.jpg)

使用fdisk -l 可以看到我已经多出了一块名为sdb的64G的磁盘

其他配置：

iSCSI-Target主机以IP认证方式获取资源

编辑/etc/iet/ietd.conf
```
Target iqn.2013-10.net.hacache.iscsi:xvde1
Lun 0 Path=/dev/xvde1,Type=fileio
Target iqn.2013-10.net.hacache.iscsi:xvde2
Lun 0 Path=/dev/xvde2,Type=fileio
Target iqn.2013-10.net.hacache.iscsi:xvde3
Lun 0 Path=/dev/xvde3,Type=fileio
```
编辑/etc/iet/initiator.allow

注释掉ALL.ALL

添加如下格式的配置重启服务即可完成基于IP的资源验证
```
iqn.2013-10.net.hacache.iscsi:xvde1 192.168.0.11
iqn.2013-10.net.hacache.iscsi:xvde2 192.168.0.12
iqn.2013-10.net.hacache.iscsi:xvde3 177.208.11.68
```