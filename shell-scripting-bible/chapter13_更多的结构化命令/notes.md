# 13.1 for命令
```shell
for var in list
do
  commands
done

for var in list; do
  commands
done
```
- $var 变量包含着这次迭代对应的当前列表项中的值

### 13.1.1 读取列表中的值
```shell
#!/bin/bash
# testing the for variable after the looping
for test in Alabama Alaska Arizona Arkansas California Colorado
do
  echo "The next state is $test"
done
echo "The last state we visited was $test"
test=Connecticut
echo "Wait, now we're visiting $test"

```
- $test变量保持了其值，也允许我们修改它的值，并在for命令循环之外跟其他变量一样使用

### 13.1.2 读取列表中的复杂值
```shell
#!/bin/bash
# another example of how not to use the for command
for test in I don\'t know if "this'll" work
do
    echo "word:$test"
done
```
- 第一个有问题的地方添加了反斜线字符来转义don't中的单引号。在第二个有问题的地方
  将this'll用双引号圈起来。两种方法都能正常辨别出这个值

```shell
#!/bin/bash
# an example of how to properly define values
for test in Nevada "New Hampshire" "New Mexico" "New York"
do
    echo "Now going to $test"
done

```
- for命令用空格来划分列表中的每个值。如果在单独的数据值中有 空格，就必须用双引号将这些值圈起来

### 13.1.3 从变量读取列表
```shell
#!/bin/bash
# using a variable to hold the list
list="Alabama Alaska Arizona Arkansas Colorado"
list=$list" Connecticut"
for state in $list
do
    echo "Have you ever visited $state?"
done

```

### 13.1.4 从命令读取值
```shell
#!/bin/bash
# reading values from a file
file="states"
for state in $(cat $file)
do
    echo "Visit beautiful $state"
done

```

### 13.1.5 更改字段分隔符
- 内部字段分隔符(internal field separator)
  - IFS环境变量
  - 空格/ 制表符/ 换行符
  - IFS=$'\n'
    - 修改IFS的值，使其只能识别换行符
```shell
#!/bin/bash
# reading values from a file
file="states"
IFS=$'\n'
for state in $(cat $file)
do
    echo "Visit beautiful $state"
done

```

```shell
IFS.OLD=$IFS 
IFS=$'\n' 
<在代码中使用新的IFS值> 
IFS=$IFS.OLD
```
- 在一个地方需要修改IFS的值，然后忽略这次修改
- IFS=:    // 文件中用冒号分隔的值
- IFS=$'\n':;" // 换行符、冒号、分号和双引号

### 13.1.6 用通配符读取目录
```shell
#!/bin/bash
for file in ./*
do
    if [ -d "$file" ]
    then
       echo "$file is a directory"
    elif [ -f "$file" ]
    then
       echo "$file is a file"
    fi
done

```
- if [ -d "$file" ] 
  - 目录名和文件名中包含空格当然是合法的。要适应这种情况，应该将$file变 量用双引号圈起来。如果不这么做，遇到含有空格的目录名或文件名时就会有错误产生

```shell
#!/bin/bash
for file in ./* ~/notExistFile
do
    if [ -d "$file" ]
    then
       echo "$file is a directory"
    elif [ -f "$file" ]
    then
       echo "$file is a file"
    else
       echo "$file doesn't exist"
    fi
done

```

# 13.2 C 语言风格的 for 命令
### 13.2.1 C 语言的 for 命令
- for (( variable assignment ; condition ; iteration process ))
- for (( a = 1; a < 10; a++ ))
```shell
#!/bin/bash
# testing the C-style for loop
for (( i = 1; i <= 10; i++ ))
do
    echo "The next number is $i"
done

```

### 13.2.2 使用多个变量
```shell
#!/bin/bash
# multiple variables
for (( a=1, b=10; a <= 10; a++, b-- ))
do
    echo "$a - $b"
done

```

# 13.3 while命令
### 13.3.1 while的基本格式
```shell
while testcommand 
do
  other commands
done
```

```shell
#!/bin/bash
# while command test
var1=10
while [ $var1 -gt 0 ]
do
  echo $var1
  var1=$[ $var1 - 1 ]
done

```

### 13.3.2 使用多个测试命令
```shell
# testing a multicommand while loop
var1=10
while echo $var1
      [ $var1 -ge 0 ]
do
    echo "This is inside the loop"
    var1=$[ $var1 - 1 ]
done
```
- while命令允许你在while语句行定义多个测试命令。只有最后一个测试命令的退出状态码 会被用来决定什么时候结束循环
- 每个测试命令都出现在单独的一行上

# 13.4 until命令
```shell
until test commands do
  other commands
done
```
- 只有测试命令的退出状态码不为0，bash shell才会执行循环中列出的命令。 一旦测试命令返回了退出状态码0，循环就结束了
```shell
#!/bin/bash
# using the until command
var1=100
until [ $var1 -eq 0 ]
do
  echo $var1
  var1=$[ $var1 - 25 ]
done

```

```shell
#!/bin/bash
# using the until command
var1=100
until echo $var1
      [ $var1 -eq 0 ]
do
    echo Inside the loop: $var1
    var1=$[ $var1 - 25 ]
done

```

# 13.5 嵌套循环
```shell
#!/bin/bash
# nesting for loops
for (( a = 1; a <= 3; a++ ))
do
    echo "Starting loop $a:"
    for (( b = 1; b <= 3; b++ ))
    do
      echo "    Inside loop: $b"
    done
done

```

# 13.6 循环处理文件数据
```shell
#!/bin/bash
# changing the IFS value
IFS_OLD=$IFS
IFS=$'\n'
for entry in $(cat /etc/passwd)
do
    echo "Values in $entry –"
    IFS=:
    for value in $entry
    do
       echo "   $value"
    done
done

```

# 13.7 控制循环
### 13.7.1 break命令
```shell
#!/bin/bash
# breaking out of a for loop
for var1 in 1 2 3 4 5 6 7 8 9 10
do
    if [ $var1 -eq 5 ]
    then
      break
    fi
    echo "Iteration number: $var1"
done
echo "The for loop is completed"
```

- 3. 跳出外部循环
  - break n
  - 其中n指定了要跳出的循环层级。默认情况下，n为1，表明跳出的是当前的循环。如果你将n设为2，break命令就会停止下一级的外部循环
```shell
#!/bin/bash
# breaking out of an outer loop
for (( a = 1; a < 4; a++ ))
do
   echo "Outer loop: $a"
   for (( b = 1; b < 100; b++ ))
   do
      if [ $b -gt 4 ]
      then
        break 2
      fi
      echo "  Inner loop: $b"
    done
done

```

### 13.7.2 continue命令
```shell
#!/bin/bash
# using the continue command
for (( var1 = 1; var1 < 15; var1++ ))
do
    if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]
    then
      continue
    fi
    echo "Iteration number: $var1"
done

```

# 13.8 处理循环的输出
```shell
#!/bin/bash
# redirecting the for output to a file
for (( a = 1; a < 10; a++ ))
do
   echo "The number is $a"
done>test23.txt
echo "The command is finished."
```

```shell
#!/bin/bash
# piping a loop to another command
for state in "North Dakota" Connecticut Illinois Alabama Tennessee
do
   echo "$state is the next place to go"
done | sort
echo "This completes our travels"

```

# 13.9 实例
### 13.9.1 查找可执行文件
```shell
#!/bin/bash
# finding files in the PATH
IFS=:
for folder in $PATH
do
   echo "$folder:"
   for file in $folder/*
   do
      if [ -x $file ]
      then
          echo "   $file"
      fi
   done
done

```
