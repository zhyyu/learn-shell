### 5.2 shell 的父子关系
- ps --forest
- (pwd ; ls ; cd /etc ; pwd ; cd ; pwd ; ls ; echo $BASH_SUBSHELL)
  - 进程列表(用括号包裹), 生成子shell执行 

### 5.2.2 别出心裁的子shell用法
- sleep 3000&
- jobs -l

### 5.3.1 外部命令
- 如ps (会fork 子进程处理)
- which ps
- type -a ps

### 5.3.2 内建命令
- cd exit (不会fork 子进程处理)
- type cd
- alias -p
- alias li='ls -li'
