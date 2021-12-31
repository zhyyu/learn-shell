#!/bin/bash
for file in ./* ~/notExistFile
do
    if [ -d "$file" ]
    then
       echo "$file is a directory"
    elif [ -f "$file" ]
    then
       echo "$file is a file"
    else
       echo "$file doesn't exist"
    fi
done
