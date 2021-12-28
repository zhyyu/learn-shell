#!/bin/bash
no1=4
no2=5

result=$no1+$no2;
echo $result
# 4+5

result=no1+no2;
echo $result
# no1+no2

let result=no1+no2;
echo $result
# 9

result=$[ no1 + no2 ]
echo $result
# 9

result=$[ $no1 + 5 ]
echo $result
# 9

result=$(( no1 + 5 ))
echo $result
# 9

result=`expr 4 + 5`
echo $result
# 9

result=$(expr $no1 + 5)
echo $result
# 9

### 以上只支持整数， 不支持浮点

echo "4 * 0.56" | bc
# 2.24

no=54;
result=`echo "$no * 1.5" | bc`
echo $result
# 81.0

