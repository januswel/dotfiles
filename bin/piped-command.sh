#!/bin/sh

while read -r arg;
do
    eval "$1";
done
