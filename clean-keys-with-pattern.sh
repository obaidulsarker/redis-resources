#!/bin/bash

#######################################################################################################
# Set your parameters
#######################################################################################################
port=6379
host="localhost"
password="xxxxxxxxxxxxxx"
pattern="spring:session:sessions*"
#######################################################################################################

echo -e "\nRedis @$host:$port"
echo -e "\nTrying to delete all keys with pattern: $pattern\n"

#echo -e "\nEnter Redis Password : "
#read -s password

keys_found=`redis-cli -p $port -h $host -a $password --raw --no-auth-warning KEYS $pattern | xargs | wc -w`

if [ "$keys_found" -eq "0" ]; then
    echo -e "\nKeys not found using pattern $pattern\n"
    exit 1
fi

echo ""
echo "Deleting all keys with pattern $pattern"
redis-cli -p $port -h $host -a $password  --no-auth-warning KEYS $pattern | xargs redis-cli -p $port -h $host -a $password --raw  --no-auth-warning DEL
echo "Deletion is successfull!"
