# Redis 简介

#### Redis是什么?   
Redis is an open source (BSD licensed), in-memory data structure store, used as database, cache and message broker. It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs and geospatial indexes with radius queries. Redis has built-in replication, Lua scripting, LRU eviction, transactions and different levels of on-disk persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster.

大致意思是:

Redis是一个开源的内存数据结构服务器，通常可以当作数据库、缓存、消息队列代理。它支持字符串、哈希表、列表、集合、 有序集合的范围查询、位图、hyperloglogs和地理空间索引的半径查询，Redis内置复制、Lua脚本、LRU回收、事物以及不同级别的磁盘持 久化功能，同时通过Redis Sentinel提供高可用，通过Redis Cluster提供自动分区。

#### 谁在使用 Redis 

如果要问 Redis 的作者有谁在使用 Redis，Redis 作者的回复是，还有谁不在使用 Redis 呢？
目前使用 Redis 的公司有：   
Github、Twitter、StackOverflow、阿里巴巴、百度、美团、新浪微博、搜狐等

#### Redis 的特性

1. 速度快   
    根据官方给出的数据是每秒 10W QPS，如此高的速度主要是因为数据都是存储在内存中的，所以速度非常快。其次就是
    Redis 是使用 C 语言编写的，C 相对于一些其他高级语言例如 Java、Python等效率肯定高。再就是 Redis 采用
    了单线程模型，避免了多线程上下文切换所消耗的时间。
2. 提供持久化功能  
    Redis 支持基于二进制的 RDB 文件的数据持久化，支持基于日志的 AOF 的存储。从而保证数据不被丢失。  
3. 支持多种数据结构  
    Redis 支持多种数据类型，String、Hash、List、Set、Sorted Set，还有衍生的数据类型，如 BitMap、HyperLogLog、
    GEO 等。  
4. 支持多种编程语言   
    Redis 提供了多种语言的客户端，常见的有 Java、Python、PHP、Ruby、Lua、Nodejs、Go等主流语言。  
5. 功能丰富  
    Redis 的功能非常丰富，支持 Lua 脚本，支持事物，支持发布订阅，Pipeline等功能。  
6. 简单  
    简单主要体现在 Redis 不依赖第三方库，如其他缓存依赖 libevent。Redis 采用单线程模型，避免了多线程问题。  
7. 支持主从复制、高可用和分布式  
    Redis 从 2.8 开始使用哨兵机制支持高可用，从 3.0 版本开始支持集群和分布式。 

#### Redis 使用场景

Redis 最常使用的场景就是缓存了，但是 Redis 不仅仅可用作缓存，还可以使用 Redis 单线程的特性用作计数器;
使用 Redis 发布订阅的特性用作消息队列系统; 使用 Redis 有序集合的数据结构完成排行榜功能; 使用 Redis 
分布式锁功能；Redis 与社交网络结合；使用 Redis 布隆过滤器完成限流功能等。很多的场景都可以使用 Redis。


