---
title: Open vSwitch 错误记录。
tags:
  - errors
  - OpenvSwitch
  - rpmbuild
id: 577
categories:
  - 网络相关
date: 2014-01-06 13:24:06
---

1. 
```
rpmbuild -bb rhel/openvswitch-kmod-rhel6.spec

produces warning:
Installed (but unpackaged) file(s) found:
/etc/depmod.d/openvswitch.conf
```
解决方法:

在openvswitch-kmod-rhel6.spec末尾出添加
```
%files
%defattr(-,root,root,-)
/etc/depmod.d/openvswitch.conf
```