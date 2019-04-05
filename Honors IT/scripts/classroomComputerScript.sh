#!/bin/bash

function scriptcontents {
username=$(whoami)

### Change the wallpaper to an Honors image

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/usr/local/honors/classroomwallpaper.jpg"'




### Download a document with info on how to computer

/usr/bin/curl -s http://hc-storage.cougarnet.uh.edu/classroomdocuments/Computer_Guide.pdf -o "/Users/$username/Desktop/Computer_Guide.pdf"




### This section of the script changes dock items

/usr/bin/defaults delete /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps

for APP in "Launchpad" "Google Chrome" "Firefox" "Safari" "Calculator" "System Preferences" "Microsoft Word" "Microsoft Excel" "Microsoft PowerPoint" "Skype" "Skype for Business"
do
	/usr/bin/defaults write /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

killall Dock
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
