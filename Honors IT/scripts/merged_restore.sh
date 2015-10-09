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
hcstorage="http://hc-storage.cougarnet.uh.edu/web"


function turnOffAirport {
	$networksetup -detectnewhardware
	echo "Turning off airport..."
	$networksetup -setairportpower en1 off
	$airport en1 prefs RequireAdminPowerToggle=YES
	$systemsetup -setwakeonnetworkaccess on
}

function turnOnSSH {
	echo "Turning on ssh..."
	$systemsetup -setremotelogin on
}

function turnOnRemoteDesktop {
	echo "Turning on RemoteManagement..."
	$kickstart -activate -configure -access -on -users hcadmin -privs -all -restart -agent
}

function getManagedInstallsPlist {
	echo "Getting ManagedInstalls.plist..."
	if [ "$1" == "facultystaff" ]
	then 
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/facultystaff_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	elif [ "$1" == "presentation" ]
	then
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	elif [ "$1" == "consulting" ]
	then
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	elif [ "$1" == "advisor" ]
	then 
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/advisor_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	elif [ "$1" == "lab" ]
	then
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/lab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	elif [ "$1" == "dashlab" ]
	then
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/dashlab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	elif [ "$1" == "admin" ]
	then
		/usr/bin/curl -s --show-error $hcstorage/managedinstalls/admin_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
	else
		echo "Can't load ManagedInstalls.plist..."
	fi
}

function getOfficeSetupLaunchAgent {
	echo "Getting Office setup script..."
	/usr/bin/curl -s --show-error $hcstorage/scripts/curl_office_plists.sh -o "/usr/bin/curl_office_plists.sh"
	/bin/chmod +x /usr/bin/curl_office_plists.sh
	
	echo "Getting Office preferences login script..."
	/usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.curlofficeprefs.plist -o "/Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist
}

function getPaperCutLaunchAgent {
	echo "Getting PaperCut login script..."
	/usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.papercut.plist -o "/Library/LaunchAgents/edu.uh.honors.papercut.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.papercut.plist
}

function getScreenLockLaunchAgent {
	echo "Installing script to disable screen lock..."
	/usr/bin/curl -s --show-error $hcstorage/scripts/disable_screen_lock.sh -o "/usr/bin/disable_screen_lock.sh"
	/bin/chmod +x /usr/bin/disable_screen_lock.sh
	
	/usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.disablescreenlock.plist -o "/Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.disablescreenlock.plist
}

function getNetworkMountLaunchAgent {
	echo "Installing script to mount uhs1 share..."
	/usr/bin/curl -s --show-error $hcstorage/scripts/mount_uhsa1_share.sh -o "/usr/bin/mount_uhsa1_share.sh"
	/bin/chmod +x /usr/bin/mount_uhsa1_share.sh
	
	/usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.mountuhsa1share.plist -o "/Library/LaunchAgents/edu.uh.honors.mountuhsa1share.plist"
	/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.mountuhsa1share.plist
}

function getBackupLaunchDaemon {
	echo "Getting Backup Script..."
	/usr/bin/curl -s --show-error $hcstorage/scripts/backup.sh -o "/usr/bin/backup.sh"
	/bin/chmod +x /usr/bin/backup.sh
	
	/usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.backup.plist -o "/Library/LaunchDaemons/edu.uh.honors.backup.plist"
	/bin/chmod 644 /Library/LaunchDaemons/edu.uh.honors.backup.plist
}

function getKeychainResetLaunchDaemon {
	echo "Getting Keychain Fix Script..."
	/usr/bin/curl -s --show-error $hcstorage/scripts/reset_keychains.sh -o "/usr/bin/reset_keychains.sh"
	/bin/chmod +x /usr/bin/reset_keychains.sh
	
	/usr/bin/curl -s --show-error $hcstorage/plists/edu.uh.honors.resetkeychains.plist -o "/Library/LaunchDaemons/edu.uh.honors.resetkeychains.plist"
	/bin/chmod 644 /Library/LaunchDaemons/edu.uh.honors.resetkeychains.plist
}

function restrictActiveDirectoryLogins {
	echo "Restricting Active Directory logins..."
	/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts
	/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts Password "*"
	/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts RealName "Login Window's custom net accounts"
	/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts PrimaryGroupID 206
	
	/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Admins -t group com.apple.loginwindow.netaccounts
	/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Authenticated\ Users -t group com.apple.loginwindow.netaccounts
	
	if [ "$1" == "student" ]
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
}

function disableSystemSleep {
	echo "Disabling system sleep..."
	/usr/bin/pmset sleep 0
}

function disableSaveWindowState {
	echo "Disable the save window state at logout..."
	/usr/bin/defaults write com.apple.loginwindow 'TALLogoutSavesState' -bool false
}

function disableAutomaticSoftwareUpdates {
	echo "Disabling Software Update Automatic Checks"
	softwareupdate --schedule off
}

function enableGuestAccount {
	defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool YES
}

function setAutomaticGuestLogin {
	echo "Setting guest to automatic login..."
	/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser guest
}

function enableUsernameAndPasswordFields {
	echo "Enabling username and password fields..."
	/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool TRUE
}

function disableGatekeeper {
	echo "Disabling Gatekeeper..."
	spctl --master-disable
}

function bootstrapMunki {
	echo "Setting munki to bootstrap mode..."
	touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
}


echo "Running firstboot script..."
turnOffAirport
turnOnSSH
turnOnRemoteDesktop
getManagedInstallsPlist $1
enableGuestAccount

#Enable persistent PaperCut on lab computers
if [ "$1" == "lab" ]
then
	getPaperCutLaunchAgent
fi

#Automatic guest login on classroom and podium computers
if [ "$1" == "presentation" ]
then
	setAutomaticGuestLogin
fi

#If computer is shared, we want keychains to reset, and to not lock the screen
if [ "$2" == "shared" ]
then
	getScreenLockLaunchAgent
	getKeychainResetLaunchDaemon
fi

#If students are logging in, this can't be an employee computer. Therefore, if not a student, run all other actions.
if [ "$3" == "student" ]
then
	restrictActiveDirectoryLogins student
else
	restrictActiveDirectoryLogins nostudent
fi

if [ "$4" = "backup" ]
then
	getBackupLaunchDaemon
fi

#Run actions common to all systems
getOfficeSetupLaunchAgent
disableSystemSleep
disableSaveWindowState
disableAutomaticSoftwareUpdates
disableGatekeeper
enableUsernameAndPasswordFields
bootstrapMunki

echo "Done."

sleep 15

exit 0
