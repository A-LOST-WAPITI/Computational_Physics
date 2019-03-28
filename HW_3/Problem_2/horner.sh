#!/usr/bin/env bash

appPath="./horner"
if [ ! -a  $appPath ]; then
    gcc ./horner.c -o $appPath -lm -lquadmath
fi
filePath="./horner.txt"
if [ ! -a  $filePath ]; then
    $appPath > $filePath
fi
python ./horner.py