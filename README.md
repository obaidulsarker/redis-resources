# Redis: deleting many keys with pattern matching using bash shell + redis-cli
## What do you need?
#### 1. A bash shell
#### 2. Redis installed with authentication enabled.
#### 3. Redis-CLI

## USE CASE:
Sometimes you can have the need to remove a set of keys that match with a specific pattern in your Redis server (e.g. "mypattern*", "*mypattern*", "users*", "spring:session:sessions*", etc.). To reach this goal you can develop a solution in some language (python, c#, java, etc.) or, alternatively, you can use Redis CLI. The script uses the second strategy.

## How the script works:
The script uses Redis CLI, running two commands:

KEYS, to get all keys match with the input pattern
DEL, to delete the keys (one at once).
The script read before all the keys matching the pattern using the command Redis CLI KEYS and then, it runs the command Redis CLI DEL to remove them. The script, to pipe each key to Redis CLI DEL command, use xargs, so each key can be deleted from Redis.

## Source Code:
<td>
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

</td>
## Run the script:
you@yourworkstation$./clean-keys-with-pattern.sh
