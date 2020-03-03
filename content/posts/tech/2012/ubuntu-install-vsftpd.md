---
title: Ubuntu下安装vsftpd
tags:
  - Ubuntu
  - vsftpd
id: 209
categories:
  - 网络相关
date: 2012-02-05 05:07:54
---

装了lnmp后FTP管理装的是pureftpd，后来感觉不好用，后台管理那里用户的UID和GID搞不懂，登陆上权限也不够，后来安装了lnmp自带的vsftpd好像也不能用，还是不用它的吧，

先卸载。

1. cd / (切换根目录)
2. 停止pureftpd进程，运行命令： /root/pureftpd stop
3. 删除文件，运行命令：

```
rm -rf /usr/local/pureftpd
rm -rf /home/wwwroot/ftp （管理程序的位置，请根据实际情况设置）
rm /root/pureftpd
```
安装vsftpd

```
sudo apt-get install vsftpd
```

这个命令的确可以安装，但是搞不懂 有的这个可以用，有的就不行

我84的VPS执行这个命令返回的就是

```
root@272929:~# sudo apt-get install vsftpd
Reading package lists... Done
Building dependency tree... Done
E: Couldn't find package vsftpd
root@272929:~#
```

安装好以后配置一下

可以vi etc/vsftpd.conf 进行编辑也可以用winscp

```
#独立运行
listen=YES>

#是否启用匿名访问
anonymous_enable=no

#本地用户登录
local_enable=YES

#FTP目录
local_root=/soft

#访问端口
listen_port=21

#下面3段是后来加的，解决了本地用户不能登录的问题
#好像是vsftpd首先要检测拒绝的账号列表，如果没有这个列表就会全部认为是拒绝的
chroot_local_user=YES
userlist_enable=YES
userlist_deny=YES
#允许本地用户写入和删除
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=no
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=ftp
rsa_cert_file=/etc/ssl/private/vsftpd.pem
```

将以上配置复制替换掉原etc/vsftpd.conf文件即可

重启vsftpd : service vsftpd restart

添加FTP账号

`useradd -d (用户家目录) -s /sbin/nologin 用户名`

如：

`useradd -d /soft -s /sbin/nologin ftpuser01`

设置密码：

`passwd ftpuser01`

重复输入2次即可

目录的权限要给FTP的账号

先修改目录的权限然后赋予FTP账号

`chmod -R 775 目录`

`chown -R 用户名.用户组 目录`

比如我的wordpress网站根目录作为FTP的目录，为了不让www用户对博客目录的权限发生改变，可以这样写

`chown -R www.FTP用户名 /home/wwwroot`

这样FTP用户可以访问上传删除，我WP博客安装插件又不用填写FTP信息

无法登陆FTP是因为没有添加拒绝账号列表

在/etc 目录下建立vsftpd.user_list 这个文件，添加拒绝登录的账号“root就可以了，一行一个

好了，好像差不多了，新手 如有不足之处望指教。