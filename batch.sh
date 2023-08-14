#!/bin/bash

# 查找所有以“.root”为后缀的文件，并遍历每个文件
find . -type f -name "*.root" -print0 | while IFS= read -r -d '' file; do
    # 在每个文件名上执行root2csv.sh脚本
    ./root2csv.sh "$file"
done
