#! /bin/sh

# Set variables, including day of week, host name, backup path, and current user
dayofweek=$(date +%u)
host=`scutil --get LocalHostName`
backuppath="/Volumes/Backups/$host"
currentuser="$(whoami)"

# Determine and/or mount backup drive.
if mount | grep "/Volumes/Backups" > /dev/null;
then
	echo "Mounted."
else
	mkdir /Volumes/Backups
	echo "Running as hcautobackup..."
	/sbin/mount -t smbfs //hcautobackup:'5TYQGYzq~NIAxdI'@hc-storage.cougarnet.uh.edu/Backups /Volumes/Backups
fi

#Run backup, updating the files as needed.
echo "Running incremental backup..."
rsync -rltDPh  --exclude='*.Trash/*' --exclude='*Downloads/*' --exclude='*Caches/*' --exclude='*.dmg' --exclude='*Application Support/*' --exclude='.*' /Users $backuppath/
#in case of larry
if [ $host = "hc-fmp" ]
then
	echo "Backing up FileMaker..."
	rsync -rltDPh /Library/Filemaker\ Server $backuppath/Library
fi
umount /Volumes/Backups
