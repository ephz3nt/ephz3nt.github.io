---
title: 用php+mysql写一个刷新页面显示不同的内容
tags:
  - mysql
  - php
  - 不同内容
  - 刷新显示
id: 8
categories:
  - 网络相关
date: 2011-11-18 04:31:39
---

用php+mysql写一个刷新页面显示不同的内容

```php
<?
$conn=mysql_connect("localhost","user","pwd");
$sql="select * from tab where 1";
result=mysql_db_query("database_name",sql);
row_num=mysql_num_rows(result);
rand=rand(0,row_num);
mysql_data_seek(result, rand);
row=mysql_fetch_assoc(result);
echo "<pre>";
print_r($row);
echo "/<pre>";
?>
```