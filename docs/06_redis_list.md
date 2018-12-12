# Redis 常用命令 list

#### 1. lpush/rpush KEY VALUE [VALUE...]

从链表的左侧或者右侧插入数据，链表的存储顺序从左到右依次是 0,1,2...，从右侧的顺序是 -1,-2,-3...。

#### 2. lpop/rpop KEY

从链表的左侧或者右侧返回并删除链表的元素。

#### 3. lrange KEY start end

返回链表中从 start 到 end 的元素，包含 start 和 end。左侧从 0 开始，右侧从 -1 开始，返回所有元素：`lrange KEY 0 -1`。

#### 4. lrem KEY count VALUE

删除链表中的元素。count 绝对值表示删除元素的个数，当 count > 0 时，从左侧开始删除，count < 0 时从右侧删除。

```shell
127.0.0.1:6379> larange chars 0 -1
1) "b"
2) "c"
3) "a"
4) "d"
5) "c"
6) "b"
7) "a"
127.0.0.1:6379> lrem chars 2 c
(integer) 2
127.0.0.1:6379> larange chars 0 -1
1) "b"
2) "a"
3) "d"
4) "b"
5) "a"
```

#### 5. llen KEY

查看链表的长度

```shell
127.0.0.1:6379> llen chars
(integer) 5
```

#### 6. ltrim KEY start end

截取链表中 start 到 end 范围，并返回链表，包含 start 和 end。左侧从 0 开始，右侧从 -1 开始。

```shell
127.0.0.1:6379> larange chars 0 -1
1) "b"
2) "a"
3) "d"
4) "b"
5) "a"
127.0.0.1:6379> ltrim chars 2 4
OK
127.0.0.1:6379> larange chars 0 -1
1) "d"
2) "b"
3) "a"
```

#### 7. lindex KEY index

返回链表索引位置上的值，如：

```shell
127.0.0.1:6379> larange chars 0 -1
1) "d"
2) "b"
3) "a"
127.0.0.1:6379> lindex chars 2
"a"
```

#### 8. linsert KEY after|before searchValue newValue

在链表中寻找 searchValue 并在 searchValue 前后插入 newValue，并返回插入 newValue 之后链表的个数。一旦找到 searchValue 之后命令就结束了，因此不会插入多个 newValue；如果找不到 searchValue 则返回 -1，不会插入 newValue。

```shell
127.0.0.1:6379> larange chars 0 -1
1) "d"
2) "b"
3) "a"
127.0.0.1:6379> linsert chars before d c
(integer) 4
127.0.0.1:6379> linsert chars before e c
(integer) -1
127.0.0.1:6379> linsert chars before b c
(integer) 5
127.0.0.1:6379> larange chars 0 -1
1) "c"
2) "d"
3) "c"
4) "b"
5) "a"
```
#### 9. rpoplpush source dest

把链表 source 的尾部拿出，放在 dest 的头部，并返回该单元值。该操作是原子性的。

```shell
127.0.0.1:6379> larange chars 0 -1
1) "c"
2) "d"
3) "c"
4) "b"
5) "a"
127.0.0.1:6379> rpoplpush chars dest
"a"
127.0.0.1:6379> lrange dest 0 -1
1) "a"
127.0.0.1:6379> lrange chars 0 -1
1) "c"
2) "d"
3) "c"
4) "b"
```

#### 10. blpop/brpop KEY timeout

等待弹出链表的头/尾元素，如果链表为空，timeout 为等待超时时间，timeout 为 0 则一直等待。

适用场景：长轮询 Ajax，在线聊天等。




