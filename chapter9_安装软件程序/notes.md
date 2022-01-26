# 9.3 基于RedHat的系统
### 9.3.1 列出已安装包
- yum list installed
- yum list installed xterm (查看包是否已安装)
- yum provides /etc/yum.conf (找出系统上的某个特定文件属于哪个软件包)

### 9.3.2 用yum安装软件
- yum install xterm
- yum localinstall package_name.rpm

### 9.3.3 用yum更新软件
- yum list updates (列出所有已安装包的可用更新)
- yum update package_name (特定软件包更新)
- yum update (更新列表中的所有包进行更新)

### 9.3.4 用yum卸载软件
- yum remove package_name (只删除软件包而保留配置文件和数据文件)
- yum erase package_name (删除软件和它所有的文件)

### 9.3.5 处理损坏的包依赖关系
- yum clean all (损坏的包依赖关系(broken dependency))
- yum update
- yum update --skip-broken

### 9.3.6 yum软件仓库
- yum repolist (从哪些仓库中获取软件)
  - /etc/yum.repos.d 
