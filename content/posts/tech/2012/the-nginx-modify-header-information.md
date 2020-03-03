---
title: Nginx修改Header信息。
tags:
  - Header
  - Nginx
  - 修改
id: 316
categories:
  - 网络相关
date: 2012-03-15 00:58:48
---

> Header信息是访客访问你的网站时，web服务返回给客户端的一段信息，包含了网页的一些基本情况。那么为什么要修改 header信息呢？主要是为了防止被居心不良的人利用来获取漏洞信息，例如：通过最最简单的获取Header信息发现你的web服务器版本是 nginx/1.0.13，现在又已知这个版本的nginx有某个漏洞，那么就可以利用这个漏洞来攻击你了。互联网信息更新非常快，web服务程序的更新 也是很频繁，我们很多时候由于种种原因不能及时打上补丁，对服务器安全很不利，如果修改header信息达到隐藏web服务器版本的效果，就可以在某种程 度上消除一些隐患。
> 首先需要修改nginx.h这个文件，一般在安装目录下面的src/core/nginx.h。因为之前我装的是LNMP一键安装包，所以就在LNMP目录下的nginx-x.x.x.x下面，

vi 编辑一下nginx.h/*

```
Copyright (C) Igor Sysoev

*/

ifndef NGINX_HINCLUDED_

define NGINX_HINCLUDED_

define nginx_version 1000010

define NGINX_VERSION "1.0.0.1"

define NGINX_VER "nginx/" NGINX_VERSION

define NGINX_VAR "NGINX"

define NGX_OLDPID_EXT ".oldbin"

endif /* NGINX_HINCLUDED_ */
```


只需要修改

`define NGINX_VERSION` 对应的版本值，不填的话留空 如""

`define NGINX_VER          "nginx/" NGINX_VERSION `  在这里"nginx/"  nginx/修改成你想显示的Server信息 /看不填，看个人需求。

编辑好以后回到NGINX安装目录下面输入：

```shell
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
```

再输入

`make`

编译完成后的NGINX文件在 objs文件夹下，先备份一下原来的
> cp /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx.bak
> 把新的NGINX文件复制过去，需先停止NGINX服务哦：service nginx stop
> cp objs/nginx /usr/local/nginx/sbin/
> service nginx start

2013.6.13更新：

有些按照上方操作还是无法修改Header信息，经查看还需要修改 安装目录下的src/http/ngx_http_header_filter_module.c

[![nginx-header-filter](/images/2012/03/nginx-header-filter-300x169.jpg)](/images/2012/03/nginx-header-filter.jpg)


如图，按照自己的喜好修改即可，这样设置完毕后发现出现默认Nginx 404页面时底部还是会显示nginx相关的信息，原因为nginx.conf里的server_tokens关闭，编辑nginx.conf找到server_tokens = off;将off改为on即可

大功告成。


[![nginx](/images/2012/03/nginx-300x110.jpg)](/images/2012/03/nginx.jpg)