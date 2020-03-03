---
title: Let's Encrypt 免费SSL证书安装小记。
tags:
  - acme-tiny
  - cloudflare
  - Let's Encrypt
  - linode
  - Nginx
  - 免费SSL
id: 701
categories:
  - 网络相关
date: 2015-12-10 16:08:58
---

从去年就开始关注Let's Encrypt 了， 就在不久前它宣布公测。所有人都可以使用由此机构签发的免费SSL证书。

下面来分享一下本屌的安装过程。

系统：CentOS 6.4 x64
环境：军哥LNMP
签发的域名：本博客
使用的签发工具：[acme-tiny](https://github.com/diafygi/acme-tiny) (这里不使用官方提供的工具原因为太过臃肿，acme-tiny仅200+行代码，小巧简单)

2015-12-27 22:06:57 update:
CloudXNS已支持Let's Encrypt的验证, See [https://www.cloudxns.net/Support/detail/id/1062.html](https://www.cloudxns.net/Support/detail/id/1062.html)
注意：
1、确保需要签发的域名使用的DNS为国外DNS服务(如cloudflare,linode等，否则到签发步骤可能会报错)
2、确保需要签发的域名已指向A记录到你的网站服务器，不要用CNAME等记录，一定要A记录！(否则到签发步骤可能会报错)
3、最好用ROOT帐号操作(我使用普通帐号操作会报key values mismatch)

安装git
```
yum -y install git
```
如果你已经有了git则执行(注意：存放目录最好不要在home目录下，我存放在/web/acme-tiny)
```
git clone https://github.com/diafygi/acme-tiny.git
```
生成帐号KEY
```
openssl genrsa 4096 &gt; account.key
```
生成域名KEY
```
openssl genrsa 4096 &gt; painso.key
```
生成CSR文件(如果你是以根域名来访问的话使用单域名即可，签发的主机头越多越麻烦哦)
```
单域名(不包含其他域如www)：
openssl req -new -sha256 -key painso.key -subj "/CN=painso.com" &gt; painso.csr

多域名：
openssl req -new -sha256 -key painso.key -subj "/" -reqexts SAN -config &lt;(cat /etc/ssl/openssl.cnf &lt;(printf "[SAN]\nsubjectAltName=DNS:painso.com,DNS:www.painso.com")) &gt; painso.csr
```
如果你使用多域名这行命令可能会报找不到openssl.cnf，别慌，直接访问[http://web.mit.edu/crypto/openssl.cnf](http://web.mit.edu/crypto/openssl.cnf) 全选复制到你系统下的/etc/ssl/openssl/cnf。

然后打开你的Nginx虚拟主机配置文件，在80端口处添加
```
location /.well-known/acme-challenge/ {
        alias /web/acme-tiny/; #这里填你的acme-tiny所在目录
        try_files $uri =404;
    }
```
如下图中我的配置
[![lse-nginx](/images/2015/12/lse-nginx-300x156.png)](/images/2015/12/lse-nginx.png)
如果你有自动跳转到443端口的配置请记得把他注释掉。
重启Nginx
```
nginx -s reload (以实际路径为准，我已经做过软连接ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx)
```
在Let's Encrypt 服务器提交签发证书(程序大致操作：acme-tiny.py会生成一个密钥文件到acme-tiny目录下，然后Let's Encrypt 证书签发服务器会访问需签发域名/.well-known/acme-challenge/路径下acme-tiny.py生成的密钥文件)
```
python acme_tiny.py --account-key account.key --csr painso.csr --acme-dir /web/acme-tiny/ &gt; painso.crt
```
这上面应该都能看明白哦?
--account-key
之前生成的account-key路径
--csr
同上
--acme-dir
acme-tiny路径
顺利的话会生成一个.crt文件，也就是服务器签发下来的证书文件
然后下载根证书
```
wget -O - https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem &gt; intermediate.pem
```
合并证书(不执行下面操作的话firefox会提示不信任，chrome则无碍)
```
cat intermediate.pem &gt; painso.crt
```
然后在nginx虚拟主机配置中修改原来的证书路径为现在新的证书路径即可
```
nginx -t
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

```
测试OK后记得把之前的
```
location /.well-known/acme-challenge/ {
        alias /web/acme-tiny/;;
        try_files $uri =404;
    }
    ```
注释掉。

然后访问你的网站，是否可以看到 Let's Encrypt 啦。

总的来说，证书的安装签发是非常蛋疼的，比如我用cloudxns就不能执行签发步骤，需要换到cloudflare，签发完了再换回cloudxns，且证书期限只有90天，希望Let's Encrypt越搞越好:)

[![Let](/images/2015/12/Lets-Encrypt-236x300.png)](/images/2015/12/Lets-Encrypt.png)