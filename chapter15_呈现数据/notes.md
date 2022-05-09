# 15.1 理解输入和输出
### 15.1.1 标准文件描述符
- 0 STDIN
  - 键盘 or < 重定向
- 1 STDOUT
  - 显示器 or > >> 重定向
  - 当命令生成错误消息时，shell并未将错误消息重定向到输出重定向文件
- 2 STDERR
  - 显示器

### 15.1.2 重定向错误
- 只重定向错误
  - ls -al badfile 2> test4
  - ls -al test badtest test2 2> test5
- 重定向错误和数据
  - ls -al test test2 test3 badtest 2> test6 1> test7
  - ls -al test test2 test3 badtest &> test7  // 为了避免错误信息散落在输出文件中，相较于标准输出，bash shell自动赋予了错误消息更高的优先级

# 15.2 在脚本中重定向输出
### 15.2.1 临时重定向
- ./test8.sh 2> test9
```shell
#!/bin/bash
# testing STDERR messages
echo "This is an error" >&2
echo "This is normal output"

```

### 15.2.2 永久重定向
```shell
#!/bin/bash
# redirecting output to different locations
exec 2>testerror
echo "This is the start of the script"
echo "now redirecting all output to another location"
exec 1>testout
echo "This output should go to the testout file"
echo "but this should go to the testerror file" >&2

```

# 15.3 在脚本中重定向输入
```shell
#!/bin/bash
# redirecting file input
exec 0< testfile
count=1
while read line
do
   echo "Line #$count: $line"
   count=$[ $count + 1 ]
done

```

# 15.4 创建自己的重定向
### 15.4.1 创建输出文件描述符
```shell
#!/bin/bash
# using an alternative file descriptor
exec 3>test13out
echo "This should display on the monitor"
echo "and this should be stored in the file" >&3
echo "Then this should be back on the monitor"

```
### 15.4.2 重定向文件描述符
```shell
#!/bin/bash
# storing STDOUT, then coming back to it
exec 3>&1
exec 1>test14out
echo "This should store in the output file"
echo "along with this line."
exec 1>&3
echo "Now things should be back to normal"

```

### 15.4.3 创建输入文件描述符
```shell
#!/bin/bash
# redirecting input file descriptors
exec 6<&0
exec 0< testfile
count=1
while read line
do
  echo "Line #$count: $line"
  count=$[ $count + 1 ]
  done
exec 0<&6
read -p "Are you done now? " answer
case $answer in
Y|y) echo "Goodbye";;
N|n) echo "Sorry, this is the end.";;
esac

```

### 15.4.5 关闭文件描述符
```shell
exec 3>&-
```

# 15.5 列出打开的文件描述符
```shell
/usr/sbin/lsof -a -p $$ -d 0,1,2

COMMAND   PID      USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
zsh     88152 yuzhongyu    0u   CHR   16,7  0t87006 1879 /dev/ttys007
zsh     88152 yuzhongyu    1u   CHR   16,7  0t87006 1879 /dev/ttys007
zsh     88152 yuzhongyu    2u   CHR   16,7  0t87006 1879 /dev/ttys007

```

```shell
#!/bin/bash
# testing lsof with file descriptors
exec 3> test18file1
exec 6> test18file2
exec 7< testfile
/usr/sbin/lsof -a -p $$ -d0,1,2,3,6,7

```

# 15.6 阻止命令输出
```shell
ls -al > /dev/null
ls -al badfile test16 2> /dev/null

cat /dev/null > testfile  # 快速清除文件数据
```

# 15.7 创建临时文件
### 15.7.1 创建本地临时文件
```shell
mktemp testing.XXXXXX
```

### 15.7.2 在/tmp目录创建临时文件
```shell
mktemp -t test.XXXXXX
```

### 15.7.3 创建临时目录
```shell
mktemp -d dir.XXXXXX
```

# 15.8 记录消息
- tee命令相当于管道的一个T型接头。它将从STDIN过来的数据同时发往两处。一处是 STDOUT, 另一处是tee命令行所指定的文件名
```shell
date | tee testfile
date | tee -a testfile        // 将数据追加到文件中，必须用-a选项 否则覆盖
```
