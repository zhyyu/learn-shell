### 4.1.2 实时监测进程
- top
    - H 切换线程
    - 1 显示多个cpu
    - f 修改排序

### 4.2.1 挂载存储媒体
- mount
  - 设备名，文件目录，文件类型，访问状态
- umount
  - lsof /root/test (查看使用进程)

### 4.2.3 使用du命令
- du -h

### 4.3.1 排序数据
- sort -n file2
- sort -t ':' -k 3 -n /etc/passwd
- du -sh * | sort -nr

### 4.3.2 搜索数据
- grep three file1
- grep -n three file1
- grep -e t -e f file1

### 4.3.3 压缩数据
- gzip myprog

### 4.3.4 归档数据
- tar -cvf test.tar test/ test2/
- tar -tf test.tar (列出tar文件test.tar的内容(但并不提取文件))
- tar -xvf test.tar (提取内容)
- tar -zxvf filename.tgz
