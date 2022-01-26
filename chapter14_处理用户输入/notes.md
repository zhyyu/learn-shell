# 14.1 命令行参数
### 14.1.1 读取参数
- 位置参数变量是标准的数字:$0是程序名，$1是第 一个参数，$2是第二个参数，依次类推，直到第九个参数$9
```shell
#!/bin/bash
# using one command line parameter
#
factorial=1
for (( number = 1; number <= $1 ; number++ ))
do
  factorial=$[ $factorial * $number ]
done
echo The factorial of $1 is $factorial

```

```shell
#!/bin/bash
# testing two command line parameters #
total=$[ $1 * $2 ]
echo The first parameter is $1.
echo The second parameter is $2.
echo The total value is $total.

```

- 每个参数都是用空格分隔的，所以shell会将空格当成两个值的分隔符。要在参数值中包含空格，必须要用引号(单引号或双引号均可)。
    - ./test3.sh 'Rich Blum'

```shell
#!/bin/bash
# testing string parameters
#
echo Hello $1, glad to meet you.

```

### 14.1.2 读取脚本名
- basename命令会返回不包含路径的脚本名
```shell
#!/bin/bash
# Using basename with the $0 parameter
#
name=$(basename $0)
echo
echo The script name is: $name
echo $0

```

# 14.2 特殊参数变量
### 14.2.1 参数统计
- 特殊变量$#含有脚本运行时携带的命令行参数的个数
```shell
#!/bin/bash
# getting the number of parameters
#
echo There were $# parameters supplied.

```

- 不能在花括号内使用美元符。必须将美元符换成感叹 号
```shell
#!/bin/bash
# Grabbing the last parameter
#
params=$#
echo
echo The num of parameter is $params
echo The last parameter is ${!#}
echo

```

### 14.2.2 抓取所有的数据
```shell
#!/bin/bash
# testing $* and $@
#
echo
echo "Using the \$* method: $*"
echo
echo "Using the \$@ method: $@"

```

- $*变量会将所有参数当成单个参数，而$@变量会单独处理每个参数
```shell
#!/bin/bash
# testing $* and $@
#
echo
count=1
#
for param in "$*"
do
   echo "\$* Parameter #$count = $param"
   count=$[ $count + 1 ]
done
#
echo
count=1
#
for param in "$@"
do
   echo "\$@ Parameter #$count = $param"
   count=$[ $count + 1 ]
done

```

# 14.3 移动变量
- shift命令时，默认情况下它会将每个参数变量向左移动一个位置。所以，变量$3 的值会移到$2中，变量$2的值会移到$1中，而变量$1的值则会被删除(注意，变量$0的值，也 就是程序名，不会改变)
```shell
#!/bin/bash
# demonstrating the shift command
echo
    count=1
    while [ -n "$1" ]
    do
       echo "Parameter #$count = $1"
       count=$[ $count + 1 ]
       shift
done

```

- 也可以一次性移动多个位置，只需要给shift命令提供一个参数
```shell
#!/bin/bash
# demonstrating a multi-position shift
#
echo
echo "The original parameters: $*"
shift 2
echo "Here's the new first parameter: $1"

```

# 14.4 处理选项
### 14.4.1 查找选项
```shell
#!/bin/bash
# extracting command line options as parameters #
echo
while [ -n "$1" ]
do
   case "$1" in
     -a) echo "Found the -a option" ;;
     -b) echo "Found the -b option" ;;
     -c) echo "Found the -c option" ;;
      *) echo "$1 is not an option" ;;
   esac
   shift
done

```

- ./test16.sh -c -a -b -- test1 test2 test3
```shell
#!/bin/bash
# extracting options and parameters echo
while [ -n "$1" ]
do
   case "$1" in
      -a) echo "Found the -a option" ;;
      -b) echo "Found the -b option";;
      -c) echo "Found the -c option" ;;
      --) shift
          break ;;
       *) echo "$1 is not an option";;
      esac
      shift
done

#
count=1
for param in $@
do
   echo "Parameter #$count: $param"
   count=$[ $count + 1 ]
done

```

- ./test17.sh -a -b test1 -d
```shell
#!/bin/bash
# extracting command line options and values echo
while [ -n "$1" ]
do
   case "$1" in
      -a) echo "Found the -a option";;
      -b) param="$2"
          echo "Found the -b option, with parameter value $param"
          shift ;;
      -c) echo "Found the -c option";;
      --) shift
          break ;;
       *) echo "$1 is not an option";;
  esac
  shift
done

#
count=1
for param in "$@"
do
   echo "Parameter #$count: $param"
   count=$[ $count + 1 ]
done

```

### 14.4.2 使用getopt命令
- getopt ab:cd -a -b test1 -cd test2 test3
  -  -a -b test1 -c -d -- test2 test3
- getopt -q ab:cd -a -b test1 -cde test2 test3
- centos 下可运行， mac 下不可
```shell
#!/bin/bash
# Extract command line options & values with getopt #
set -- $(getopt -q ab:cd "$@")
#
echo
while [ -n "$1" ]
do
   case "$1" in
   -a) echo "Found the -a option" ;;
   -b) param="$2"
       echo "Found the -b option, with parameter value $param"
       shift ;;
   -c) echo "Found the -c option" ;;
   --) shift
       break ;;
    *) echo "$1 is not an option";;
  esac
  shift
done

#
count=1
for param in "$@"
do
   echo "Parameter #$count: $param"
   count=$[ $count + 1 ]
done
```

### 14.4.3 使用更高级的getopts
- ./test19.sh -ab test1 -c
- ./test19.sh -b "test1 test2" -a
- ./test19.sh -abtest1

```shell
#!/bin/bash
# simple demonstration of the getopts command
#
echo
while getopts :ab:c opt
do
   case "$opt" in
      a) echo "Found the -a option" ;;
      b) echo "Found the -b option, with value $OPTARG";;
      c) echo "Found the -c option" ;;
      *) echo "Unknown option: $opt";;
esac done

```

- ./test20.sh -a -b test1 -d test2 test3 test4
```shell
#!/bin/bash
# Processing options & parameters with getopts #
echo
while getopts :ab:cd opt
do
   case "$opt" in
   a) echo "Found the -a option"  ;;
   b) echo "Found the -b option, with value $OPTARG" ;;
   c) echo "Found the -c option"  ;;
   d) echo "Found the -d option"  ;;
   *) echo "Unknown option: $opt" ;;
   esac
done

#
shift $[ $OPTIND - 1 ]
#
echo
count=1
for param in "$@"
do
   echo "Parameter $count: $param"
   count=$[ $count + 1 ]
done

```

# 14.6 获得用户输入
### 14.6.1 基本的读取
- read
```shell
#!/bin/bash
# testing the read command
#
echo -n "Enter your name: "
read name
echo "Hello $name, welcome to my program. "

```

```shell
#!/bin/bash
# testing the read -p option
#
read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That makes you over $days days old! "

```

- 输入的每个 数据值都会分配给变量列表中的下一个变量。如果变量数量不够，剩下的数据就全部分配给最后 一个变量。
```shell
#!/bin/bash
# entering multiple variables
#
read -p "Enter your name: " first last
echo "Checking data for $last, $first..."

```

- 可以在read命令行中不指定变量。如果是这样，read命令会将它收到的任何数据都放进 特殊环境变量REPLY中
```shell
#!/bin/bash
# Testing the REPLY Environment variable #
read -p "Enter your name: "
echo
echo Hello $REPLY, welcome to my program.

```

### 14.6.2 超时
```shell
#!/bin/bash
# timing the data entry
#
if read -t 5 -p "Please enter your name: " name
then
   echo "Hello $name, welcome to my script"
else
   echo
   echo "Sorry, too slow! "
fi

```

- -n选项和值1一起使用，告诉read命令在接受单个字符后退出
```shell
#!/bin/bash
# getting just one character of input
#
read -n1 -p "Do you want to continue [Y/N]? " answer
case $answer in
Y | y) echo
       echo "fine, continue on...";;
N | n) echo
       echo OK, goodbye
       exit;;
esac
echo "This is the end of the script"

```

### 14.6.3 隐藏方式读取
```shell
#!/bin/bash
# hiding input data from the monitor
#
read -s -p "Enter your password: " pass
echo
echo "Is your password really $pass? "

```

### 14.6.4 从文件中读取
```shell
#!/bin/bash
# reading data from a file #
count=1
cat test.txt | while read line
do
   echo "Line $count: $line"
   count=$[ $count + 1]
done
echo "Finished processing the file"

```

