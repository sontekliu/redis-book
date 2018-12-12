# Redis 常用命令 set

#### set 集合的特性

	1. 无序性 {1,2} == {2,1}
	2. 确定性
	3. 唯一性
		集合内的值是唯一不重复的

#### 1. sadd KEY member [member1, member2 ...]

向集合中添加元素，可以添加多个。返回已添加元素的个数

```shell
127.0.0.1:6379> sadd gender male female
(integer) 2
127.0.0.1:6379> sadd gender male
(integer) 0
```

如果添加已添加的元素则返回 0，表示未添加成功，体现了集合的唯一性。

#### 2. smembers KEY

查看集合中的元素，无序显示。

```shell
127.0.0.1:6379> smembers gender
1) "female"
2) "male"
```

#### 3. srem KEY member [member1, member2 ...]

删除集合中的元素，可一次性删除多个元素。返回成功删除元素的个数。

```shell
127.0.0.1:6379> srem gender male man
(integer) 1
```

#### 4. spop KEY [count]

返回并删除集合中 count 个随机元素，count 默认值是 1。体现了集合的无序性。

```shell
127.0.0.1:6379> sadd gender a b c d e f
(integer) 6
127.0.0.1:6379> spop gender 3
1) "female"
2) "d"
3) "b"
127.0.0.1:6379> smembers gender
1) "c"
2) "a"
3) "e"
4) "f"
127.0.0.1:6379> spop gender 10
1) "c"
2) "a"
3) "e"
4) "f"
127.0.0.1:6379> smembers gender
(empty list or set)
```

如果 count 数超出集合中的所有元素，则返回并删除集合中的所有元素。

#### 5. srandmember KEY [count]

同 spop 类似。只不过这个只是返回集合中的元素，但是并不删除集合中的元素。

#### 6. sismember KEY member

判断集合中是否存在 member。存在则返回 1，否则返回 0，区分大小写。

```shell
127.0.0.1:6379> sadd language java python go
(integer) 3
127.0.0.1:6379> sismember language JAVA
(integer) 0
127.0.0.1:6379> sismember language go
(integer) 1
```

#### 7. scard KEY

返回集合中所有元素的个数。

```shell
127.0.0.1:6379> scard language 
(integer) 3
```

#### 8. smove source dest member

将 source 集合中的 member 元素移动到 dest 集合中。若 dest 不存在则自动创建。移动成功返回 1，否则返回 0。

```shell
127.0.0.1:6379> sadd back java python go html
(integer) 4
127.0.0.1:6379> sadd web js css
(integer) 2
127.0.0.1:6379> smove back web html
(integer) 1
127.0.0.1:6379> smembers web
1) "js"
2) "html"
3) "css"
127.0.0.1:6379> smembers back
1) "go"
2) "python"
3) "java"
```

#### 9. sinter KEY1 KEY2 ...

求集合的交集，并返回。

```shell
127.0.0.1:6379> sinter web back
(empty list or set)
127.0.0.1:6379> sadd web nodejs
(integer) 1
127.0.0.1:6379> sadd back nodejs
(integer) 1
127.0.0.1:6379> sinter web back
1) "nodejs"
```

#### 10. sunion KEY1 KEY2 ...

求集合的并集，并返回。

```shell
127.0.0.1:6379> sunion web back
1) "nodejs"
2) "js"
3) "html"
4) "java"
5) "go"
6) "python"
7) "css"
```

#### 11. sdiff KEY1 KEY2 ...

求 KEY1 与 KEY2 以及 KEYN 的差集。

```shell
127.0.0.1:6379> sdiff web back
1) "js"
2) "css"
3) "html"
127.0.0.1:6379> sdiff back web
1) "java"
2) "go"
3) "python"
```

#### 12. sinterstore/sunionstore/sdiffstore dest KEY1 KEY2 ...

将集合 KEY1 与集合 KEY2 ... KEYN 的交集/并集/差集 存储到 dest 集合中。

```shell
127.0.0.1:6379> sunionstore dev web back
(integer) 7
127.0.0.1:6379> smembers dev
1) "nodejs"
2) "js"
3) "html"
4) "java"
5) "go"
6) "python"
7) "css"
```










