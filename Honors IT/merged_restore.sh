#!/bin/sh

# start here
kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
systemsetup="/usr/sbin/systemsetup"
networksetup="/usr/sbin/networksetup"
defaults="/usr/bin/defaults"
genericppd="/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd"
scutil="/usr/sbin/scutil"
airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
diskutil="/usr/sbin/diskutil"

$networksetup -detectnewhardware


echo "Turning off airport..."
$networksetup -setairportpower en1 off
$airport en1 prefs RequireAdminPowerToggle=YES
$systemsetup -setwakeonnetworkaccess on

echo "Turning on ssh..."
$systemsetup -setremotelogin on

echo "Turning on RemoteManagement..."
$kickstart -activate -configure -access -on -users hcadmin -privs -all -restart -agent

echo "Removing damaged PaperCut executable..."
rm -rv /Volumes/Macintosh\ HD/Applications/PCClient.app

echo "Getting ManagedInstalls.plist..."

if [ "$1" == "facultystaff" ]
then 
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/facultystaff_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/backup.sh -o "/usr/bin/backup.sh"
	/bin/chmod +x /usr/bin/backup.sh
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/facultystaff_ManagedInstalls.plist -o "/Library/LaunchAgents/edu.uh.honors.backup.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.backup.plist
elif [ "$1" == "presentation" ]
then
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	echo "Setting guest to automatic login..."
	/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser guest
elif [ "$1" == "consulting" ]
then
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
elif [ "$1" == "advisor" ]
then 
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/advisor_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/backup.sh -o "/usr/bin/backup.sh"
	/bin/chmod +x /usr/bin/backup.sh
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/facultystaff_ManagedInstalls.plist -o "/Library/LaunchAgents/edu.uh.honors.backup.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.backup.plist
elif ["$1" == "lab" ]
then
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/lab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	echo "Getting PaperCut login script..."
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/plists/edu.uh.honors.papercut.plist -o "/Library/LaunchAgents/edu.uh.honors.papercut.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.papercut.plist
else
	echo "Can't load ManagedInstalls.plist..."
fi

echo "Getting Office setup script..."
/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/curl_office_plists.sh -o "/usr/bin/curl_office_plists.sh"
/bin/chmod +x /usr/bin/curl_office_plists.sh

echo "Getting Office preferences login script..."
/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/plists/edu.uh.honors.curlofficeprefs.plist -o "/Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist"
/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist

echo "Disabling system sleep..."
/usr/bin/pmset sleep 0

echo "Enabling username and password fields..."
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool TRUE

echo "Setting munki to bootstrap mode..."
touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup

echo "Disable the save window state at logout..."
/usr/bin/defaults write com.apple.loginwindow 'TALLogoutSavesState' -bool false

echo "Disabling Software Update Automatic Checks"
softwareupdate --schedule off

echo "Restricting Active Directory logins..."
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts Password "*"
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts RealName "Login Window's custom net accounts"
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts PrimaryGroupID 206

/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Admins -t group com.apple.loginwindow.netaccounts
/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Authenticated\ Users -t group com.apple.loginwindow.netaccounts

if [ "$2" == "student"]
then
	echo "Adding students to allowed user list..." 
	/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Students -t group com.apple.loginwindow.netaccounts
fi

/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow
/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow Password "*"
/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow PrimaryGroupID 223
/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow RealName "Login Window ACL"

/usr/sbin/dseditgroup -o edit -n /Local/Default -a localaccounts -t group com.apple.access_loginwindow
/usr/sbin/dseditgroup -o edit -n /Local/Default -a com.apple.loginwindow.netaccounts -t group com.apple.access_loginwindow

echo "Disabling Gatekeeper..."

spctl --master-disable

if [ "$3" == "shared" ]
then
	echo "Installing script to disable screen lock..."
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/disable_screen_lock.sh -o "/usr/bin/disable_screen_lock.sh"
	/bin/chmod +x /usr/bin/curl_office_plists.sh
	
	/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/plists/edu.uh.honors.disablescreenlock.plist -o "/Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist
fi

echo "Enrolling device in Profile Manager..."
/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/profiles/trustprofile.mobileconfig -o "/usr/local/trustprofile.mobileconfig"
/usr/bin/profiles -I -F /usr/local/trustprofile.mobileconfig

/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/profiles/enrollment.mobileconfig -o "/usr/local/enrollment.mobileconfig"
/usr/bin/profiles -I -F /usr/local/enrollment.mobileconfig

echo "Finished applying firstboot settings."
 
echo "Sleeping for 15 seconds..."
sleep 15

echo "Done."
exit 0
