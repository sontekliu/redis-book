# Redis 安装

#### 1. 下载Redis安装包

在 Redis [官方网站](https://redis.io)，下载 stable version 版本，编写此教程时，稳定版本为 5.0

#### 2. 安装之前的准备

首先要安装 tcl, make, gcc 

```shell
$ sudo apt install tcl make gcc 
```

#### 3. 解压缩安装

使用 root 账号进行安装。

```shell
# tar -zxvf redis-5.0.0.tar.gz 
# cd redis-5.0.0
# make MALLOC=libc     # 官网下载完成之后就已经configure了，所以直接make
# make test
# make install PREFIX=/usr/local/redis  # PREFIX 指定安装目录，注意大写
```
#### 4. 拷贝配置文件

执行完成安装之后，在 `/usr/local` 下面自动创建了 `redis` 目录。并且在 `redis` 目录下面目前只有 `bin` 目录，此时需要创建 data(存放 redis 数据文件)、etc（存放 redis 配置文件）、log（存放 redis 日志文件）等目录。具体操作如下：

```shell
# cd /usr/local/redis
# mkdir data etc log
```

创建完安装目录之后，将 `redis` 配置文件复制到 `/usr/local/redis/etc/` 目录下。具体操作如下：

```shell
# cd /usr/local/redis-5.0.0
# cp redis.conf /usr/local/redis/etc
```

#### 5. 启动 Redis 服务

```shell
# cd /usr/local/redis/bin
# ./redis-server /usr/local/redis/etc/redis.conf
```

#### 6. 连接 Redis

```shell
# cd /usr/local/redis/bin
# ./redis-cli [-h ip] [-p port] [-a password]

```
