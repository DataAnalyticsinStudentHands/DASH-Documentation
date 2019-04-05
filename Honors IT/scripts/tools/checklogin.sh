#!/bin/sh

function scriptcontents {
compare="user is a member of the group"

echo "Checking login for user:" $3 >> $1/var/log/secure.log

result=dsmemberutil checkmembership -U $3 -G HC\ Authenticated\ Users

if["$result" = "$compare"]; then
	echo "Login success for user: " $3
fi
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
