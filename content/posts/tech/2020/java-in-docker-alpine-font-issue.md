---
author: "ephz3nt"
date: 2020-12-11
title: Java ExcelUtil 库导出Excel表格报错问题
tags:
  - ExcelUtil
  - Java
  - Apache POI
  - Docker
  - Alpine
---

### 环境信息

- 运行环境: Docker
- 使用镜像: adoptopenjdk/openjdk11:alpine

### 问题概述

同事新写的接口，功能大概是访问提供某些参数会返回一个 Excel 表格。在本机测试正常，但是部署到测试环境下载下来的表格内容是

|             |                                                                                                                                           |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| {"code":500 | data":null,"message":"Handler dispatch failed; nested exception is java.lang.InternalError: java.lang.reflect.InvocationTargetException"} |

#### 控制台报错信息

```java
org.springframework.web.util.NestedServletException: Handler dispatch failed; nested exception is java.lang.InternalError: java.lang.reflect.InvocationTargetException
        at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1055) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:898) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:634) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:741) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53) ~[tomcat-embed-websocket-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at brave.servlet.TracingFilter.doFilter(TracingFilter.java:65) ~[brave-instrumentation-servlet-5.9.0.jar!/:na]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.springframework.cloud.sleuth.instrument.web.ExceptionLoggingFilter.doFilter(ExceptionLoggingFilter.java:50) ~[spring-cloud-sleuth-core-2.2.0.RELEASE.jar!/:2.2.0.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at brave.servlet.TracingFilter.doFilter(TracingFilter.java:82) ~[brave-instrumentation-servlet-5.9.0.jar!/:na]
        at org.springframework.cloud.sleuth.instrument.web.LazyTracingFilter.doFilter(TraceWebServletAutoConfiguration.java:138) ~[spring-cloud-sleuth-core-2.2.0.RELEASE.jar!/:2.2.0.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.springframework.boot.actuate.metrics.web.servlet.WebMvcMetricsFilter.doFilterInternal(WebMvcMetricsFilter.java:108) ~[spring-boot-actuator-2.2.2.RELEASE.jar!/:2.2.2.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:526) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:367) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:860) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1591) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128) ~[na:na]
        at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628) ~[na:na]
        at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61) ~[tomcat-embed-core-9.0.29.jar!/:9.0.29]
        at java.base/java.lang.Thread.run(Thread.java:834) ~[na:na]
Caused by: java.lang.InternalError: java.lang.reflect.InvocationTargetException
        at java.desktop/sun.font.FontManagerFactory$1.run(FontManagerFactory.java:86) ~[na:na]
        at java.base/java.security.AccessController.doPrivileged(Native Method) ~[na:na]
        at java.desktop/sun.font.FontManagerFactory.getInstance(FontManagerFactory.java:74) ~[na:na]
        at java.desktop/java.awt.Font.getFont2D(Font.java:497) ~[na:na]
        at java.desktop/java.awt.Font.canDisplayUpTo(Font.java:2250) ~[na:na]
        at java.desktop/java.awt.font.TextLayout.singleFont(TextLayout.java:469) ~[na:na]
        at java.desktop/java.awt.font.TextLayout.<init>(TextLayout.java:530) ~[na:na]
        at org.apache.poi.ss.util.SheetUtil.getDefaultCharWidth(SheetUtil.java:275) ~[poi-3.17.jar!/:3.17]
        at org.apache.poi.ss.util.SheetUtil.getColumnWidth(SheetUtil.java:250) ~[poi-3.17.jar!/:3.17]
        at org.apache.poi.ss.util.SheetUtil.getColumnWidth(SheetUtil.java:235) ~[poi-3.17.jar!/:3.17]
        at org.apache.poi.hssf.usermodel.HSSFSheet.autoSizeColumn(HSSFSheet.java:2165) ~[poi-3.17.jar!/:3.17]
        at org.apache.poi.hssf.usermodel.HSSFSheet.autoSizeColumn(HSSFSheet.java:2147) ~[poi-3.17.jar!/:3.17]
        at com.sargeraswang.util.ExcelUtil.ExcelUtil.write2Sheet(ExcelUtil.java:315) ~[excel-util-1.2.1.jar!/:na]
        at com.sargeraswang.util.ExcelUtil.ExcelUtil.exportExcel(ExcelUtil.java:157) ~[excel-util-1.2.1.jar!/:na]
        at com.sargeraswang.util.ExcelUtil.ExcelUtil.exportExcel(ExcelUtil.java:136) ~[excel-util-1.2.1.jar!/:na]
        at com.fz.jgj.report.web.GiftCardGeneratorController.exportCdks(GiftCardGeneratorController.java:87) ~[classes!/:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62) ~[na:na]
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) ~[na:na]
        at java.base/java.lang.reflect.Method.invoke(Method.java:566) ~[na:na]
        at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138) ~[spring-web-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:106) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:888) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040) ~[spring-webmvc-5.2.2.RELEASE.jar!/:5.2.2.RELEASE]
        ... 53 common frames omitted
Caused by: java.lang.reflect.InvocationTargetException: null
        at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method) ~[na:na]
        at java.base/jdk.internal.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62) ~[na:na]
        at java.base/jdk.internal.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45) ~[na:na]
        at java.base/java.lang.reflect.Constructor.newInstance(Constructor.java:490) ~[na:na]
        at java.desktop/sun.font.FontManagerFactory$1.run(FontManagerFactory.java:84) ~[na:na]
        ... 79 common frames omitted
Caused by: java.lang.NullPointerException: null
        at java.desktop/sun.awt.FontConfiguration.getVersion(FontConfiguration.java:1262) ~[na:na]
        at java.desktop/sun.awt.FontConfiguration.readFontConfigFile(FontConfiguration.java:225) ~[na:na]
        at java.desktop/sun.awt.FontConfiguration.init(FontConfiguration.java:107) ~[na:na]
        at java.desktop/sun.awt.X11FontManager.createFontConfiguration(X11FontManager.java:719) ~[na:na]
        at java.desktop/sun.font.SunFontManager$2.run(SunFontManager.java:379) ~[na:na]
        at java.base/java.security.AccessController.doPrivileged(Native Method) ~[na:na]
        at java.desktop/sun.font.SunFontManager.<init>(SunFontManager.java:324) ~[na:na]
        at java.desktop/sun.awt.FcFontManager.<init>(FcFontManager.java:35) ~[na:na]
        at java.desktop/sun.awt.X11FontManager.<init>(X11FontManager.java:56) ~[na:na]
        ... 84 common frames omitted
```

### 找到问题

根据报错信息搜索`java.lang.InternalError: java.lang.reflect.InvocationTargetException`，发现大致为字体原因。知道问题后面就比较好处理了，为镜像包安装一下字体然后重新提交作为基础镜像成功解决。

```Dockerfile
FROM adoptopenjdk/openjdk11:alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && apk upgrade && apk add ttf-dejavu --no-cache && rm -rf /var/cache/apk/*
MAINTAINER ephz3nt
EXPOSE 8080/tcp
WORKDIR /app
COPY ./example-web/target/example-web.jar .
ENV TZ Asia/Shanghai
ENTRYPOINT ["java","-Dfile.encoding=utf-8","-Xms1g","-Xmx1g","-Djava.security.egd=file:/dev/./urandom","-jar","example-web.jar","--spring.profiles.active=test"]
```
