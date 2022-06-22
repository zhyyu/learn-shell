# 17.1 基本的脚本函数
### 17.1.1 创建函数
- 两种格式可以用来在bash shell脚本中创建函数
```shell
function name { 
  commands
}

name() { 
  commands 
}
```

### 17.1.2 使用函数
- 函数定义代码要在调用代码之前
- 重定义了函数， 新定义会覆盖原来函数的定义
```shell
#!/bin/bash
# using a function in a script
function func1 {
   echo "This is an example of a function"
}
count=1
while [ $count -le 5 ]
do
func1
   count=$[ $count + 1 ]
done
echo "This is the end of the loop"
func1
echo "Now this is the end of the script"

```

# 17.2 返回值
### 17.2.1 默认退出状态码
- 默认函数退出状态码是最后一条命令状态码
- 函数执行结束, 可用$? 确定函数退出状态码
```shell
#!/bin/bash
# testing the exit status of a function
func1() {
  echo "trying to display a non-existent file"
  ls -l badfile
}
echo "testing the function: " 
func1
echo "The exit status is: $?"
```

### 17.2.2 使用return命令
- 函数一结束就取返回值
- 仅能返回0-255
```shell
#!/bin/bash
# using the return command in a function
function dbl {
   read -p "Enter a value: " value
   echo "doubling the value"
   return $[ $value * 2 ]
}
dbl
echo "The new value is $?"

```

### 17.2.3 使用函数输出
- 函数使用echo, 函数外使用$(functionName)
```shell
#!/bin/bash
# using the echo to return a value
function dbl {
   read -p "Enter a value: " value
   echo $[ $value * 2 ]
}
result=$(dbl)
echo "The new value is $result"

```

# 17.3 在函数中使用变量
### 17.3.1 向函数传递参数
- 函数名会在$0, 函数命令行上的任何参数都会通过$1、$2等, $#来判断传给函数的参数数目
- 必须将参数和函数放在同一行
  -  func1 $value1 10
```shell
#!/bin/bash
# passing parameters to a function
function addem {
   if [ $# -eq 0 ] || [ $# -gt 2 ]
   then
      echo -1
   elif [ $# -eq 1 ]
   then
      echo $[ $1 + $1 ]
   else
      echo $[ $1 + $2 ]
   fi
}
echo -n "Adding 10 and 15: "
value=$(addem 10 15)
echo $value
echo -n "Let's try adding just one number: "
value=$(addem 10)
echo $value
echo -n "Now trying adding no numbers: "
value=$(addem)
echo $value
echo -n "Finally, try adding three numbers: "
value=$(addem 10 15 20)
echo $value

```

### 17.3.2 在函数中处理变量
- 全局变量
  - 默认情况下，你在脚本中定义的任何变量都是全局变量。在函数外定义的变量可在函数内正常访问, 反正亦然
```shell
#!/bin/bash
# using a global variable to pass a value
function dbl {
 value=$[ $value * 2 ]
 invalue=123
}
read -p "Enter a value: " value
dbl
echo "The new value is: $value"
echo $invalue

```

- 局部变量
  - local关键字保证了变量只局限在该函数中
  - local temp
  - local temp=$[ $value + 5 ]
```shell
#!/bin/bash
# demonstrating the local keyword
function func1 {
   local temp=$[ $value + 5 ]
   result=$[ $temp * 2 ]
}
temp=4
value=6
func1
echo "The result is $result"
if [ $temp -gt $value ]
then
   echo "temp is larger"
else
   echo "temp is smaller"
fi

```

# 17.4 数组变量和函数
### 17.4.1 向函数传数组参数
```shell
#!/bin/bash
# array variable to function test
function testit {
   local newarray
   newarray=($(echo "$@"))
   echo "The new array value is: ${newarray[*]}"
}
myarray=(1 2 3 4 5)
echo "The original array is ${myarray[*]}"
testit ${myarray[*]}

```

### 17.4.2 从函数返回数组
```shell
#!/bin/bash
# returning an array value
function arraydblr {
   local origarray
   local newarray
   local elements
   local i
   origarray=($(echo "$@"))
   newarray=($(echo "$@"))
   elements=$[ $# - 1 ]
   for (( i = 0; i <= $elements; i++ ))
   {
      newarray[$i]=$[ ${origarray[$i]} * 2 ]
   }
   echo ${newarray[*]}
}
myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
arg1=$(echo ${myarray[*]})
result=($(arraydblr $arg1))
echo "The new array is: ${result[*]}"

```

# 17.6 创建库
- 函数库的关键在于source命令。source命令会在当前shell上下文中执行命令，而不是创建一个新shell
- source命令有个快捷的别名，称作点操作符(dot operator)。
  - . ./myfuncs

- myfuncs.sh
```shell
# my script functions
function addem {
   echo $[ $1 + $2 ]
}
function multem {
   echo $[ $1 * $2 ]
}
function divem {
   if [ $2 -ne 0 ]
   then
      echo $[ $1 / $2 ]
   else
      echo -1 
   fi
}

```

- import myfuncs.sh
```shell
#!/bin/bash
# using functions defined in a library file
. ./myfuncs.sh
value1=10
value2=5
result1=$(addem $value1 $value2)
result2=$(multem $value1 $value2)
result3=$(divem $value1 $value2)
echo "The result of adding them is: $result1"
echo "The result of multiplying them is: $result2"
echo "The result of dividing them is: $result3"

```

# 17.7 在命令行上使用函数
### 17.7.1 在命令行上创建函数
- 一种方法是采用单行方式定义函数
  - function divem { echo $[$1/$2]; }
  - devem 100 5
  - function doubleit { read -p "Enter value: " value; echo $[$value * 2 ]; }   // mac don't work, centos works
  - doubleit
- 另一种方法是采用多行方式来定义函数
  ```shell
  yuzhongyu@yuzhongyudeMacBook-Air chapter17_创建函数 % function multem {
  function> echo $[ $1 * $2 ]
  function> }
  yuzhongyu@yuzhongyudeMacBook-Air chapter17_创建函数 % multem 2 5
  10
  yuzhongyu@yuzhongyudeMacBook-Air chapter17_创建函数 %
  
  ```
### 17.7.2 在.bashrc文件中定义函数
```shell
$ cat .bashrc
# .bashrc
# Source global definitions
if [ -r /etc/bashrc ]; then
        . /etc/bashrc
fi
function addem {
   echo $[ $1 + $2 ]
}

$ cat .bashrc
# .bashrc
# Source global definitions
if [ -r /etc/bashrc ]; then
        . /etc/bashrc
fi
. /home/rich/libraries/myfuncs
```
- .bashrc shell还会将定义好的函数传给子shell进程
