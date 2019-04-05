#!/bin/sh

function scriptcontents {
  user=$(whoami)

  echo "/bin/bash /usr/local/honors/resetioUSB.sh" > $user/Desktop/Fix_Clicker.command
  chmod a+x $user/Desktop/Fix_Clicker.command
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
