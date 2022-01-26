# 11.2 创建shell脚本文件
- "#!/bin/bash" 
  - 在创建shell脚本文件时，必须在文件的第一行指定要使用的shell
  - 文件的每一行中输入命令，然后加一个回车符
  - 根据需要，使用分号将两个命令放在一行上
- chmod u+x test1
- ./test1

# 11.3 显示消息
- echo "This is a test to see if you're paying attention"
- echo 'Rich says "scripting is easy".'
  - echo命令可用单引号或双引号来划定文本字符串。如果在字符串中用到了它们，你需要在 文本中使用其中一种引号，而用另外一种来将字符串划定起来。
- echo -n "The time and date are: "
  - 去除结尾换行符

# 11.4 使用变量
### 11.4.1 环境变量
- echo "User info for userid: $USER"
- echo UID: $UID
- echo "The cost of the item is \$15"
  - 你可能还见过通过${variable}形式引用的变量。变量名两侧额外的花括号通常用来帮 助识别美元符后的变量名。

### 11.4.2 用户变量
- 使用等号将值赋给用户变量。在变量、等号和值之间不能出现空格
```shell
days=10
guest="Katie"
echo "$guest checked in $days days ago"
days=5
guest="Jessica"
echo "$guest checked in $days days ago"

value1=10
value2=$value1
echo The resulting value is $value2
```

### 11.4.3 命令替换
- testing='date'
- testing=$(date)

```shell
#!/bin/bash
testing=$(date)
echo "The date and time are: " $testing

#!/bin/bash
# copy the /usr/bin directory listing to a log file
today=$(date +%y%m%d)
ls /usr/bin -al > log.$today
```

> 命令替换会创建一个子shell来运行对应的命令。子shell(subshell)是由运行该脚本的shell 所创建出来的一个独立的子shell(child shell)。正因如此，由该子shell所执行命令是无法 使用脚本中所创建的变量的。

# 11.5 重定向输入和输出
### 11.5.1 输出重定向
- date > test6 (覆盖)
- date >> test6 (追加)

### 11.5.2 输入重定向
- wc < test6
- 内联输入重定向
```shell
$ wc << EOF
> test string 1
> test string 2
> test string 3
> EOF
```

# 11.6 管道
- 不使用管道实现
```shell
$ rpm -qa > rpm.list
$ sort < rpm.list
```

- 使用管道
```shell
rpm -qa | sort
rpm -qa | sort | more
```

# 11.7 执行数学运算
### 11.7.1 expr命令
- expr 1 + 5
- expr 5 \* 2

```shell
#!/bin/bash
# An example of using the expr command
var1=10
var2=20
var3=$(expr $var2 / $var1)
echo The result is $var3
```

### 11.7.2 使用方括号
```shell
$ var1=$[1 + 5]
$ echo $var1
6
$ var2=$[$var1 * 2]
$ echo $var2
12
```

```shell
#!/bin/bash
var1=100
var2=50
var3=45
var4=$[$var1 * ($var2 - $var3)]
echo The final result is $var4
```

- bash shell数学运算符只支持整数运算

### 11.7.3 浮点解决方案
```shell
$ bc -q
3.44 / 5
0
scale=4
3.44 / 5
.6880
quit

$ bc -q
var1=10
var1 * 4
40
var2 = var1 / 5
print var2
2
quit
```

- 在脚本中使用bc
```shell
#!/bin/bash
var1=$(echo "scale=4; 3.44 / 5" | bc)
echo The answer is $var1
```

```shell
#!/bin/bash
var1=10.46
var2=43.67
var3=33.2
var4=71

var5=$(bc << EOF
scale = 4
a1 = ( $var1 * $var2)
b1 = ($var3 * $var4)
a1 + b1
EOF
)

echo The final answer for this mess is $var5
```

# 11.8 退出脚本
### 11.8.1 查看退出状态码
```shell
$ date
Sat Jan 15 10:01:30 EDT 2014
$ echo $?
0
```
- 成功结束的命令的退出状态码是0

### 11.8.2 exit命令
- 默认情况下，shell脚本会以脚本中的最后一个命令的退出状态码退出。
- 你可以改变这种默认行为，返回自己的退出状态码。exit命令允许你在脚本结束时指定一
  个退出状态码。
```shell
#!/bin/bash
# testing the exit status
var1=10
var2=30
var3=$[$var1 + $var2]
echo The answer is $var3
exit 5

```
