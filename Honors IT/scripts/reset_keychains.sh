#!/bin/sh

function scriptcontents {
/usr/bin/find /Users -name Keychains -maxdepth 3 -mindepth 1 -type d -print -exec rm -rfv {} \;
reboot
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
