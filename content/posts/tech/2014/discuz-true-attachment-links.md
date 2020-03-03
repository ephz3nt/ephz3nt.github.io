---
title: Discuz显示音乐以及除图片外文件的真实链接。
tags:
  - Discuz
  - 真实地址
  - 附件地址
  - 附件链接
  - 音乐文件
id: 658
categories:
  - 网络相关
date: 2014-07-25 22:04:36
---

由于自己的音乐论坛一直找不到好的外链，所以干脆自己搭个算了
想找一个支持直链的开源站点小程序用，但是一直都没有找到
于是开始了Discuz远程附件折腾之旅。

都知道Discuz远程附件的机制蛋疼至极，图片可以直接显示链接，其他文件不行
折腾了一天，终于搞定
打开 
```
\source\function\function_discuzcode.php
``` 
找到
```
function parseattachurl($aid, $ext, $ignoretid = 0)
``` 
将

```
function parseattachurl($aid, $ext, $ignoretid = 0) {
	global $_G;
	$_G['forum_skipaidlist'][] = $aid;
	return $_G['siteurl'].'forum.php?mod=attachment&amp;aid='.aidencode($aid, $ext, $ignoretid ? '' : $_G['tid']).($ext ? '&amp;request=yes&amp;_f=.'.$ext : '');
}
``` 

替换为

```
function parseattachurl($aid, $ext, $ignoretid = 0) {
    global $_G;
    $_G['forum_skipaidlist'][] = $aid;
	$aid = intval($aid);

	$attach = DB::fetch_first("SELECT * FROM ".DB::table('forum_attachment')." WHERE aid='$aid'");
	$tid = $attach['tableid'];
	$attach = DB::fetch_first("SELECT * FROM ".DB::table('forum_attachment_').$tid." WHERE aid='$aid'");
	$attachfile = $attach['attachment'];
    return "http://127.0.0.1/ftp/music/forum/".$attachfile;
}
``` 
其中这个"http://127.0.0.1/ftp/music/forum/" 需要按自己实际情况改改
、数据库查询语句是本人写的，如有不正之处请指出，谢谢。