#!/bin/sh

# To be run as the client on the client computer
# Therefore, the faculty member must have logged on to the computer

# arg1 is the name of the BACKUP FOLDER on hc-storage from which data is to be pulled
# This is because the hostname of the client will not always match the folder name

if [ "$1" == "" ]
then
	echo "Error: Missing backup folder name."
	exit 1
fi

username=$(id -un)

scp -i /Volumes/keys/id_rsa -r hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Desktop/* /Users/$username/Desktop/
scp -i /Volumes/keys/id_rsa -r hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Documents/* /Users/$username/Documents/
scp -i /Volumes/keys/id_rsa -r hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Pictures/* /Users/$username/Pictures/
scp -i /Volumes/keys/id_rsa -r hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Music/* /Users/$username/Music/
scp -i /Volumes/keys/id_rsa hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Library/Safari/Bookmarks.plist /Users/$username/Library/Safari/
scp -i /Volumes/keys/id_rsa hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Library/Fonts/* /Users/$username/Fonts/
scp -i /Volumes/keys/id_rsa hcadmin@hc-storage:/volume1/Backups/$1/Users/$username/Library/FontCollections/* /Users/$username/FontCollections/

/usr/sbin/diskutil umount force /Volumes/keys

exit 0
