#!/bin/sh

function scriptcontents {
/sbin/kextload /System/Library/Extensions/IOUSBFamily.kext
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
