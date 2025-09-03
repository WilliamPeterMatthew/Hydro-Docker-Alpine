## Hydro-Docker (Ver. Alpine Dev)

> 以下内容魔改自 [源仓库](https://github.com/hydro-dev/Hydro) 的 `Hydro/install/docker` 文件夹，脚本内容不一定为最新版，请核对后使用
> 
> 构建日期: 2025-08-19，版本: v5.0.0-beta.8

![backend Pulls](https://img.shields.io/docker/pulls/petermatthew/hydro-docker-backend?label=backend%20pulls)
![backend Image Size](https://img.shields.io/docker/image-size/petermatthew/hydro-docker-backend?sort=date&label=backend%20size)
![hydro-docker-backend Image Version](https://img.shields.io/docker/v/petermatthew/hydro-docker-backend?sort=date&label=hydro-docker-backend)

![judge Pulls](https://img.shields.io/docker/pulls/petermatthew/hydro-docker-judge?label=judge%20pulls)
![judge Image Size](https://img.shields.io/docker/image-size/petermatthew/hydro-docker-judge?sort=date&label=judge%20size)
![hydro-docker-judge Image Version](https://img.shields.io/docker/v/petermatthew/hydro-docker-judge?sort=date&label=hydro-docker-judge)

## Alpine镜像版本为测试版本，和官方最开始使用的基础镜像存在差异，请谨慎使用

## docker 安装方式仅适用于可熟练使用 docker-compose 维护容器的用户，并要求您有基础的错误排查能力

## 该安装模块非官方维护，即不会提供任何技术支持

## 普通用户请务必使用自动脚本安装，这可大大提高您一次成功的可能性

本文假设您已经安装了 `Docker` 、 `docker-compose` 、 `git` 。

**未安装请先安装**。

## 开始安装（不建议使用Windows）

1. 请选择磁盘空间富裕的位置，运行下面的命令。

   `git clone https://github.com/WilliamPeterMatthew/Hydro-Docker.git && cd Hydro-Docker`

2. 启动服务。

   `docker-compose up -d`

因为是在本机制作docker镜像，所以耗时可能会比较久。根据网速情况，大约5到30分钟就可以自动搭建完成，全程无需人工干预。

等命令执行完成，然后运行 `docker ps -a`，当看到所有的容器的状态没有`Exited (x) xxx`就代表 OJ 已经启动成功。

## 注意

安装过程中，会默认注册一个超级管理员账号，用来做测评账号。用户名：`hydro`，密码：`hydro123`。**请务必及时修改密码**。修改该账号密码后，请修改`data/judge/config/judge.yaml`中的`password`。否则可能会无法测评。

可以尝试在Hydro上登录该账号，若无法登录该账号，需要手动执行以下指令  
   `hydrooj cli user create Hydro@hydro.local hydro hydro123`  
   `hydrooj cli user setPassword 1 hydro123`  
   `hydrooj cli user setJudge 1`  
来确保评测机可以正常连接到后端。

如果无法访问端口，且Hydro的日志正常，请执行以下指令  
   `hydrooj cli system set server.host 0.0.0.0`  

## 测评机默认编译器

测评机默认安装了以下几个编译器，如有需要，请自行安装。

编译器列表：

1. gcc
2. python3
3. g++
4. fp-compiler
5. openjdk-17-jdk-headless
6. rustc
7. ghc
8. cabal-install
9. libjavascriptcoregtk-4.0-bin
10. golang
11. ruby
12. mono-runtime
13. mono-mcs

## Hydro使用

参考 [官方文档](https://hydro.js.org/) ，主要操作请进入 `oj-backend` 容器操作，涉及作为独立进程的评测机，请进入 `oj-judge` 容器操作。

进入容器的方法是  
   `docker exec -it <容器名> /bin/bash`  
例如  
   `docker exec -it oj-backend /bin/bash`  
