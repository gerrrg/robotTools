#!/bin/bash

if [ $# -eq 0 ]
  then
    echo "You must give the process a new name!"
    exit 1
fi

rm -rf $1
cp -r TEMPLATE_PROCESS $1

# get the upper level folder (in opt) before tackling anything else
for file in $(find $1 -name 'TEMPLATE_PROCESS')
do
	mv $file $(echo "$file" | sed -r "s|TEMPLATE_PROCESS|$1|g")
done

# rename nested files
for file in $(find $1 -name '*TEMPLATE_PROCESS*')
do
	mv $file $(echo "$file" | sed -r "s|TEMPLATE_PROCESS|$1|g")
done

# find and replace all instances of TEMPLATE_PROCESS
find $1 -type f -name "*" -print0 | xargs -0 sed -i '' -e "s/TEMPLATE_PROCESS/$1/g"
find . -type f -name "*deb.sh" -print0 | xargs -0 sed -i '' -e "s/TEMPLATE_PROCESS/$1/g"
