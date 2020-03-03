---
title: PHP文件操作函数和添加图片计数器。
tags:
  - php
  - 图片计数器
  - 文件操作函数
id: 455
categories:
  - 网络相关
date: 2013-07-07 14:21:03
---

PHP访问文件或文件夹相关函数
filetype() //可以输出相关文件类型，如：dir / file /link
echo filetype('C:\WINDOWS').'';
输出结果：dir
echo filetype('C:\WINDOWS\regedit.exe').'';
输出结果：file
相关函数：
clearstatcache() 来清除缓存
is_executable() 判断文件是否可执行
is_dir() 判断是否存在或是文件夹
is_file() 判断是否是文件
scandir() 遍历文件夹 / 返回一个数组

str_split 将字符串拆分为单个数组

```
php
if(!$f=fopen("num.txt","r")){ //只读模式打开，判断num.txt不存在则输出下行
echo "文件不存在！！！";
$num=0;
}else{
num = fgets(f,10); //获得9位
fclose($f);
}
$num++;
$open = fopen("num.txt","w"); //写入模式打开（如果文件不存在则创建）
fwrite(open,num); //把$num里的值写入到num.txt中
fclose($open); //关闭num.txt
}
numarr = str_split(num); //把字符串拆分到数组中
foreach(numarr as number){ //为$numarr开始遍历
// print_r($number);
echo "<img src='images\".number.".png'>"; //循环遍历输出number.png
}
```