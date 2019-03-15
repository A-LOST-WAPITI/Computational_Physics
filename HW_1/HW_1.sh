#!/usr/bin/env bash

filePath="./lcrs.txt"

maxIndex=0
minIndex=0
flag=1
#得到最大值索引
function getMaxIndex () {
    local arr=($1)
    local length=${#arr[@]}
    local max=-100000
    for((i=0;i<$length;i++)); do
        local var=$(echo "${arr[$i]}>$max" | bc)
        if [ "$var" -eq 1 ]; then
            max=${arr[$i]}
            maxIndex=$i
        fi
    done
}
#得到最小值索引
function getMinIndex () {
    local arr=($1)
    local length=${#arr[@]}
    local min=100000
    for((i=0;i<$length;i++)); do
        local var=$(echo "${arr[$i]}<$min" | bc)
        if [ "$var" -eq 1 ]; then
            min=${arr[$i]}
            minIndex=$i
        fi
    done
}

rawStr=$(cat $filePath | xargs) #读入文件并去除换行符
str=${rawStr##*#}   #刨除“#”符号的影响
arr=($str)
unset cz theta phi AM
length=${#arr[@]}
for((i=0;i<$length;i+=4)); do
    cz+=("${arr[i]}")
    theta+=("${arr[i+1]}")
    phi+=("${arr[i+2]}")
    AM+=("${arr[i+3]}")
done
#新建用于存储的索引的列表
unset czIndex AMIndex
#结果字符串
unset result
result+="Ploblem 2 \n"
#A部分的解答
result+="Part A \n"
getMaxIndex "${cz[*]}"
getMinIndex "${cz[*]}"
czIndex=($maxIndex $minIndex)
result+="The lagest recession velocity is: ${cz[$maxIndex]}. \n"
result+="The smallest recession velocity is: ${cz[$minIndex]}. \n"
#B部分的解答
result+="Part B \n"
getMaxIndex "${AM[*]}"
getMinIndex "${AM[*]}"
result+="The recession velocities of the brightest galaxies is: ${cz[$minIndex]}. \n"
result+="The recession velocities of the faintest galaxies is: ${cz[$maxIndex]}. \n"
#C部分的解答
echo -e $result
result+="Part C \n"
echo -e "Please input the answer for Part C:"
read partC
result+=$partC
#输出到文件
echo -e $result > galaxies.txt