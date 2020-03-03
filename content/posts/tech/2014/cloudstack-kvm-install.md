---
title: CloudStack 4.2.1+KVM部署实战。
tags:
  - CentOS
  - CloudStack
  - KVM
  - 安装
id: 602
categories:
  - 网络相关
date: 2014-03-20 16:16:44
---

拓扑图：

[ ![Topology](/images/2014/Topology.png)](/images/2014/Topology.png)

相关说明：

系统都为CentOS6.4 x64

Management端不需要任何虚拟化的支持，只是做WEB控制台和管理用，任意机器即可

Agent端的CPU需要虚拟化支持，我这里用的是R710，已开启VT并且cpu支持flag:vmx

主存储和二级存储都放在Agent端<!--more-->

配置网络：
```
[root@management ~]# cat /etc/sysconfig/network-scripts/ifcfg-eth1
DEVICE=eth1
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.10.16.250
NETMASK=255.255.255.0
GATEWAY=10.10.16.254
DNS1=8.8.4.4
```
```
[root@management ~]# ifconfig
eth1      Link encap:Ethernet  HWaddr 00:1D:60:E4:01:F2  
          inet addr:10.10.16.250  Bcast:10.10.16.255  Mask:255.255.255.0
          inet6 addr: fe80::21d:60ff:fee4:1f2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:31460 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9113 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:25547046 (24.3 MiB)  TX bytes:704232 (687.7 KiB)
          Interrupt:18 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)```
```
```
[root@agent ~]# cat /etc/sysconfig/network-scripts/ifcfg-em2
DEVICE=em2
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.10.16.253
NETMASK=255.255.255.0
GATEWAY=10.10.16.254
DNS1=8.8.4.4
```
```
[root@agent ~]# ifconfig
em2       Link encap:Ethernet  HWaddr 78:2B:CB:64:B7:A2  
          inet addr:10.10.16.253  Bcast:10.10.16.255  Mask:255.255.255.0
          inet6 addr: fe80::7a2b:cbff:fe64:b7a2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:189 errors:0 dropped:0 overruns:0 frame:0
          TX packets:58 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:19800 (19.3 KiB)  TX bytes:6460 (6.3 KiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
```
清空防火墙（两台都需要）：
```
[root@management ~]# iptables  -F
[root@management ~]# service  iptables  save
iptables: Saving firewall rules to /etc/sysconfig/iptables: [  OK  ]
```
配置NTP：

management：
```
[root@management ~]# yum -y install ntp
```
编辑/etc/ntp.conf，找到server部分，修改如下（把management做NTP服务器，不从互联网更新，也可参考其他配置或者事先从网络更新一下）：
```
#server 0.rhel.pool.ntp.org iburst
#server 1.rhel.pool.ntp.org iburst
#server 2.rhel.pool.ntp.org iburst
#server 3.rhel.pool.ntp.org iburst
server 127.127.1.0
fudge 127.127.1.0 stratum 10
```
```
[root@management ~]# service ntpd restart
Shutting down ntpd:                                        [  OK  ]
Starting ntpd:                                             [  OK  ]
[root@management ~]# chkconfig ntpd on
```
agent：
```
[root@agent ~]# yum -y install ntp
```
编辑/etc/ntp.conf，找到server部分，修改如下：
```
#server 0.rhel.pool.ntp.org iburst
#server 1.rhel.pool.ntp.org iburst
#server 2.rhel.pool.ntp.org iburst
#server 3.rhel.pool.ntp.org iburst
server 10.10.16.250
```
```
[root@management ~]# service ntpd restart
Shutting down ntpd:                                        [  OK  ]
Starting ntpd:                                             [  OK  ]
[root@management ~]# chkconfig ntpd on
```
重启网络和关闭SELINUX、hosts文件添加住被控IP和主机名（2台都需要）
```
[root@management ~]# service network restart
Shutting down interface eth1:                              [  OK  ]
Shutting down loopback interface:                          [  OK  ]
Bringing up loopback interface:                            [  OK  ]
Bringing up interface eth1:                                [  OK  ]

[root@agent ~]# service network restart
Shutting down interface em2:                               [  OK  ]
Shutting down loopback interface:                          [  OK  ]
Bringing up loopback interface:                            [  OK  ]
Bringing up interface em2:                                 [  OK  ]

[root@agent ~]# cat /etc/selinux/config 
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#	enforcing - SELinux security policy is enforced.
#	permissive - SELinux prints warnings instead of enforcing.
#	disabled - SELinux is fully disabled.
SELINUX=disabled
# SELINUXTYPE= type of policy in use. Possible values are:
#	targeted - Only targeted network daemons are protected.
#	strict - Full SELinux protection.
SELINUXTYPE=targeted

[root@management ~]# hostname --fqdn
management
[root@management ~]# cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.10.16.250    management
10.10.16.253    agent
```
添加源：

只需要默认源和cloudstack源即可，由于网速太慢，我事先准备了另外一台服务器做本地源

[![repo](/images/2014/repo.png)](/images/2014/repo.png)
```
[root@management ~]# cat /etc/yum.repos.d/1.repo 
[rhel]
name=rhel
baseurl=http://10.10.16.100/repo/rhel
enable=1
gpgcheck=0
[cloudstack]
name=cloudstack
baseurl=http://10.10.16.100/repo/cloudstack
enable=1
gpgcheck=0
```
更新重启：
```
[root@management ~]# yum -y update;reboot
[root@agent ~]# yum -y update;reboot
```
配置management端：

安装MYSQL：
```
[root@management ~]# yum -y install mysql-server
[root@management ~]# service mysqld start
[root@management ~]# chkconfig mysqld on
```
设置MYSQL密码：
```
[root@management ~]# mysql_secure_installation
```
这里我的mysql密码为：cloudstack

安装management：
```
[root@management ~]# yum -y install cloudstack-management
```
等待ing：

[![install-management](/images/2014/install-management.png)](/images/2014/install-management.png)

导入数据库：
```
[root@management ~]# cloudstack-setup-databases 新建的数据库帐号:密码@主机名 --deploy-as=root:mysql管理员密码
```
[![setup-database](/images/2014/setup-database.png)](/images/2014/setup-database.png)

设置cloudstack用户对/var/log/cloudstack*日志目录的访问权限（不然会无法启动）：
```
[root@management ~]# chown -R cloud:cloud /var/log/cloudstack*
```
cloud账户为安装management时自动创建的，用于运行相关服务 。

初始化management服务：
```
[root@management ~]# cloudstack-setup-management 
Starting to configure CloudStack Management Server:
Configure sudoers ...         [OK]
Configure Firewall ...        [OK]
Configure CloudStack Management Server ...[OK]
CloudStack Management Server setup is Done!
[root@management ~]# netstat -antp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address               Foreign Address             State       PID/Program name   
tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN      941/sshd            
tcp        0      0 127.0.0.1:25                0.0.0.0:*                   LISTEN      1018/master         
tcp        0      0 0.0.0.0:3306                0.0.0.0:*                   LISTEN      1272/mysqld         
tcp        0     52 10.10.16.250:22             10.10.16.220:57436          ESTABLISHED 1052/sshd           
tcp        0      0 :::51022                    :::*                        LISTEN      2193/java           
tcp        0      0 :::48686                    :::*                        LISTEN      2193/java           
tcp        0      0 :::8080                     :::*                        LISTEN      2193/java           
tcp        0      0 :::22                       :::*                        LISTEN      941/sshd            
tcp        0      0 ::1:25                      :::*                        LISTEN      1018/master         
tcp        0      0 :::45219                    :::*                        LISTEN      2193/java           
tcp        0      0 :::7080                     :::*                        LISTEN      2193/java           
tcp        0      0 ::1:55059                   ::1:34910                   TIME_WAIT   -
```
如上，8080 WEB控制台已经正常启动，

访问`http://10.10.16.250:8080/client` 默认帐号：admin 密码：password

[![dashboard](/images/2014/dashboard.png)](/images/2014/dashboard.png)

配置NFS服务：

之前说了，我准备把主存储和二级存储都放agent，所以在agent上安装NFS
```
[root@agent ~]# yum -y install nfs-utils
```
挂载磁盘：
```
[root@agent ~]# mkdir -p /storage/{primary,secondary}
[root@agent ~]# mount /dev/sdb /storage/secondary/
[root@agent ~]# mount /dev/sdc /storage/primary/
```
```
[root@agent ~]# df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        20G 1003M   18G   6% /
tmpfs            56G     0   56G   0% /dev/shm
/dev/sdb        135G  188M  128G   1% /storage/secondary
/dev/sdc        3.6T  197M  3.4T   1% /storage/primary
```
我对cloudstack存储的理解：

主存储存放VM文件和磁盘文件

辅助存储存放ISO镜像和系统模板

记得添加开机自动挂载

[![fstab](/images/2014/fstab.png)](/images/2014/fstab.png)

编辑/etc/exports 添加NFS共享信息：
```
[root@agent ~]# vim /etc/exports 
/storage/primary        *(rw,async,no_root_squash)
/storage/secondary      *(rw,async,no_root_squash)
```
启动NFS服务：
```
[root@agent ~]# service rpcbind start
Starting rpcbind:                                          [  OK  ]
[root@agent ~]# chkconfig rpcbind on
[root@agent ~]# service nfs start
Starting NFS services:                                     [  OK  ]
Starting NFS mountd:                                       [  OK  ]
Starting NFS daemon:                                       [  OK  ]
Starting RPC idmapd:                                       [  OK  ]
[root@agent ~]# chkconfig nfs on
```
在management测试nfs是否工作正常：
```
[root@management ~]# showmount -e 10.10.16.253
Export list for 10.10.16.253:
/storage/secondary *
/storage/primary   *
```
能正常显示则OK；

management端导入KVM系统模板(用于cloudstack系统VM)：

我之前用官方的一直不正常，推荐使用下方地址的模板

可以在[http://jenkins.buildacloud.org/job/build-systemvm64-master/](http://jenkins.buildacloud.org/job/build-systemvm64-master/) 这里下载

[![systemvm-template](/images/2014/systemvm-template.png)](/images/2014/systemvm-template.png)

挂载NFS二级存储（之前讲过是放系统模板和ISO用）：
```
[root@management ~]# mount 10.10.16.253:/storage/secondary /opt
```
导入系统VM模板：
```
[root@management ~]# /usr/share/cloudstack-common/scripts/storage/secondary/cloud-install-sys-tmplt -m NFS挂载二级存储的路径 -f 系统模板文件路径 -h 虚拟化平台名称 -F
```
[![import-systemvm-template](/images/2014/import-systemvm-template.png)](/images/2014/import-systemvm-template.png)

等待。。。

导入完毕后卸载二级存储：
```
[root@management ~]# umount /opt
```
进入WEB管理界面点击”我以前使用过 CloudStack，跳过此指南“，进入全局设置选项

设置存储所在网段：

[![secstorage](/images/2014/secstorage.png)](/images/2014/secstorage.png)

设置延时时间（删除VM等等操作的延时）：

[![expunge](/images/2014/expunge.png)](/images/2014/expunge.png)

重启management：
```
[root@management ~]# service cloudstack-management restart
Stopping cloudstack-management:                            [  OK  ]
Starting cloudstack-management:                            [  OK  ]
```
配置Agent：

安装qemu等组件支持，不然待会添加主机会加不上；
```
[root@agent ~]# yum -y install qemu* virt* libvirt*
```
[![install-qemu](/images/2014/install-qemu.png)](/images/2014/install-qemu.png)
```
[root@agent ~]# yum -y install cloudstack-agent
```
编辑/etc/libvirt/qemu.conf找到vnc_listen = "0.0.0.0"取消注释

[![qemu](/images/2014/qemu.png)](/images/2014/qemu.png)

编辑/etc/cgconfig.conf添加：
```
group virt {
cpu {
cpu.shares = 9216;
}
}
```
[![cgconfig](/images/2014/cgconfig.png)](/images/2014/cgconfig.png)

启动服务：
```
[root@agent ~]# service cgconfig start
Starting cgconfig service:                                 [  OK  ]
[root@agent ~]# service libvirtd restart
Stopping libvirtd daemon:                                  [  OK  ]
Starting libvirtd daemon:                                  [  OK  ]
[root@agent ~]# chkconfig cgconfig on
[root@agent ~]# chkconfig libvirtd on
```
注意：此时cloudstack-agent服务不需要启动，management添加该主机时会自动启动

访问http://10.10.16.250:8080/client management端开始配置cloudstack：

[![cloudstack-1](/images/2014/cloudstack-1.png)](/images/2014/cloudstack-1.png)

修改新密码继续：

[![cloudstack-pass](/images/2014/cloudstack-pass.png)](/images/2014/cloudstack-pass.png)

区域类似一个数据中心；

[![add-area](/images/2014/add-area.png)](/images/2014/add-area.png)

添加提供点：我的理解是给CloudStack内部系统用的IP，如系统VM

[![add-offer](/images/2014/add-offer.png)](/images/2014/add-offer.png)

来宾网络：我的理解是给我们创建的VM用的IP

[![add-guest-network](/images/2014/add-guest-network.png)](/images/2014/add-guest-network.png)

[![add-cluster](/images/2014/add-cluster.png)](/images/2014/add-cluster.png)

添加主机：就是添加agent端，输入IP、用户名和密码即可

[![add-host](/images/2014/add-host.png)](/images/2014/add-host.png)

[![add-primary](/images/2014/add-primary.png)](/images/2014/add-primary.png)

[![add-secondary](/images/2014/add-secondary.png)](/images/2014/add-secondary.png)

最后点击启动，等待数分钟

[![cs-successfully](/images/2014/cs-successfully.png)](/images/2014/cs-successfully.png)

点击启动后可进入主面板，可查看agent配置信息和相关资源使用信息

[![cs-dashboard](/images/2014/cs-dashboard.png)](/images/2014/cs-dashboard.png)

点击“基本架构”，可查看相关信息

[![cs-base](/images/2014/cs-base.png)](/images/2014/cs-base.png)

点击系统VM下的“查看全部”可看到系统VM的状态，都为running+up则表示正常

[![systemvm-satate](/images/2014/systemvm-satate.png)](/images/2014/systemvm-satate.png)

至此CloudStack Management Agent分离安装完毕，如果有任何批评和疑问请在此提出。