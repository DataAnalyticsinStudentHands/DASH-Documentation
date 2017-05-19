#!/bin/sh

compare="user is a member of the group"

echo "Checking login for user:" $3 >> $1/var/log/secure.log

result=dsmemberutil checkmembership -U $3 -G HC\ Authenticated\ Users

if["$result" = "$compare"]; then
	echo "Login success for user: " $3
fi
