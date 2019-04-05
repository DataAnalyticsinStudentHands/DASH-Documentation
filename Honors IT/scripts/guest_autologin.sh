#!/bin/sh

function scriptcontents {
defaults write /Library/Preferences/com.apple.loginwindow "autoLoginUser" guest
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
