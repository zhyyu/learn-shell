### 6.1.1 全局环境变量
- ls $HOME

### 6.1.2 局部环境变量
- set
  - 局部变量、全局变量 以及用户定义变量

### 6.2.1 设置局部用户定义变量
- my_variable="Hello World"
  - 如果要给变量赋一个含有空格的字符串值，必须用单引号来界定字符串的首和尾
  - 变量名、等号和值之间没有空格

### 6.2.2 设置全局环境变量
- my_variable="I am Global now"
- export my_variable
- 在设定全局环境变量的进程所创建的子进程中，该变量都是可见的
- 修改子shell中全局环境变量并不会影响到父shell中该变量的值
- 子shell甚至无法使用export命令改变父shell中全局环境变量的值

### 6.3 删除环境变量
- unset my_variable
- 如果你是在子进程中删除了一个全局环境变量， 这只对子进程有效。该全局环境变量在父进程中依然可用

### 6.5 设置PATH环境变量
- PATH=$PATH:/home/christine/Scripts

### 6.6.1 登录shell
- /etc/profile (/etc/profile.d)
- $HOME/.bash_profile
- $HOME/.bashrc 
- $HOME/.bash_login
- $HOME/.profile

- shell会按照按照下列顺序，运行第一个被找到的文件，余下的则被忽略:
- $HOME/.bash_profile
  - 包含 $HOME/.bashrc
- $HOME/.bash_login
- $HOME/.profile

### 6.7 数组变量
- mytest=(one two three four five)
- echo ${mytest[2]}
- echo ${mytest[*]}
- mytest[2]=seven
