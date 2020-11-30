---
author: "Ephz3nt"
date: 2020-11-30
title: 记一次小程序请求PHP后端报错
---

小程序业务有外接一套商城，由于需要部署一套测试环境，所以在公司内网服务器使用 K8S 跑了一套。
但是问题来了，线上的没有问题，测试环境小程序调用 PHP 后端接口貌似出现了问题，无法获取用户信息。
数据库是直接从线上导出来的，PHP 代码除了配置文件不同，其他都没有变动。

使用`Charles`抓包看了下报错

```
	"status": 400,
	"msg": "系统出现异常",
	"data": {
		"message": "SQLSTATE[22001]: String data, right truncated: 1406 Data too long for column 'token' at row 1",
		"file": "\/var\/www\/html\/vendor\/topthink\/think-orm\/src\/db\/PDOConnection.php",
		"code": 10501,
		"line": 713,
		"trace": [{
			"file": "\/var\/www\/html\/vendor\/topthink\/think-orm\/src\/db\/PDOConnection.php",
			"line": 769,
			"function": "getPDOStatement",
			"class": "think\\db\\PDOConnection",
			"type": "->",
			"args": ["INSERT INTO `user_token` SET `uid` = :ThinkBind_1_1689079_ , `token` = :ThinkBind_2_1472105804_ , `expires_time` = :ThinkBind_3_1500549319_ , `create_time` = :ThinkBind_4_1947827158_ , `login_ip` = :ThinkBind_5_2004432133_ ", {
				"ThinkBind_1_1689079_": [1, 1],
				"ThinkBind_2_1472105804_": ["eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzaG9wLmNsaWVudC50ZXN0LmRkamdqLf4wao1MDAwNiIsImF1ZCI6InNob3AuY2xpZW50LnRlc3QuZGRqZ2ouY29tOjUwMDA2IiwiaWF0IjoxNjA2NzE4MjMyLCJuYmYiOjE2MDY3MTgyMzIsImV4cCI6MTYwNjcyOTAzMiwianRpIjp7ImlkIjoxLCJ0eXBlIjoicm91dGluZSJ9fQ.gTxWWSCKTx7d3KjUz3YniGJx3D4Hp4DlixwEMpS6iY8", 2],
				"ThinkBind_3_1500549319_": ["2020-11-30 17:37:12", 2],
				"ThinkBind_4_1947827158_": ["2020-11-30 14:37:12.001472", 2],
				"ThinkBind_5_2004432133_": ["172.100.0.99", 2]
			},
			true, false]
		}
        ...
```

其实这个错误，我好几天前就发现了，并且找到通过使用

```sql
SET @@global.sql_mode= '';
```

即可修复。
但是又出现了新问题，现在访问 PHP 后端的话，小程序客户端会出现无限调用 PHP 后端授权接口的情况，由于小程序对接 PHP 后端部分也是外包的，我自己也没有开发经验，也有联系对方排查，但无奈效率太低，而且对方也不太想处理这种因环境导致的问题。

今天看到上面的报错，发现有一段 SQL 语句，于是手动提取出来去 MySQL 执行

```sql
INSERT INTO `user_token` SET `uid` = "1" , `token` = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJzaG9wLmNsaWVudC50ZXN0LmRkamdqLf4wao1MDAwNiIsImF1ZCI6InNob3AuY2xpZW50LnRlc3QuZGRqZ2ouY29tOjUwMDA2IiwiaWF0IjoxNjA2NzE2OTcyLCJuYmYiOjE2MDY3MTY5NzIsImV4cCI6MTYwNjcyNzc3MiwianRpIjp7ImlkIjoxLCJ0eXBlIjoicm91dGluZSJ9fQ.hQcnb8ERndq_N7njCeKFmQp0YEZOtMoxZXwonIAzfUM" , `expires_time` = "2020-11-30 17:16:12" , `create_time` = "2020-11-30 14:16:12.782399" , `login_ip` = "1.1.1.1";
```

获得同样的报错
`Data too long for column 'token' at row 1`，于是去 Google 了一下，无意中看到`StackOverFlow`的一个问答[https://stackoverflow.com/a/34353155](https://stackoverflow.com/a/34353155),于是尝试将`token`字段的`varchar`修改成`longtext`，重新尝试调用竟然成功解决了问题！

最终步骤

1. 设置 SQL_MODE

   ```sql
   SET @@global.sql_mode= '';
   ```

2. 将出错的字段类型修改成`longtext`
