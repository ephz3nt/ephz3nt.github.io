---
title: Nginx 301域名重定向。
tags:
  - '301'
  - Nginx
  - 域名重定向
id: 441
categories:
  - 网络相关
date: 2013-06-18 16:55:21
---

闲来无事又整了几个电影站，资源空着也是空着，把设置301域名重定向规则记录下来，省的每次都Google；

在Nginx虚拟主机配置文件的server段中添加如下配置：

```
server_name domain.com www.domain.com;
if ($host != 'www.domain.com' ) {
rewrite ^/(.*) http://www.domain.com/1 permanent;
}
```

访问domain.com重定向到www.domain.com;

```
nginx -t
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
service nginx reload
OK..
```

