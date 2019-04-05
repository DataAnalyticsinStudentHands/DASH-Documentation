#!/bin/sh

function scriptcontents {
curl = "/usr/bin/curl"

curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.autoupdate2.plist -o ~/Library/Preferences/com.microsoft.autoupdate2.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.error_reporting.plist -o ~/Library/Preferences/com.microsoft.error_reporting.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.Excel.plist -o ~/Library/Preferences/com.microsoft.Excel.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.Word.plist -o ~/Library/Preferences/com.microsoft.Word.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.PowerPoint.plist -o ~/Library/Preferences/com.microsoft.PowerPoint.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.Outlook.plist -o ~/Library/Preferences/com.microsoft.Outlook.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.office.plist -o ~/Library/Preferences/com.microsoft.office.plist
curl http://hc-storage.cougarnet.uh.edu/office-plists/com.microsoft.outlook.databasedaemon.plist -o ~/Library/Preferences/com.microsoft.databasedaemon.plist
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
