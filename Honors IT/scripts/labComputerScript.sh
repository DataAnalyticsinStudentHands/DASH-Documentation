#!/bin/bash

function scriptcontents {
username=$(whoami)

### Change the wallpaper to an Honors image.

osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/usr/local/honors/honorslabwallpaper.jpg"'




### Download a document with info on how to print double sided and other lpoptions

/usr/bin/curl -s http://hc-storage.cougarnet.uh.edu/honorslabdocuments/printing_info.pdf -o "/Users/$username/Desktop/printing_info.pdf"




### This section of the script sets the default lab printer every time a student logs in

# This needs to be false because it takes precedence over defaults
defaults write org.cups.PrintingPrefs UseLastPrinter -bool False

# Set default printer by computer name, as we want the eight closest to each printer printing there (taking care of case since our naming can be inconsistent)

name=$(hostname)
name=${name%".local"}
name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

if [[ "$name" == "hc-laba" || "$name" == "hc-labb" || "$name" == "hc-labc" || "$name" == "hc-labd" ||
      "$name" == "hc-labe" || "$name" == "hc-labf" || "$name" == "hc-labg" || "$name" == "hc-labh" ]]
then
  lpoptions -d mcx_1
  # Lab printer 20
else
  lpoptions -d mcx_0
  # Lab printer 21
fi




### This section of the script changes user settings for each student their first time logging into the lab

if [ ! -f /Users/$username/.initSetupDone ]; then

	# Change dock items
	/usr/bin/defaults delete /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps

	for APP in "Launchpad" "Google Chrome" "Firefox" "Safari" "Notes" "Stickies" "Calculator" "Maps" "Calendar" "System Preferences" "Pages" "Numbers" "Keynote" "Microsoft Word" "Microsoft Excel" "Microsoft PowerPoint" "Rstudio" "MATLAB_R2018a" "Atom" "Sublime Text" "Xcode" "MuseScore 3" "GIMP-2.10"
	do
		/usr/bin/defaults write /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
	done

  killall Dock

  # Prompt user to enable right click
  open /System/Library/PreferencePanes/Mouse.prefPane
  osascript -e 'display dialog "Hello. Welcome to the Honors Computer Lab. \n\nIf you would like to enable right-click, change the dropdown for the right side of the Mouse to Secondary Button. \n\nIf you want the direction of movement when you turn the scroll wheel to match that of a PC, deselect \"Scroll direction: Natural\"\n\nHonors IT"'

	touch /Users/$username/.initSetupDone
fi




apps=$(/usr/bin/defaults read /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps)

### Fix app list after previous deployments of this script. If it is determined another app should be on all lab Docks
### then it should be added to this if statement so that those students who logged in before the app was added will have
### it added to their Dock. Also, fixing a mistake where "MuseScore.app" was mistakenly used in this script instead of
### "Musescore 3.app"

if [[ "$apps" != *"Xcode"* || "$apps" != *"MuseScore 3"* || "$apps" != *"GIMP-2.10"* || "$apps" == *"MuseScore.app"* ]]; then

  /usr/bin/defaults delete /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps

  for APP in "Launchpad" "Google Chrome" "Firefox" "Safari" "Notes" "Stickies" "Calculator" "Maps" "Calendar" "System Preferences" "Pages" "Numbers" "Keynote" "Microsoft Word" "Microsoft Excel" "Microsoft PowerPoint" "Rstudio" "MATLAB_R2018a" "Atom" "Sublime Text" "Xcode" "MuseScore 3" "GIMP-2.10"
  do
    /usr/bin/defaults write /Users/$username/Library/Preferences/com.apple.dock.plist persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/$APP.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  done

  killall Dock
fi
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
