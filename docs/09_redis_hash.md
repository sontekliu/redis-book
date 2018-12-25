# Redis 常用命令 hash

#### 1. hset KEY feild value

设置 KEY 中的 feild 属性值为 value

```shell
127.0.0.1:6379> hset account name zhangsan
(integer) 1
```

#### 2. hmset KEY feild value [feild2 value2 ... feildN valueN]

设置 KEY 中属性 feild1 ... feildN 中的值分别为 value1 ... valueN

```shell
127.0.0.1:6379> hmset account age 20 address beijing
OK
```

#### 3. hget KEY feild

获取 KEY 中 feild 属性的值

```shell
127.0.0.1:6379> hget account age 
"20"
```

#### 4. hmget KEY feild ... feildN

获取 KEY 中多个 feild 属性的值

```shell
127.0.0.1:6379> hmget account name age
1) "zhangsan"
2) "20"
```

#### 5. hgetall KEY 

获取 KEY 中所有的属性和值

```shell
127.0.0.1:6379> hmget account name age
1) "name"
2) "zhangsan"
3) "age"
4) "20"
5) "address"
6) "beijing"
```

#### 6. hlen KEY

返回 KEY 中 feild 属性的个数

```shell
127.0.0.1:6379> hlen account
(integer) 3
```

#### 7. hdel KEY feild [feild ... feildN]

删除 KEY 中的 feild 属性

```shell
127.0.0.1:6379> hdel account age
(integer) 1
```

#### 8. hexists KEY feild

判断 KEY 中是否存在 feild 属性，存在返回 1 ，否则返回 0

```shell
127.0.0.1:6379> hexists account age
(integer) 0
127.0.0.1:6379> hexists account name
(integer) 1
```

#### 9. hkeys KEY

返回 KEY 中 所有的 feild 

```shell
127.0.0.1:6379> hkeys account
1) "name"
2) "address"
```

#### 10. hvals KEY 

返回 KEY 中 所有的 feild 对应的 value

```shell
127.0.0.1:6379> hvals account
1) "zhangsan"
2) "beijing"
```

#### 11. hstrlen KEY feild

返回 KEY 中对应 feild 属性的长度

```shell
127.0.0.1:6379> hstrlen account name
(integer) 8
```




