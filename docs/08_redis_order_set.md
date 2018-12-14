# Redis 常用命令 zset

既然集合是无序的，但是现在又有有序集合，所以有序集合中的元素必然有响应的权重，比如身高、体重、年龄等，但是为了方便讨论，统一命名为 score。

#### 1. zadd KEY score member [score1 member ...]

向集合中添加元素。有序集合的元素依然是唯一的。

```shell
127.0.0.1:6379> zadd language 10 java 8 python 6 C++ 5 php 4 go 3 nodejs
(integer) 6
127.0.0.1:6379> zadd language 9 java
(integer) 0
```

`zadd language 9 java` 表示添加元素不成功，但是 java 对应的 score 变成 9 了。

#### 2. zrange KEY start stop [WITHSCORES]

查看指定排名范围内的数据，从 0 开始，包括 start 和 end，默认按照 score 升序显示，WITHSCORES 显示每个元素对应的 score。

```shell
127.0.0.1:6379> zrange language 0 2
1) "nodejs"
2) "go"
3) "php"
127.0.0.1:6379> zrange language 0 2 withscores
1) "nodejs"
2) "3"
3) "go"
4) "4"
5) "php"
6) "5"
```

#### 3. zrevrange KEY start stop [WITHSCORES]

同 2 一样，但是是降序显示。

#### 4. zrangebyscore KEY min max [WITHSCORES] [LIMIT offset count]

查询集合(升序) score 在 min 和 max 范围内的元素，并跳过 offset 个，取出 count 个。

```shell
127.0.0.1:6379>  zrangebyscore language 3 6 withscores limit 1 2
1) "go"
2) "4"
3) "php"
4) "5"
```

#### 5. zcard KEY

返回元素的个数

```shell
127.0.0.1:6379>  zcard language
(integer) 6
```

#### 6. zrank KEY member

给定元素显示对应的排名，注意是从 0 开始，默认升序。`zrevrank KEY member` 降序排列显示对应排名。

```shell
127.0.0.1:6379>  zrank language go
(integer) 1
```

#### 7. zremrangebyrank KEY start stop

#### 8. zremrangebyscore KEY min max