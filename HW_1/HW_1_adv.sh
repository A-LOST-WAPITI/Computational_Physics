#!/usr/bin/env bash

filePath="./lcrs.txt"

rawStr=$(cat $filePath | xargs) #读入文件并去除换行符
str=${rawStr##*#}   #刨除“#”符号的影响
echo -e $str > temp.txt
sed -i 's/ /\n/g' temp.txt
awk 'ORS=NR%4?" ":"\n"{print}' temp.txt > temp1.txt
minCZList=($(sort -n -k 1 < temp1.txt | head -1))
maxCZList=($(sort -n -k 1 < temp1.txt | tail -1))
minAMList=($(sort -n -k 4 < temp1.txt | tail -1))
maxAMList=($(sort -n -k 4 < temp1.txt | head -1))
rm -f ./temp* ./sort
minCZ=${minCZList[0]}
maxCZ=${maxCZList[0]}
minAM=${minAMList[0]}
maxAM=${maxAMList[0]}
echo "${minCZ},${maxCZ},${minAM},${maxAM}"