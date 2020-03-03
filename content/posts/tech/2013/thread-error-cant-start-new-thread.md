---
title: 'thread.error: can''t start new thread 解决办法'
tags:
  - thread error
  - yum
id: 419
categories:
  - 网络相关
date: 2013-05-30 09:23:04
---

最近折腾VPS安装各种应用，在YUM安装软件时报错 。GOOGLE了一下，发现是YUM的一个配置文件导致
```
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
Traceback (most recent call last):
File "/usr/bin/yum", line 29, in &lt;module&gt;
yummain.user_main(sys.argv[1:], exit_code=True)
File "/usr/share/yum-cli/yummain.py", line 276, in user_main
errcode = main(args)
File "/usr/share/yum-cli/yummain.py", line 129, in main
result, resultmsgs = base.doCommands()
File "/usr/share/yum-cli/cli.py", line 434, in doCommands
self._getTs(needTsRemove)
File "/usr/lib/python2.6/site-packages/yum/depsolve.py", line 99, in _getTs
self._getTsInfo(remove_only)
File "/usr/lib/python2.6/site-packages/yum/depsolve.py", line 110, in _getTsInfo
pkgSack = self.pkgSack
File "/usr/lib/python2.6/site-packages/yum/__init__.py", line 883, in &lt;lambda&gt;
pkgSack = property(fget=lambda self: self._getSacks(),
File "/usr/lib/python2.6/site-packages/yum/__init__.py", line 668, in _getSacks
self.repos.populateSack(which=repos)
File "/usr/lib/python2.6/site-packages/yum/repos.py", line 265, in populateSack
self.doSetup()
File "/usr/lib/python2.6/site-packages/yum/repos.py", line 92, in doSetup
self.ayum.plugins.run('postreposetup')
File "/usr/lib/python2.6/site-packages/yum/plugins.py", line 184, in run
func(conduitcls(self, self.base, conf, **kwargs))
File "/usr/lib/yum-plugins/fastestmirror.py", line 202, in postreposetup_hook
all_urls = FastestMirror(all_urls).get_mirrorlist()
File "/usr/lib/yum-plugins/fastestmirror.py", line 369, in get_mirrorlist
self._poll_mirrors()
File "/usr/lib/yum-plugins/fastestmirror.py", line 413, in _poll_mirrors
pollThread.start()
File "/usr/lib/python2.6/threading.py", line 474, in start
_start_new_thread(self.__bootstrap, ())
thread.error: can't start new thread
```
vim /etc/yum/pluginconf.d/fastestmirror.conf //编辑该文件
将enable=1改为0即可