#!/bin/bash

case "$1" in
    normal) sketchybar -m --set mode drawing=off; exit;;
    chrome) sketchybar -m --set mode drawing=on; exit;;
    *) log_error "Unkown function: $1()"; exit 2;;
esac
