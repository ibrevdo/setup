
#!/bin/bash

exclude_list="--exclude=plugged --exclude=pack"
files=$(diff -rq $exclude_list medium full | grep differ | sed "s/^Files //g; s/ differ$//g; s/ and /:/g")

for file in $files; do 
    vimdiff ${file%:*} ${file#*:}; 
done

# for file in $(diff -rq $exclude_list medium full | grep differ | sed "s/^Files //g; s/ differ$//g; s/ and /:/g"); do 
#     vimdiff ${file%:*} ${file#*:}; 
# done
