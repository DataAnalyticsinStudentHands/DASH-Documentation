#!/bin/sh

function scriptcontents {
# Use "/usr/sbin/systemsetup -listtimezones" to see a list of available list time zones.
TimeZone="America/Chicago"
TimeServer="tick.uh.edu"

############# Pause for network services #############
/bin/sleep 20
#################################################

/usr/sbin/systemsetup -setusingnetworktime off

#Set an initial time zone
/usr/sbin/systemsetup -settimezone $TimeZone

#Set specific time server
/usr/sbin/systemsetup -setnetworktimeserver $TimeServer

# enable location services
uuid=`/usr/sbin/system_profiler SPHardwareDataType | grep "Hardware UUID" | cut -c22-57`
/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.$uuid LocationServicesEnabled -int 1
/usr/bin/defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.notbackedup.$uuid LocationServicesEnabled -int 1

# set time zone automatically using current location
/usr/bin/defaults write /Library/Preferences/com.apple.timezone.auto Active -bool true

/usr/sbin/systemsetup -setusingnetworktime on

/usr/sbin/systemsetup -gettimezone
/usr/sbin/systemsetup -getnetworktimeserver

/usr/bin/touch /var/db/ntp-kod
/usr/bin/sntp -Ss $TimeServer

exit 0
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
