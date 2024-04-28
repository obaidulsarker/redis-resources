# Redis: deleting many keys with pattern matching using bash shell + redis-cli
## What do you need?
#### A bash shell
#### Redis installed with authentication enabled.
#### Redis-CLI

## USE CASE:
Sometimes you can have the need to remove a set of keys that match with a specific pattern in your Redis server (e.g. "mypattern*", "*mypattern*", "users*", etc.). To reach this goal you can develop a solution in some language (python, c#, java, etc.) or, alternatively, you can use Redis CLI. The script uses the second strategy.

## How the script works:
The script uses Redis CLI, running two commands:

KEYS, to get all keys match with the input pattern
DEL, to delete the keys (one at once).
The script read before all the keys matching the pattern using the command Redis CLI KEYS and then, it runs the command Redis CLI DEL to remove them. The script, to pipe each key to Redis CLI DEL command, use xargs, so each key can be deleted from Redis.

## Run the script:
you@yourworkstation$./clean-keys-with-pattern.sh
