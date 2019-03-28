#!/usr/bin/env bash

appPath="./Problem_1"
if [ ! -a  $appPath ]; then
    gcc ./Problem_1.c -o $appPath -lm
fi
filePath="./Problem_1.txt"
if [ ! -a  $filePath ]; then
    $appPath > $filePath
fi
python ./Problem_1.py