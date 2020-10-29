---
author: "ephz3nt"
date: 2020-10-29
title: Vue上传阿里云OSS问题
tags:
  - Vue
  - 阿里云
  - OSS
---

前段时间部署前端同事的 Vue 代码遇到的，记录一下。

### 问题概述

前端同事在`vue.config.js`配置了 OSS 的 proxy

```javascript
    "/ossUpload": {
        target: "https://xxx-proj.oss-cn-shanghai.aliyuncs.com",
        changeOrigin: true,
        ws: true,
        pathRewrite: {
            "^/ossUpload": "",
        },
    },
```

由于 Vue 编译后为纯静态文件，导致我部署到 Nginx 访问不到这个`/ossUpload`路径，于是只能加个`proxy_pass`规则。

```
      location ^~/ossUpload {
        proxy_pass https://xxx-proj.oss-cn-shanghai.aliyuncs.com/;
```

加上后发现上传报错，直接在 Vue 启动开发模式发现上传 OSS 的状态码是`204`, 看到这个想到`websocket`的配置需要设置`http_upgrade`的一些配置，于是配置上去正常上传了。
最终 Nginx 配置如下

```
      location ^~/ossUpload {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-NginX-Proxy true;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_pass https://xxx-proj.oss-cn-shanghai.aliyuncs.com/;
```

> 时间过去比较久， 一些细节忘记了 - -
