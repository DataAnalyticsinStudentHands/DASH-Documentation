#!/bin/bash

### Some Notes
### This script is used to distribute various settings and LaunchAgents and LaunchDaemons to
### continually re-set those settings. It is also used to name, AD Bind, and distribute
### HP Printer Drivers to newly imaged computers.
###
### It begins by validating the seven inputs required, then instantiates functions mostly
### in no particular order, then runs those functions at the end, sometimes for only
### particular computer types.
###
### Sometimes it becomes necessary to use some content from merged_restore.sh to fix an
### issue on some misbehaving mac (or to run the whole thing) as settings can become
### corrupted or whathaveyou. Most if not all of the content has been written such that
### it can be easily copied and pasted into Remote Desktop or the command line.
###
### The contents of the getThisParticularSetting functions are such that they download
### a shell script and plist pair. When creating new such functions it is easiest to
### copy an existing one and change the names of the files referenced, since they are
### all pretty much of the same form. This is why they take the name of the script
### and plist as variables, so that they can be easily copied and edited. If we did
### not use variables in these cases then it would be easier to forget to change all
### instances and you could end up downloading one file and naming it as another locally.
### (this mistake has occurred in the past)

# Check parameters in case of typos on a manual run
declare -a param1=("admincomputer" "advisorcomputer" "bonnerlabcomputer" "presentation" "consultingcomputer" "dashlabcomputer" "facultystaffcomputer" "labcomputer")
declare -a param2=("shared" "notshared")
declare -a param3=("student" "nostudent")
declare -a param4=("backup" "nobackup")
# param5 is either a name to give the machine or "nonamechange" (or "no")
declare -a param6=("adbind" "noadbind" "no")
declare -a param7=("packages" "nopackages" "no")

if [[ ! " ${param1[@]} " =~ " $1 " ]]
then
  if [[ " ${param2[@]} " =~ " $1 " ]]
  then
    echo "*****MERGED RESTORE FAILURE*****
Error: No manifest argument
Quitting merged restore run..."
    exit 1
  else
    echo "*****MERGED RESTORE FAILURE*****
Error: Invalid manifest: $1
Quitting merged restore run..."
    exit 1
  fi
fi

if [[ ! " ${param2[@]} " =~ " $2 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid shared status: $2
Quitting merged restore run..."
  exit 1
fi

if [[ ! " ${param3[@]} " =~ " $3 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid AD login restriction: $3
Quitting merged restore run..."
  exit 1
fi

if [[ ! " ${param4[@]} " =~ " $4 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid backup status: $4
Quitting merged restore run..."
  exit 1
fi

var5=$(echo "$5" | tr '[:upper:]' '[:lower:]')
if [[ ! ( "$var5" == "nonamechange" || "$var5" == "no" || "$var5" == *"hc-"* ) ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Computer name failure!
Must use \"hc-name\" convention.
Use \"nonamechange\" or \"no\" to leave name unchanged
Quitting merged restore run..."
  exit 1
fi

if [[ ! " ${param6[@]} " =~ " $6 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid AD Bind status: $6
Quitting merged restore run..."
  exit 1
fi

if [[ ! " ${param7[@]} " =~ " $7 " ]]
then
  echo "*****MERGED RESTORE FAILURE*****
Error: Invalid argmuent for whether packages should be installed: $7
Quitting merged restore run..."
  exit 1
fi

# Whether the machine needs to be rebooted at the end. Changed by certain parameters and functions.
reboot_required=false

# Turn off AirPort. This makes sure that all network communications run through the Ethernet port. Wi-Fi interferes with Cougarnet access. It also required an administrator password to turn Wi-Fi on.
function turnOffAirport {
  /usr/sbin/networksetup -detectnewhardware
  echo "Turning off airport..."
  /usr/sbin/networksetup -setairportpower en1 off
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en1 prefs RequireAdminPowerToggle=YES
  /usr/sbin/systemsetup -setwakeonnetworkaccess on
}

# Turn on SSH. This allows remote access through the command line.
function turnOnSSH {
  echo "Turning on ssh..."
  /usr/sbin/systemsetup -setremotelogin on
}

# Turn on Remote Desktop. This allows Remote Access through Apple Remote Desktop.
function turnOnRemoteDesktop {
  echo "Turning on RemoteManagement..."
  /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers -configure -users hcadmin -access -on
  /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users hcadmin -privs -all -restart -agent
}

# Get ManagedInstalls.plist. This uses the first parameter to get the correct list of software to for the computer (munki will process the lists later).
function getManagedInstallsPlist {
  echo "Getting ManagedInstalls.plist..."
  if [ "$1" == "facultystaffcomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/facultystaff_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "presentation" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "consultingcomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "advisorcomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/advisor_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "labcomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/lab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "dashlabcomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/dashlab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "bonnerlabcomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/bonnerlab_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  elif [ "$1" == "admincomputer" ]
  then
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/managedinstalls/admin_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"
  else
    echo "***********MERGED RESTORE FAILURE***********
********************************************
Error: Can't retrieve ManagedInstalls.plist.
    Check reachability of hc-storage/web
********************************************"
  fi

  if [ ! -d "/usr/local/honors" ]
  then
    mkdir /usr/local/honors
    echo "Creating /usr/local/honors..."
  else
    echo "/usr/local/honors exists"
  fi
echo "Changing permissions for /usr/local/honors..."
chmod 755 /usr/local/honors
chown root:wheel /usr/local/honors
}

# Install PaperCut LaunchAgent. This installs a script that keeps PaperCut constantly open.
function getPaperCutLaunchAgent {
  echo "Getting PaperCut login script..."
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/edu.uh.honors.papercut.plist -o "/Library/LaunchAgents/edu.uh.honors.papercut.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.papercut.plist
}

# Uninstall PaperCut LaunchAgent. This uninstalls the script that keeps PaperCut constantly open, if it exists
function uninstallPaperCutLaunchAgent {
  echo "Uninstalling Papercut login script..."
  rm -f /Library/LaunchAgents/edu.uh.honors.papercut.plist
}

# Install Lab Computer Script LaunchAgent. This installs a script that sets the wallpaper, default printer, etc. for lab computers.
function getLabComputerScriptLaunchAgent {
  echo "Installing Lab Computer Script..."
  plistname="edu.uh.honors.labcomputers.plist"
  scriptname="labComputerScript.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname

  # Download Honors Lab Desktop Wallpaper
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/honorslabdocuments/honorslabwallpaper.jpg -o "/usr/local/honors/honorslabwallpaper.jpg"
  /bin/chmod 755 /usr/local/honors/honorslabwallpaper.jpg
}

# Uninstall Lab Computer Script LaunchAgent. This uninstalls the lab computer script, if it exists
function uninstallLabComputerScriptLaunchAgent {
  echo "Uninstalling Lab Computer script..."
  rm -f /usr/local/honors/labComputerScript.sh
  rm -f /Library/LaunchAgents/edu.uh.honors.labcomputers.plist
  rm -f /usr/local/honors/honorslabwallpaper.jpg
}

# Install Classroom Computer Script LaunchAgent. This installs a script that sets the wallpaper, etc. for classroom computers.
function getClassroomComputerScriptLaunchAgent {
  echo "Installing Classroom Computer Script..."
  plistname="edu.uh.honors.classroomcomputers.plist"
  scriptname="classroomComputerScript.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname

  # Download Honors Classroom Wallpaper
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/classroomdocuments/classroomwallpaper.jpg -o "/usr/local/honors/classroomwallpaper.jpg"
  /bin/chmod 755 /usr/local/honors/classroomwallpaper.jpg
}

# Uninstall Classroom Computer Script LaunchAgent. This uninstalls the classroom computer script, if it exists
function uninstallClassroomComputerScriptLaunchAgent {
  echo "Uninstalling Classroom Computer script..."
  rm -f /usr/local/honors/classroomComputerScript.sh
  rm -f /Library/LaunchAgents/edu.uh.honors.classroomcomputers.plist
  rm -f /usr/local/honors/classroomwallpaper.jpg
}

# Install Script to auto-delete Outlook attachments on SSO Computers
function getSSOComputerScriptLaunchAgent {
  echo "Installing SSO Computer Outlook Script..."
  plistname="edu.uh.honors.ssocomputers.plist"
  scriptname="cleanUpSSOOutlook.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Uninstall SSO Outlook Attachment deleting script, if it exists
function uninstallSSOComputerScriptLaunchAgent {
  echo "Uninstalling SSO Computer Outlook Script..."
  rm -rf /Library/LaunchAgents/edu.uh.honors.ssocomputers.plist
  rm -rf /usr/local/honors/cleanUpSSOOutlook.sh
}

# Install automatic logout script. Logs user out 20 minutes of inactivity
function getAutoLogoutLaunchAgent {
  echo "Installing Automatic Logout Script..."
  plistname="edu.uh.honors.autologout.plist"
  scriptname="autoLogout.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname

  # Set display sleep to 16 minutes, see autoLogout.sh for why
  /usr/bin/pmset -a displaysleep 16
}

# Uninstall automatic logout script, if it exists
function uninstallAutoLogoutLaunchAgent {
  echo "Uninstalling Automatic Logout script..."
  rm -f /usr/local/honors/autoLogout.sh
  rm -f /Library/LaunchAgents/edu.uh.honors.autologout.plist
}

# Setting guest account to automatically login after the computer started.
function setAutomaticGuestLogin {
  echo "Setting guest to automatic login..."
  /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow.plist autoLoginUser guest
}

# Disable automatic login of guest account, in case it is enabled
function disableAutomaticGuestLogin {
  echo "Disabling automatic guest login..."
  /usr/bin/defaults delete /Library/Preferences/com.apple.loginwindow.plist autoLoginUser
}

# Install guest autologin LaunchDaemon. This installs a script that resets the autologin of guest.
function getGuestAutoLoginDaemon {
  echo "Getting Auto guest Login Script..."
  plistname="edu.uh.honors.guestautologin.plist"
  scriptname="guest_autologin.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchDaemons/$plistname"
  /bin/chmod 644 /Library/LaunchDaemons/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Uninstall guest autologin LaunchDaemon. This uninstalls the script that resets the autologin of guest.
function uninstallGuestAutoLoginDaemon {
  echo "Uninstalling Auto guest Login Script..."
  rm -f /usr/local/honors/guest_autologin.sh
  rm -f /Library/LaunchDaemons/edu.uh.honors.guestautologin.plist
}

# Install Keychain Reset LaunchDaemon. This installs a script that resets the keychain nightly (useful on shared computers).
function getKeychainResetLaunchDaemon {
  echo "Getting Keychain Fix Script..."
  plistname="edu.uh.honors.resetkeychains.plist"
  scriptname="reset_keychains.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchDaemons/$plistname"
  /bin/chmod 644 /Library/LaunchDaemons/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Uninstall Keychain Reset LaunchDaemon. This uninstalls the script that resets the keychain nightly.
function uninstallKeychainResetLaunchDaemon {
  echo "Uninstalling Keychain Fix Script..."
  rm -f /usr/local/honors/reset_keychains.sh
  rm -f /Library/LaunchDaemons/edu.uh.honors.resetkeychains.plist
}

# Restrict the AD logins to certain Groups (we are using HC Admins, HC Autheticated Users & HC Students)
function restrictActiveDirectoryLogins {
  echo "Restricting Active Directory logins..."
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts Password "*"
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts RealName "Login Window's custom net accounts"
  /usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts PrimaryGroupID 206

  /usr/sbin/dseditgroup -o edit -n /Local/Default -a HC-Admins -t group com.apple.loginwindow.netaccounts
  /usr/sbin/dseditgroup -o edit -n /Local/Default -a HC-Authenticated-Users -t group com.apple.loginwindow.netaccounts

  if [ "$1" == "student" ]
  then
    echo "Adding students to allowed user list..."
    /usr/sbin/dseditgroup -o edit -n /Local/Default -a HC-Students -t group com.apple.loginwindow.netaccounts
  fi

  if [ "$1" == "nostudent" ]
  then
    echo "Ensuring students are not on allowed user list..."
    /usr/sbin/dseditgroup -o edit -n /Local/Default -d HC-Students -t group com.apple.loginwindow.netaccounts
  fi

  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow
  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow Password "*"
  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow PrimaryGroupID 223
  /usr/bin/dscl . -create /Groups/com.apple.access_loginwindow RealName "Login Window ACL"

  /usr/sbin/dseditgroup -o edit -n /Local/Default -a localaccounts -t group com.apple.access_loginwindow
  /usr/sbin/dseditgroup -o edit -n /Local/Default -a com.apple.loginwindow.netaccounts -t group com.apple.access_loginwindow
}

# Install Backup LaunchDaemon. This installs the backup script and schedules regular backups.
function getBackupLaunchDaemon {
  echo "Getting Backup Script..."
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/backup.sh -o "/usr/local/honors/backup.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/backup.sh

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/edu.uh.honors.backup.plist -o "/Library/LaunchDaemons/edu.uh.honors.backup.plist"
  /bin/chmod 644 /Library/LaunchDaemons/edu.uh.honors.backup.plist
}

# Uninstall Backup LaunchDaemon. This deletes the backup script.
function uninstallBackupLaunchDaemon {
  rm -f /usr/local/honors/backup.sh
  rm -f /Library/LaunchDaemons/edu.uh.honors.backup.plist
}

# Install Office Setup LaunchAgent. This installs a script that suppresses the Office Setup screen when a user logs into a computer.
function getOfficeSetupLaunchAgent {
  echo "Getting Office setup script..."
  plistname="edu.uh.honors.curlofficeprefs.plist"
  scriptname="curl_office_plists.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Reset USB IO such as clicker receivers (excludes storage devices)
function getResetIOusb {
  echo "Getting reset usb i/o script...."
  plistname="edu.uh.honors.resetiousb.plist"
  scriptname="resetioUSB.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname

  # Secondary plist also runs the script on login
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/edu.uh.honors.resetiousb2.plist -o "/Library/LaunchAgents/edu.uh.honors.resetiousb2.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.resetiousb2.plist

  # This script-plist pair places a file on every user's desktop caled Fix_Clicker.command
  # which they can double click to run the resetioUSB.sh script whenever needed
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/edu.uh.honors.fixclickercommand.plist -o "/Library/LaunchAgents/edu.uh.honors.fixclickercommand.plist"
  /bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.fixclickercommand.plist

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/fix_clicker_command.sh -o "/usr/local/honors/fix_clicker_command.sh" --create-dirs
  /bin/chmod +x /usr/local/honors/fix_clicker_command.sh
}

# Delete reset USB stick resetter
function uninstallResetIOusb {
  echo "Uninstalling reset usb i/o script...."
  rm -rf /usr/local/honors/resetioUSB.sh
  rm -rf /Library/LaunchAgents/edu.uh.honors.resetiousb.plist
  rm -rf /Library/LaunchAgents/edu.uh.honors.resetiousb2.plist
  rm -rf /usr/local/honors/fix_clicker_command.sh
  rm -rf /Library/LaunchAgents/edu.uh.honors.fixclickercommand.plist
}

# Disable System Sleep
function disableSystemSleep {
  echo "Disabling system sleep..."
  /usr/bin/pmset sleep 0
}

# Disable save Window state at logout
function disableSaveWindowState {
  echo "Disable the save window state at logout..."
  /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow.plist TALLogoutSavesState -bool false
}

# Disable Automatic Software Updates. We are using Munki to handle this.
function disableAutomaticSoftwareUpdates {
  echo "Disabling Software Update Automatic Checks"
  /usr/sbin/softwareupdate --schedule off
}

# Disable Gatekeeper. Gatekeeper helps to protect your Mac from malware and misbehaving apps downloaded from the Internet. But disable it in order for our scripts to run.
function disableGatekeeper {
  echo "Disabling Gatekeeper..."
  /usr/sbin/spctl --master-disable
  echo "Getting Gatekeeper persistent disable Script..."
  plistname="edu.uh.honors.disablegatekeeper.plist"
  scriptname="disable_gatekeeper.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchDaemons/$plistname"
  /bin/chmod 644 /Library/LaunchDaemons/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Show username & password fields in Login Window instead of circles.
function enableUsernameAndPasswordFields {
  echo "Enabling username and password fields..."
  /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow.plist SHOWFULLNAME -bool TRUE
}

# Munki in Bootstrap mode. Munki will run on reboot.
function bootstrapMunki {
  echo "Setting munki to bootstrap mode..."
  touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup
}

# Add "Important CougarNet Information" dialog box to the lock screen, if not a presentation or consulting computer.
function policyBanner {
  if [ ! "$1" == "presentation" ] && [ ! "$1" == "consultingcomputer" ]
  then
    echo "Downloading policyBanner..."
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/PolicyBanner.rtf -o "/Library/Security/PolicyBanner.rtf"
  else
    /bin/rm -f /Library/Security/PolicyBanner.rtf
  fi
}

# Suppress the setup of Siri and a couple other things for first time logins
function siriSuppression {
  echo "Downloading Siri suppression script..."
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/sierra_suppressions.sh -o "/usr/local/honors/sierra_suppressions.sh" --create-dirs

  echo "Running Siri suppression script..."
  /bin/bash /usr/local/honors/sierra_suppressions.sh

  echo "Removing Siri suppression script..."
  /bin/rm /usr/local/honors/sierra_suppressions.sh
}

# Set time and date server on most computers. Downloads script and plist to persistently reset timeserver
function setTimeAndDate {
  echo "Getting Time Server script..."
  plistname="edu.uh.honors.time.plist"
  scriptname="timeserver.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchAgents/$plistname"
  /bin/chmod 644 /Library/LaunchAgents/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Install hc-storage cert so that munki trusts it as https without a 3rd party signed cert
function getStorageCert {
  echo "Getting Curly Self-Signed Root Certificate..."
  /usr/bin/scp hcadmin@hc-storage.cougarnet.uh.edu:/volume1/web/cert.pem /usr/local/cert.pem
  /usr/bin/security add-trusted-cert -d -r trustAsRoot -k /Library/Keychains/system.keychain /usr/local/honors/cert.pem
}

# Change machine name if prompted to change
function setMachineName {
  if [ ! "$1" == "nonamechange" ] && [ ! "$1" == "no" ]
  then
    echo "Changing machine name to $1. This will require restart..."
    /usr/sbin/scutil --set HostName "$1"
    /usr/sbin/scutil --set LocalHostName "$1"
    /usr/sbin/scutil --set ComputerName "$1"
    /usr/bin/dscacheutil -flushcache
    reboot_required=true
  else
    echo "Leaving machine name unchanged."
  fi
}

# Bind to AD
function bindToAD {
	if [ "$1" == "adbind" ]
	then
	  read -p "Enter AD Admin username: " ADusername
	  if [ "$2" == "facultystaffcomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-Faculty,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "presentation" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-Classrooms,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "consultingcomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-Consulting,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "advisorcomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-Faculty,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "labcomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-HonorsLab,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "dashlabcomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-Faculty,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "bonnerlabcomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-BonnerLab,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  elif [ "$2" == "admincomputer" ]
	  then
	    dsconfigad -a "$3" -u "$ADusername" -ou "OU=HC-Servers,OU=HC,DC=cougarnet,DC=uh,DC=edu" -domain cougarnet.uh.edu -localhome enable -useuncpath enable -alldomains enable
	  fi
	fi
}

# Install packages. Also grab printer drivers
function installPackages {
  if [ "$1" == "packages" ]
  then
    # HP printer driver package is installed as part of the imaging process because it is quite large
    echo "Downloading HP printer driver package..."
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/packages/HewlettPackardPrinterDrivers.pkg -o "/usr/local/honors/HewlettPackardPrinterDrivers.pkg"
    echo "Installing HP printer drivers..."
    /usr/sbin/installer -pkg /usr/local/honors/HewlettPackardPrinterDrivers.pkg -target /
    echo "Removing HP printer driver installer..."
    /bin/rm /usr/local/honors/HewlettPackardPrinterDrivers.pkg

    echo "Downloading other HP drivers..."
    /usr/bin/curl http://hc-storage.cougarnet.uh.edu/printer_drivers/HP\ LaserJet\ 600\ M601\ M602\ M603.gz -o "/Library/Printers/PPDs/Contents/Resources/HP LaserJet 600 M601 M602 M603.gz"
    /usr/bin/curl http://hc-storage.cougarnet.uh.edu/printer_drivers/HP\ LaserJet\ M607\ M608\ M609.gz -o "/Library/Printers/PPDs/Contents/Resources/HP LaserJet M607 M608 M609.gz"
    /usr/bin/curl http://hc-storage.cougarnet.uh.edu/printer_drivers/HP\ Color\ LaserJet\ Pro\ M452.gz -o "/Library/Printers/PPDs/Contents/Resources/HP Color LaserJet Pro M452.gz"

    echo "Downloading munkitools..."
    /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/packages/munkitools-3.1.1.3447.pkg -o "/usr/local/honors/munkitools-3.1.1.3447.pkg"
    echo "Restore run is complete. Installing munkitools. This will restart the computer..."
    /usr/sbin/installer -pkg /usr/local/honors/munkitools-3.1.1.3447.pkg -target /
    echo "Removing munkitools installer package..."
    /bin/rm /usr/local/honors/munkitools-3.1.1.3447.pkg

    reboot_required=true
  fi
}

# Installs update script for dsm.sys, sets it to check for updates every night
function installDSMUpdater {
  #checks if client is on TSM install list
  install=false
  while IFS='' read -r line || [[ -n "$line" ]]; do #reads line by line
    IFS=',' read -ra LN <<< "$line" #splits lines by comma
    hostname=$(hostname -s)
    if [[ ${LN[0]} == $hostname ]]; then #places first field into names
      install=true
    fi
  done < <(curl -s http://hc-storage.cougarnet.uh.edu/TSM/TSM-NodeNames-Passwords.csv) #tells bash to read from TSM password file

  if [ install == false ]; then return; fi

  echo "Getting dsmupdate script..."
  plistname="edu.uh.honors.dsmupdate.plist"
  scriptname="dsm-sys_updater.sh"
  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/plists/$plistname -o "/Library/LaunchDaemons/$plistname"
  /bin/chmod 644 /Library/LaunchDaemons/$plistname

  /usr/bin/curl -s --show-error http://hc-storage.cougarnet.uh.edu/scripts/$scriptname -o "/usr/local/honors/$scriptname" --create-dirs
  /bin/chmod +x /usr/local/honors/$scriptname
}

# Run functions common to all machines
echo "Running merged_restore.sh script..."
turnOffAirport
turnOnSSH
turnOnRemoteDesktop
setTimeAndDate
getOfficeSetupLaunchAgent
disableSystemSleep
disableSaveWindowState
disableAutomaticSoftwareUpdates
disableGatekeeper
enableUsernameAndPasswordFields $1
siriSuppression
policyBanner $1
installDSMUpdater
getStorageCert

# Lab Computer settings
if [ "$1" == "labcomputer" ]
then
  getPaperCutLaunchAgent
  getLabComputerScriptLaunchAgent
  getAutoLogoutLaunchAgent
else
  uninstallPaperCutLaunchAgent
  uninstallLabComputerScriptLaunchAgent
  uninstallAutoLogoutLaunchAgent
fi

# Classroom Computer settings
if [ "$1" == "presentation" ]
then
  getClassroomComputerScriptLaunchAgent
else
  uninstallClassroomComputerScriptLaunchAgent
fi

# Clicker reset script and automatic guest login on classroom and podium computers
if [ "$1" == "presentation" ] || [ "$1" == "consultingcomputer" ]
then
  getResetIOusb
  setAutomaticGuestLogin
  getGuestAutoLoginDaemon
else
  uninstallResetIOusb
  disableAutomaticGuestLogin
  uninstallGuestAutoLoginDaemon
fi

# Install SSO Script on SSO Computers
name=$(hostname)
name=$(echo "$name" | tr '[:upper:]' '[:lower:]')
if [[ "$name" == *"sso"* ]] || [[ "$5" == *"sso"* ]]
then
  getSSOComputerScriptLaunchAgent
else
  uninstallSSOComputerScriptLaunchAgent
fi

# If computer is shared, we want keychains to reset, but we don't want it on SSO and Recruitment computers
if [ "$2" == "shared" ] && [ ! "$1" == "advisorcomputer" ]
then
  getKeychainResetLaunchDaemon
else
  uninstallKeychainResetLaunchDaemon
fi

# If backups are needed, install the backup launch daemon.
if [ "$4" = "backup" ]
then
  getBackupLaunchDaemon
else
  uninstallBackupLaunchDaemon
fi

# Big stuff near the end
setMachineName $5
bindToAD $6 $1 $5
restrictActiveDirectoryLogins $3
getManagedInstallsPlist $1
bootstrapMunki
installPackages $7

sleep 20

# Reboot machine if required
if [ $reboot_required == true ]
then
  echo "Done. Restarting computer..."
  sleep 5
  shutdown -r now
else
  echo "Done."
fi

exit 0
