### 7.1.1 /etc/passwd 文件
- cat /etc/passwd
  - 登录用户名
  - 用户密码
  - 用户账户的UID(数字形式)
  - 用户账户的组ID(GID)(数字形式) 
  - 用户账户的文本描述(称为备注字段) 
  - 用户HOME目录的位置
  - 用户的默认shell

### 7.1.3 添加新用户
- useradd -m test (-m命令行选项会使其创建HOME目录)

### 7.1.4 删除用户
- userdel -r test (加了-r参数后，用户先前的那个/home/test目录已经不存在了)

### 7.1.5 修改用户
- usermod
- passwd

### 7.2.1 /etc/group 文件
- cat /etc/group
  - 组名
  - 组密码
  - GID
  - 属于该组的用户列表

### 7.2.2 创建新组
- groupadd shared
- usermod -G shared rich

### 7.2.3 修改组
- groupmod -n sharing shared

### 7.3.1 使用文件权限符
- -代表文件
- d代表目录
- l代表链接
- c代表字符型设备 
- b代表块设备
- n代表网络设备

### 7.3.2 默认文件权限
- umask
  - 例： 文件一开始的权限是666(目录777)，减去umask值022之后，剩下的文件权限就成了644

### 7.4.1 改变权限
- chmod 760 newfile
- [ugoa...][[+-=][rwxXstugo...]
  - u代表用户
  - g代表组
  - o代表其他
  - a代表上述所有
  - +-= 后参数
  - X:如果对象是目录或者它已有执行权限，赋予执行权限。
  - s:运行时重新设置UID或GID。
  - t:保留文件或目录。
  - u:将权限设置为跟属主一样。
  - g:将权限设置为跟属组一样。
  - o:将权限设置为跟其他用户一样。
- chmod o+r newfile
- chmod u-x newfile

### 7.4.2 改变所属关系
- chown dan newfile
- chown dan.shared newfile
- chown .rich newfile
- chown test. newfile
- 只有root用户能够改变文件的属主。任何属主都可以改变文件的属组，但前提是属主必须 是原属组和目标属组的成员。
- chgrp shared newfile

### 7.5 共享文件
- mkdir testdir
- chgrp shared testdir
- chmod g+s testdir
- cd testdir
- touch testfile
- 用mkdir命令来创建希望共享的目录。然后通过chgrp命令将目录的默认属组改为包 含所有需要共享文件的用户的组(你必须是该组的成员)。最后，将目录的SGID位置位，以保证 目录中新建文件都用shared作为默认属组。
