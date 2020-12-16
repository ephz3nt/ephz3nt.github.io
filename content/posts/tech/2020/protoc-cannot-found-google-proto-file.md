---
author: "ephz3nt"
date: 2020-12-16
title: protoc 引用 Google 外部 proto 无法找到文件问题
tags:
  - protobuf
  - protoc
  - timestamp
---
最近在跟着阿三哥学习`gRPC`，有一步需要引用`google/protobuf/timestamp.proto`导致使用protoc生成的时候报错
```shell
protoc --proto_path=proto proto/*.proto --go-grpc_out=pb --go_out=pb
google/protobuf/timestamp.proto: File not found.
laptop_message.proto:12:1: Import "google/protobuf/timestamp.proto" was not found or had errors.
```

网上搜索大部分都是说去[https://github.com/protocolbuffers/protobuf/releases](https://github.com/protocolbuffers/protobuf/releases)下载protoc包把里面的`include`下面的`google`文件夹 文件夹复制到 `/usr/local/include/google`。几经操作还是一样报错，后面在[官方issue](https://github.com/protocolbuffers/protobuf/issues/5131#issuecomment-436811712)找到答案。

如果你的protoc是放在 **$GOPATH/bin** 下，那么需要把protoc包里面的`include`文件夹复制到 **$GOPATH** 下即可。