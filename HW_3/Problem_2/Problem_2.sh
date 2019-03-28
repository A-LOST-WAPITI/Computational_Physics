#!/usr/bin/env bash

appPath="./Problem_2"
if [ ! -a  $appPath ]; then
    gcc ./Problem_2.c -o $appPath -lm -lquadmath
fi
filePath="./Problem_2.txt"
if [ ! -a  $filePath ]; then
    $appPath > $filePath
fi
python ./Problem_2.py