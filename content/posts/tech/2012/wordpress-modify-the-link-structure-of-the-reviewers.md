---
title: Wordpress修改评论者链接结构
tags:
  - wordpress
  - 修改结构
  - 评论者链接
id: 270
categories:
  - 网络相关
date: 2012-02-14 10:30:47
---

> nofollow标签的算法变更和百度对该标签的不认可，导致wordpress评论区域最好也据此来做相应的调整。使用robots.txt对自身地址进行屏蔽，从而规避非法链接对自身权重的影响。
> 1、打开wp-includes文件夹下的comment-template.php文件<!--more-->
> 2、找到$return = “&lt;a href=’$url’ rel=’external nofollow’ class=’url’&gt;$author&lt;/a&gt;”;语句，大约在154行（Notepad2中查看）
> 3、链接修改为$return = “&lt;a href=’jump.php?$url’ rel=’external nofollow’ class=’url’&gt;$author&lt;/a&gt;”;

这里的jump.php名字可以根据自己需求更改。
4、替换上传

jump.php代码：

Apache: 

```php
<?php> 
header("location: ".$_SERVER['REDIRECT_QUERY_STRING']);> 
?>
```

Nginx: 

```php
<?php> 
header("location: ".$_SERVER['QUERY_STRING']);> 
?>
```

保存成刚刚修改的comment-template.php里的名字上传至根目录
多谢Lite3指教。
robots.txt添加
<pre>Disallow: /jump.php?*</pre>