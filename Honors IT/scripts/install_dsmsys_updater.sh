#!/bin/bash

function scriptcontents {
install=false
hcstorage="http://hc-storage.cougarnet.uh.edu"
while IFS='' read -r line || [[ -n "$line" ]]; do #reads line by line
  IFS=',' read -ra LN <<< "$line" #splits lines by comma
  hostname=$(hostname -s)
  if [[ ${LN[0]} == $hostname ]]; then #places first field into names
    install=true
  fi
done < <(curl -s $hcstorage/TSM/TSM-NodeNames-Passwords.csv) #tells bash to read from TSM password file
if [ $install == false ]; then
  echo "Not a client"
  exit 0
fi
#if [ ! -f /usr/local/honors/dsm-sys_updater.sh ]; then
  echo "Getting dsm-sys_updater script..."
  /usr/bin/curl -s --show-error $hcstorage/scripts/dsm-sys_updater.sh > "/usr/local/honors/dsm-sys_updater.sh"
  /bin/chmod +x /usr/local/honors/dsm-sys_updater.sh
#fi

if [ ! -f /Library/LaunchDaemons/edu.uh.honors.dsmupdate.plist ]; then
  echo "Getting dsmupdate plist..."
  /usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.dsmupdate.plist -o "/Library/LaunchDaemons/edu.uh.honors.dsmupdate.plist"
  /bin/chmod 644 /Library/LaunchDaemons/edu.uh.honors.dsmupdate.plist
fi
echo "Loading plist..."
/bin/launchctl load /Library/LaunchDaemons/edu.uh.honors.dsmupdate.plist
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
