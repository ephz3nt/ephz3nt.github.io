---
title: 小内存VPS优化(LNMP+WordPress环境)
tags:
  - eAccelerator
  - LNMP
  - Ubuntu
  - wordpress
  - 优化
  - 小内存VPS
id: 377
categories:
  - 网络相关
date: 2013-03-01 21:35:25
---

之前的服务商跑路了,2个站 一个博客和一个论坛 没备份 懒 .直到现在才后悔莫及 备份是1年前的,悲剧了 换了个VR的San Jose机房速度还可以 256M的内存然后把1年前的备份放上去了,用了几天空闲内存总是剩个1-2十M 有些担心,网上查了查 于是决定还是优化下

我现在的系统配置是:

双核,256M内存,Ubuntu系统,军哥的Lnmp

1.充分利用多核

修改Nginx的配置文件,默认是没有被配置的,文件位置在/usr/local/nginx/conf/nginx.conf
```
worker_processes 2;


worker_cpu_affinity 01 10;
worker_processes :有多少核就填几了

worker_cpu_affinity : 同上,这里我是2核所以就是 01 10,如果是4核
worker_processes 4;
```

worker_cpu_affinity 0001 0010 0100 1000;(第一个进程对应的CPU核心,第二个,第三个...)
[![nginx](/images/2013/03/nginx-150x150.jpg)](/images/2013/03/nginx.jpg)

顺序要搞清楚[
](/images/2013/03/nginx.jpg)

填到 user www www;下面就好,如上图

2.安装eAccelerator

lnmp安装目录默认有带的

直接进入LNMP安装目录输入
```
./eaccelerator.sh
```
接下来会提示安装的版本,输入new 然后等等就装好了

再找到php的配置文件/usr/local/php/etc/php.ini

拉到这下面有eaccelerator针对PHP的配置文件,这是我的配置
```
[eaccelerator]

zend_extension="/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/eaccelerator.so"

eaccelerator.shm_size="16"

eaccelerator.cache_dir="/usr/local/eaccelerator_cache"

eaccelerator.enable="1"

eaccelerator.optimizer="1"

eaccelerator.check_mtime="1"

eaccelerator.debug="0"

eaccelerator.filter=""

eaccelerator.shm_max="0"

eaccelerator.shm_ttl="3600"

eaccelerator.shm_prune_period="3600"

eaccelerator.shm_only="0"

eaccelerator.compress="1"

eaccelerator.compress_level="9"

eaccelerator.keys = "disk_only"

eaccelerator.sessions = "disk_only"

eaccelerator.content = "disk_only"
```
主要就是eaccelerator.shm_size 这个参数了,就是eaccelerator用来缓存的内存大小,我只有256就给小点了,

完了记得要重启lnmp

3.给Wordpress安装Wp-super-cache

装完给启用就差不多了

[![Wp-super-cache](/images/2013/03/Wp-super-cache-300x195.jpg)](/images/2013/03/Wp-super-cache.jpg)