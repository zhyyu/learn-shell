# 测试环境 docker centos
- docker pull centos:centos8
- docker run -d --name ccentos centos:centos8 sleep 999999999
- docker exec -it ccentos /bin/bash
- ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime


# 其他
- cat /etc/os-release
- uname -a
- cat /proc/cpuinfo
