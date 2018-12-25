# Redis 常用命令 zset

既然集合是无序的，但是现在又有有序集合，所以有序集合中的元素必然有相应的权重，比如身高、体重、年龄等，但是为了方便讨论，统一命名为 score。

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

#### 6. zcount KEY min max

返回 min ~ max 区间内元素的数量。

```shell
127.0.0.1:6379> zcount language 0 5
(integer) 3
```

#### 7. zrank KEY member

给定元素显示对应的排名，注意是从 0 开始，默认升序。`zrevrank KEY member` 降序排列显示对应排名。

```shell
127.0.0.1:6379>  zrank language go
(integer) 1
```

#### 8. zremrangebyscore KEY min max

按照 score 删除集合中的元素，包括 min 和 max。

```shell
127.0.0.1:6379>  zremrangebyscore language 0 4
(integer) 2
127.0.0.1:6379>  zrange language 0 -1 withscores
1) "php"
2) "5"
3) "C++"
4) "6"
5) "python"
6) "8"
7) "java"
8) "9"
```

#### 9. zremrangebyrank KEY start stop

根据元素在集合中的排序来删除，包括 start 和 stop。
```shell
127.0.0.1:6379>  zremrangebyrank language 0 4
(integer) 4
127.0.0.1:6379>  zrange language 0 -1 withscores
(empty list or set)
```

#### 10. zrem KEY member [member1 member2 ...]

删除集合内指定的元素，可以一次删除多个。

```shell
127.0.0.1:6379>  zadd language 10 java 8 python 6 C++ 5 php 4 go 3 nodejs
(integer) 4
127.0.0.1:6379>  zrem language nodejs php
(integer) 2
127.0.0.1:6379>  zrange language 0 -1 withscores
1) "go"
2) "4"
3) "C++"
4) "6"
5) "python"
6) "8"
7) "java"
8) "9"
```

#### 11. zinterstore destKey numkeys key [key ...] [WEIGHTS weight [weight ...]] [AGGREGATE SUM|MIN|MAX]

取得几个集合的交集并存储到 destKey 集合中。此命令比较长，分别做如下解释：

**destKey ：** 求的交集之后存储的目标集合    
**numkeys ：** 表示有多个集合进行交集运算，如果有三个集合做交集运算，numkeys 则等于 3  
**weights ：** 权重，即集合中的元素 score \* weight ，weight 的顺序同集合的顺序。如：`zinterstore result 2 key1 key2 weights 2 3` 则表示集合 key1 中元素 score \* 2，集合 key2 中的元素 score \* 3之后，再进行交集运算，即 result 集合中元素的 score 的值分别为 ：key1_score \* 2 + key2_score \* 3，默认是求和运算。   
**aggregate sum|min|max ：** 表示集合进行并集运算时，集合对应元素 score 的计算规则，默认是 sum。

```shell
127.0.0.1:6379> zadd zhangsan 2 cat 3 dog
(integer) 2
127.0.0.1:6379> zadd lisi 3 cat 1 dog 4 chicken
(integer) 3
127.0.0.1:6379> zinterstore result 2 zhangsan lisi weights 2 3 aggregate max
(integer) 2
127.0.0.1:6379> zrange result 0 -1 withscores 
1) "dog"
2) "6"
3) "cat"
4) "9"
```

#### 12. zunionstore destKey numkeys key [key ...] [WEIGHTS weight [weight ...]] [AGGREGATE SUM|MIN|MAX]

同 11 类似，只不过 zunionstore 是求并集。

 




