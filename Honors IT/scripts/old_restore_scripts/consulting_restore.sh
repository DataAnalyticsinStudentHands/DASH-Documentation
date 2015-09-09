#!/bin/sh

# start here
kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
systemsetup="/usr/sbin/systemsetup"
networksetup="/usr/sbin/networksetup"
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

echo "Getting ManagedInstalls.plist..."
/usr/bin/curl http://hc-storage.cougarnet.uh.edu/munki/consulting_ManagedInstalls.plist -o "/Library/Preferences/ManagedInstalls.plist"

echo "Getting Office setup script..."
/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/curl_office_plists.sh -o "/usr/bin/curl_office_plists.sh"
/bin/chmod +x /usr/bin/curl_office_plists.sh

echo "Getting Office preferences login script..."
/usr/bin/curl http://hc-storage.cougarnet.uh.edu/scripts/edu.uh.honors.curlofficeprefs.plist -o "/Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist"
/bin/chmod 644 /Library/LaunchAgents/edu.uh.honors.curlofficeprefs.plist

echo "Disabling system sleep..."
/usr/bin/pmset sleep 0

echo "Setting munki to bootstrap mode..."
touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup

echo "Restricting Active Directory logins..."
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts Password "*"
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts RealName "Login Window's custom net accounts"
/usr/bin/dscl . -create /Groups/com.apple.loginwindow.netaccounts PrimaryGroupID 206

echo "Created LoginWindow custom net accounts..."

/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Admins -t group com.apple.loginwindow.netaccounts
/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Authenticated\ Users -t group com.apple.loginwindow.netaccounts
/usr/sbin/dseditgroup -o edit -n /Local/Default -a HC\ Students -t group com.apple.loginwindow.netaccounts

echo "Added Groups... "

/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow
/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow Password "*"
/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow PrimaryGroupID 223
/usr/bin/dscl . -create /Groups/com.apple.access_loginwindow RealName "Login Window ACL"

echo "Added login window ACL"

/usr/sbin/dseditgroup -o edit -n /Local/Default -a localaccounts -t group com.apple.access_loginwindow
/usr/sbin/dseditgroup -o edit -n /Local/Default -a com.apple.loginwindow.netaccounts -t group com.apple.access_loginwindow

echo "Connected ACL and Groups"

echo "Finished applying firstboot settings."
 
echo "Sleeping for 60 seconds..."
sleep 60

echo "Done."
exit 0
