#!/bin/bash
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') && export DISPLAY=$IP:0 
open -a XQuartz && exec Xhost $IP &
exec docker-compose "$@"

