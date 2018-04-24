#!/bin/bash 

echo "============================="
echo " install default Utilities"
echo "============================="

apt-get update
apt-get install -y curl wget sudo telnet nano monit software-properties-common
