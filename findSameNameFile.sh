#!/bin/bash  
  
#获取查找的目录名  
if [ 'x' == 'x'$1 ]; then  
    echo "Usage $0 search_dir"  
    exit  
fi  
  
#变量定义  
dir=$1
store_path="/tmp/1.txt"  
if [ -f $store_path ]; then  
    rm -r $store_path  
fi  
  
#获取所有的文件  
find $dir -type f -name "*.m" >> $store_path 
  
#输出重复的文件名  
for file in $(awk -F '/' '{print $NF}' $store_path  | sort | uniq -d)  
do  
    #echo $file  
    echo ====
    find $dir -name "$file"
done  
