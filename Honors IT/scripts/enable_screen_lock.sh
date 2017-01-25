#!/bin/sh

osascript="/usr/bin/osascript"


osascript -e 'tell application "System Events" to set require password to wake of security preferences to true'
#Doesn't work
#defaults write com.apple.screensaver askForPassword -int 0
