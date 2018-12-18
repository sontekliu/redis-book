# Redis 常用命令

#### 1. set 命令

> set KEY VALUE [ex 毫秒 | px 微妙] [nx] | [xx]

如果 ex 和 px 均设置，则以 px 为准  
nx : 表示 key 不存在时，执行操作  
xx : 表示 key 存在时，执行操作  

```shell
127.0.0.1:6379> set name sontek ex 10 nx
127.0.0.1:6379> set name sontek ex 10 xx
127.0.0.1:6379> set name sontek px 9000 xx
```

#### 2. mset、mget 命令

> mset 一次性设置多个值

```
127.0.0.1:6379> mset a java b python c go d php
```
> mget 一次性获取多个值

```
127.0.0.1:6379> mget a b c d 
1) "java"
2) "python"
3) "go"
4) "php"
```

#### 3. setrange KEY offset VALUE 设置偏移量值

```shell
127.0.0.1:6379> set hello world
127.0.0.1:6379> setrange hello 2 abcd
127.0.0.1:6379> get hello
"woabcd"
```

上述命令表示，从 world 的第 2 个字符开始使用 abcd 替换，字符索引是从 0 开始


```shell
127.0.0.1:6379> setrange hello 8 ??
127.0.0.1:6379> get hello
"woabcd\x00\x00??"
```

如果设置的偏移量的长度大于字符串长度，中间部分则使用 `\x00` 替换

#### 4. getrange KEY start end

获取字符串 `start` 到 `end` 范围的值，包括 `start` 和 `end`。字符串的下标从左边是从 0 开始，右边是从 -1 开始。

注意：  
如果 start >= length 则返回空  
如果 end >= length  则截取至字符串结尾  
如果 start 所处位置在 end 右边，则返回空字符串  

#### 5. append KEY VALUE

将指定的 `VALUE`  添加到 `KEY` 的尾部；

```shell
127.0.0.1:6379> set a java
127.0.0.1:6379> append a -redis
127.0.0.1:6379> get a
"java-redis"
```

#### 6. getset KEY NEW_VALUE

返回 `KEY` 的旧值，并设置新值 

```shell
127.0.0.1:6379> set a java
127.0.0.1:6379> getset a python
"java"
127.0.0.1:6379> get a 
"python"
```

#### 7. incr、decr 增加、减少操作

```shell
127.0.0.1:6379> set age 23
127.0.0.1:6379> incr age
(Integer) 24
127.0.0.1:6379> decr age
(Integer) 23

127.0.0.1:6379> set hello world
127.0.0.1:6379> incr hello
(error) ERR value is not an integer or out of range
```

注意：此处 `KEY` 的值只能是数字。

#### 8. incrby/decrby KEY offset 增加、减少 offset 

同 7 相似，只不过 `incr` 和 `decr` 只是增加和减少 1 ，而 `incrby` 和 `decrby` 可以指定增加或者减少的个数。

```shell
127.0.0.1:6379> set age 23
127.0.0.1:6379> incrby age 5
(Integer) 27
127.0.0.1:6379> decrby age 5
(Integer) 23
```

扩展：incrbyfloat KEY float 可以增加 `float` 类型

注意：没有 `decrbyfloat` 命令


#### 9. setbit KEY offset VALUE

设置某个 `key` 的 `offset` 二进制位上的值，并返回该位上的旧值。  
例如，设置某个 `KEY` 的值为任意大写字母，如果想让其变成小写字母，可使用此方法实现。

分析如下：  
`A` 的 `ASCII` 的值为 `65`，二进制表示为 `0100 0001`，而 `a` 的 `ASCII` 值为 `97`，比 `A` 多 `32`，只要在大写字母的 `ASCII` 值上面加 `32` 即可得到小写字母。

```shell
127.0.0.1:6379> set char A
127.0.0.1:6379> setbit char 2 1
(Integer) 0
127.0.0.1:6379> get char
"a"
```

如果 `offset` 过大，则会在中间填充 0。但是 `offset` 的值最大为 `2^32-1` ，所以可以推算出字符串的最大值为 `512M` 。

#### 10. getbit KEY offset 

获取某个 `key` 的某个位上的值。


#### 11. bitop OPERATION DESTKEY key1 key2 ...

对 `key1, key2 ... keyN` 做 `OPERATION` 操作，并将结果保存至 `DESTKEY` 中。`OPERATION` 可以是 `AND`、`OR`、`NOT`、`XOR`，分别是：与、或、非、异或。

如果设置一个 `KEY` 二进制为 `0010 0000`，如果任意大写字母与其进行异或操作，则可变为小写字母。

```shell
127.0.0.1:6379> setbit lower 2 1
(Integer) 0
127.0.0.1:6379> set char D
127.0.0.1:6379> get char 
"D"
127.0.0.1:6379> bitop or char char lower
(Integer) 0
127.0.0.1:6379> get char 
"d"
```


