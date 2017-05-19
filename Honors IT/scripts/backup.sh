#! /bin/sh

# Set variables, including day of week, host name, backup path, and current user
dayofweek=$(date +%u)
host=`scutil --get LocalHostName`
backuppath="/Volumes/Backups/$host"
#excludes="/usr/local/etc/backup_excludes.conf"

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
rsync -rltP --devices  --exclude='*.Trash/*' --exclude='*Downloads/*' --exclude='*Caches/*' --exclude='*.dmg' --exclude='*Application Support/*' --exclude='.*' --exclude='*Dropbox/*' --exclude='*Google Drive/*' /Users $backuppath/
#rsync -rltDPhv  --exclude-from="$excludes" /Users $backuppath/

if [ $? -gt 0 ]; then
	echo "Backup failed."
else
	echo "Backup successful. Updating .backup..."
	touch ${backuppath}/.backup
    today=`date +%Y_%m_%d`
    now=`date '+%H:%M:%S'`
	printf "$today ${now}: Backup completed\n" >> ${backuppath}/.backup
fi

#in case of larry
if [ $host = "hc-fmp" ]
then
        echo "Backing up FileMaker..."
        rsync -rltDPh /Library/Filemaker\ Server $backuppath/Library
fi
umount /Volumes/Backups
