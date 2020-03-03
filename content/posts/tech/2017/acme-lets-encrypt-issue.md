---
title: 使用acme签发&续期 Let's Encrypt 证书。
tags:
  - acme.sh
  - Let's Encrypt
  - Nginx
  - 免费SSL
categories:
  - 网络相关
date: 2017-02-28 14:57:48
---

acme.sh 实现了 acme 协议, 可以从 letsencrypt 生成免费的证书.

使用它的原因是 acme.sh 支持DNS API方式签发证书,这可方便太多了

支持的DNS服务商有: cloudflare, dnspod, cloudxns, godaddy 以及 ovh 等数十种解析商的自动集成.

```shell
[root@ROOT ~]# ls .acme.sh/dnsapi/
dns_ad.sh         dns_cf.sh         dns_do.sh         dns_gd.sh         dns_linode.sh     dns_myapi.sh      dns_pdns.sh
dns_ali.sh        dns_cx.sh         dns_dp.sh         dns_ispconfig.sh  dns_lua.sh        dns_nsupdate.sh   README.md
dns_aws.sh        dns_cyon.sh       dns_freedns.sh    dns_lexicon.sh    dns_me.sh         dns_ovh.sh        
```

1. 获取acme.sh

   ```shell
   curl  https://get.acme.sh | sh
   ```

   将安装acme.sh至你当前账户根目录下的 .acme.sh下

   创建一个bash的alias, 方便直接使用acme.sh

   ```shell
   vim ~/.bashrc
   ```

   增加一行 `alias acme.sh=~/.acme.sh/acme.sh`

   ```shell
   # .bashrc

   # User specific aliases and functions
   alias acme.sh=~/.acme.sh/acme.sh
   alias rm='rm -i'
   alias cp='cp -i'
   alias mv='mv -i'
   ```

   执行 `source .bashrc`

   然后可直接执行 acme.sh 即可看到此工具的更多使用方法.

2. 签发证书

   我的域名DNS使用的是CloudXNS, 登录官网获取相关API参数即可

   执行

   ```shell
   export CX_Key="3739fb69fewfwefwe996b255f49dda"
   export CX_Secret="7745fwefewfew4c62"
   ```

   这里的 CX_Key & CX_Secret 为CloudXNS脚本变量名, 如果你是其他DNS服务商如Cloudflare,可查看 ~/.acme.sh/dnsapi/dns_cf.sh 得知相应DNSAPI的变量名称

   ```shell
   #!/usr/bin/env bash

   #
   #CF_Key="sdfsdfsdfljlbjkljlkjsdfoiwje"
   #
   #CF_Email="xxxx@sss.com"

   CF_Api="https://api.cloudflare.com/client/v4"

   ```

   执行签发证书命令

   ```shell
   acme.sh --issue --dns dns_cx -d xx1.example.com
   ```

   --issue 为签发

   --dns 为使用dns验证,后面跟上域名所属DNS服务商,Cloudxns 为 dns_cx , Cloudflare 为 dns_cf 具体名称可以参考前面说的.

   -d 申请签发域名, 可同时签发多个 如: -d a.example.com -d b.example.com -d c.example.com, 无需记录指向当前服务器, 所以你可以使用任何一台计算机签发

   ```shell
   [root@ROOT /]# acme.sh --issue --dns dns_cx -d a.example.com -d b.example.com -d c.example.com
   [Tue Feb 28 15:23:36 CST 2017] Multi domain='DNS:b.example.com,DNS:c.example.com'
   [Tue Feb 28 15:23:36 CST 2017] Getting domain auth token for each domain
   [Tue Feb 28 15:23:36 CST 2017] Getting webroot for domain='a.example.com'
   [Tue Feb 28 15:23:36 CST 2017] Getting new-authz for domain='a.example.com'
   [Tue Feb 28 15:23:39 CST 2017] The new-authz request is ok.
   [Tue Feb 28 15:23:39 CST 2017] Getting webroot for domain='b.example.com'
   [Tue Feb 28 15:23:39 CST 2017] Getting new-authz for domain='b.example.com'
   [Tue Feb 28 15:23:40 CST 2017] The new-authz request is ok.
   [Tue Feb 28 15:23:40 CST 2017] Getting webroot for domain='c.example.com'
   [Tue Feb 28 15:23:40 CST 2017] Getting new-authz for domain='c.example.com'
   [Tue Feb 28 15:23:42 CST 2017] The new-authz request is ok.
   [Tue Feb 28 15:23:42 CST 2017] Found domain api file: /root/.acme.sh/dnsapi/dns_cx.sh
   [Tue Feb 28 15:23:42 CST 2017] Adding record
   [Tue Feb 28 15:23:43 CST 2017] Sleep 120 seconds for the txt records to take effect
   [Tue Feb 28 15:25:44 CST 2017] a.example.com is already verified, skip dns-01.
   [Tue Feb 28 15:25:44 CST 2017] Verifying:b.example.com
   [Tue Feb 28 15:25:48 CST 2017] Success
   [Tue Feb 28 15:25:48 CST 2017] c.example.com is already verified, skip dns-01.
   [Tue Feb 28 15:25:50 CST 2017] Deleted record _acme-challenge.b.example.com
   [Tue Feb 28 15:25:50 CST 2017] Verify finished, start to sign.
   [Tue Feb 28 15:25:52 CST 2017] Cert success.
   -----BEGIN CERTIFICATE-----
   MIIFHDCCBASgAwIBAgISA2P67Iuu/0deP//XwhZsoihcMA0GCSqGSIb3DQEBCwUA
   MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
   ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0xNzAyMjgwNjI3MDBaFw0x
   NzA1MjkwNjI3MDBaMBgxFjAUBgNVBAMTDWEuZXBoemVudC5uZXQwggEiMA0GCSqG
   SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtmZSiVu6f27C7mxDZ2EwOszAps/e4K06A
   I9of7gkWCgT6T2Cvze9w0d8j+o9hHft+ppcgLLywmVH2XpadQ6h/+8VCJO1ZLHCH
   zEkXGn9FvqfAfs2bDvJHhIhYy7579jljEr86zwO0PsO8bqaJgPEO8lDJ+KY9Tfq2
   igsVZR79QtmTHimxI4t2liUnAt+pRn4z0mMWQvm247dlfI4h3TkqlSiyCo9Vn3dL
   ULaGBJ7zpTKsffgon79WfraE0nseMNE0vt0ASQew4TztNfswbHOF7fzTQLa2K1QT
   76thTc8FdmzkXeNqahncU0fWxK5eM+/HB0sHrFcmOFcckx97dEEBAgMBAAGjggIs
   MIICKDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUF
   BwMCMAwGA1UdEwEB/wQCMAAwHQYDVR0OBBYEFKsqhp5nOgaAkm8tIsHe3hQOUq/S
   MB8GA1UdIwQYMBaAFKhKamMEfd265tE5t6ZFZe/zqOyhMHAGCCsGAQUFBwEBBGQw
   r4Bc5gVW9hcTgyz8RYEGJFAuNbf6E4Iy7mMHkkTuS50E84X/CXP/cICvwA5aZszN
   W7RRqkwMeW9KbhNU0txCdA==
   -----END CERTIFICATE-----
   [Tue Feb 28 15:25:52 CST 2017] Your cert is in  /root/.acme.sh/a.example.com/a.example.com.cer 
   [Tue Feb 28 15:25:52 CST 2017] Your cert key is in  /root/.acme.sh/a.example.com/a.example.com.key 
   [Tue Feb 28 15:25:52 CST 2017] The intermediate CA cert is in  /root/.acme.sh/a.example.com/ca.cer 
   [Tue Feb 28 15:25:52 CST 2017] And the full chain certs is there:  /root/.acme.sh/a.example.com/fullchain.cer 
   ```

   签发完成

   安装证书

   ```shell
   acme.sh  --installcert  -d a.example.com -d b.example.com -d c.example.com \
           --keypath   /data/auth/server-key.pem \
           --fullchainpath /data/auth/server-cert.pem \
           --reloadcmd  "service nginx restart"
   ```

   上述路径&域名按需修改

3. 更新证书

   目前证书在 60 天以后会自动更新, 你无需任何操作. 今后有可能会缩短这个时间, 不过都是自动的, 你不用关心.

4. 更新 acme.sh

   目前由于 acme 协议和 letsencrypt CA 都在频繁的更新, 因此 acme.sh 也经常更新以保持同步.

   升级 acme.sh 到最新版 :

   ```shell
   acme.sh --upgrade
   ```

   如果你不想手动升级, 可以开启自动升级:

   ```shell
   acme.sh  --upgrade  --auto-upgrade
   ```

   之后, acme.sh 就会自动保持更新了.

   你也可以随时关闭自动更新:

   ```shell
   acme.sh --upgrade  --auto-upgrade  0
   ```