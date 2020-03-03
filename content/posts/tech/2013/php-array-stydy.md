---
title: PHP的数组、多维数组和数组函数学习笔记。
tags:
  - php
  - 多维数组
  - 数组
id: 446
categories:
  - 网络相关
date: 2013-07-05 00:16:32
---

最近在学习PHP，想多学点东西充实自己，提升自己的能力，以后才可以回报爱我的人和我爱的人 - - 。

foreach()是一个用来遍历数组中数据的最简单有效的方法。

```
php
title = array("S.m.s","娱乐","音乐论坛");  //创建一个title的数组(无键值模式)
//$title = array("A"=>"S.m.s","B"=>"娱乐","C"=>"音乐论坛");  //有键值模式
//遍历方式1
foreach(title as value){    //无键名模式
echo value;                     //直接把title数组的数据从左到右依次输出
}
echo "<br>";
foreach(title as str => $value){   //有键名模式(多了一个键名/下标输出)
echo str."=".value."<br>";         //输出下标和键值(我上面没有定义键名，所以输出的为下标值后面跟上对应的数组值)
}
//题目为。要求输出$arr数组里面的所有值，每输出一个换一行。
$arr = array(array(array('a','b','c','d',1,2,3,4),'我','是','你'),array('吧','吧')); //多维数组
foreach(arr as a){ //arr数组遍历给a
if(is_array($a)){ //判断$arr是否为数组类型
foreach(a as b){ //如果是的话继续把a遍历给b
if(is_array($b)){ //判断$b是否为数组类型
foreach(b as c){ //如果是把b遍历给c
echo c."<br>"; //并且输出c
}
}else{
echo b."<br>"; //如果不是直接输出b
}
}
}else{
echo a."<br>"; //如果不是则输出a
}
}
```

其中foreach遍历原理还不是很清楚

这里有好几层数组 ，为什么判断2次就全部输出了

注意事项：有键的数值不能使用下标方式调用