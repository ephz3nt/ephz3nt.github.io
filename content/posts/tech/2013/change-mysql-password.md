---
title: 修改mysql用户密码
tags:
  - mysql
  - root密码
id: 464
categories:
  - 网络相关
date: 2013-08-05 13:08:39
---

1. mysqladmin命令（回目录）
格式如下（其中，USER为用户名，PASSWORD为新密码）：
```
mysqladmin -u USER -p password PASSWORD
```
该命令之后会提示输入原密码，输入正确后即可修改。
例如，设置root用户的密码为123456，则
```
mysqladmin -u root -p password 123456
```
2. UPDATE user 语句（回目录）
这种方式必须是先用root帐户登入mysql，然后执行：

```
UPDATE user SET password=PASSWORD('123456') WHERE user='root';
FLUSH PRIVILEGES;
```
3. SET PASSWORD 语句（回目录）
这种方式也需要先用root命令登入mysql，然后执行：
```
SET PASSWORD FOR root=PASSWORD('123456');
```
4. 忘记mysql密码（回目录）
windows：在bin目录下执行
```
mysqld --skip-grant-tables
```
回车。如果没有出现提示信息，那就对了。
再开一个DOS窗口(因为刚才那个DOS窗口已经不能动了)，转到mysql\bin目录。
输入mysql回车，如果成功，将出现MySQL提示符
```
use mysql;
update user set password=password("newpassword") where user="root";
flush privileges;
```
注销系统，再进入，开MySQL，使用用户名root和刚才设置的新密码123456登陆。
linux：
```
vi /etc/my.cnf
```
在[mysqld]的段中加上一句：skip-grant-tables
例如：
```
[mysqld] 
datadir=/var/lib/mysql 
socket=/var/lib/mysql/mysql.sock 
skip-grant-tables
```
保存并且退出vi。
重新启动mysqld
```
/etc/init.d/mysqld restart 
Stopping MySQL: [ OK ] 
Starting MySQL: [ OK ]
```
登录并修改MySQL的root密码
```
/usr/bin/mysql #根据自己的安装目录而定
Welcome to the MySQL monitor. Commands end with ; or \g. 
Your MySQL connection id is 3 to server version: 3.23.56 
Type 'help;' or '\h' for help. Type '\c' to clear the buffer. 
mysql> USE mysql ; 
Reading table information for completion of table and column names 
You can turn off this feature to get a quicker startup with -A 
Database changed 
mysql> UPDATE user SET Password = password ( 'new-password' ) WHERE User = 'root' ; 
Query OK, 0 rows affected (0.00 sec) 
Rows matched: 2 Changed: 0 Warnings: 0 
mysql> flush privileges ; 
Query OK, 0 rows affected (0.01 sec) 
mysql> quit
```
Bye
5. 将MySQL的登录设置修改回来
`vi /etc/my.cnf`
将刚才在[mysqld]的段中加上的skip-grant-tables删除
保存并且退出vi。
6. 重新启动mysqld
```
/etc/init.d/mysqld restart 
Stopping MySQL: [ OK ] 
Starting MySQL: [ OK ]
```