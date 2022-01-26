### 8.2.1 创建分区
- /dev/hdx
  - 其中x表示一个字母，具体是什么要根据驱动器的检测顺序(第一个驱动器是a，第二个驱动器是b，以此类推)
- /dev/sdx
- fdisk /dev/sdb

### 8.2.2 创建文件系统
- mkfs.ext4 /dev/sdb1
- mkdir /mnt/my_partition
- mount -t ext4 /dev/sdb1 /mnt/my_partition
