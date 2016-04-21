##Creating Backup Folders

This is old and needs to updated ...
##```backup.sh``` v2015.06.28 - Backup Script

###Set interpreter

```#! /bin/sh```

###Set variables, including day of week, host name, backup path, and current user

```
dayofweek=$(date +%u)
host=`scutil --get LocalHostName`
backuppath="/Volumes/Backups/$host"
currentuser="$(whoami)"
```

###Determine and/or mount backup drive.

```
if mount | grep "hc-storage.cougarnet.uh.edu/Backups on /Volumes/Backups" > /dev/null;
then
	echo "Mounted."
else
	rm -rf /Volumes/Backups
	mkdir /Volumes/Backups
```
####If the computer is logged in using hcadmin, such as the FileMaker server, we have to use the generic backup user, rather than a Cougarnet login.
```
if [ $currentuser = "hcadmin" ]
	then
		echo "Running as hcbackup..."
		/sbin/mount -t smbfs //hcbackup:backup@hc-storage.cougarnet.uh.edu/Backups /Volumes/Backups
	else
		echo "Running as $currentuser..."
		/sbin/mount -t smbfs //$currentuser@hc-storage.cougarnet.uh.edu/Backups /Volumes/Backups
	fi
fi
```
###Check if it's the weekend. If it's the weekend, do a full backup. If it's a weekday, do an incremental backup.

We use the following rsync flags:

* r = recursive
* l = preserve symlinks
* t = preserve times
* D = preserve device and special files.
* P = show progress
* h = human-readable output
* --link-dest = create a hardlink to a file in this directory if a file being copied is the same. This is the secret sauce behind the incremental backups.

For the full backup, we add the following flag:

* u = update the files, this only copies files over if they're newer, conserving bandwidth.

At the end of each backup, we update the "current" symlink to point to the newest backup.

```
if [ $dayofweek -lt "6" ]
then
	echo "Running incremental backup..."
	rm -rf $backppath/daily.$dayofweek
	rsync -rltDPh --exclude=*/Library/* --exclude=*/.Trash/* --link-dest=$backuppath/current /Users $backuppath/daily.$dayofweek
	#in case of larry
	if [ $host = "hc-fmp" ]
	then
		echo "Backing up FileMaker..."
		rsync -rltDPh --link-dest=$backuppath/current/Library/ /Library/Filemaker\ Server $backuppath/daily.$dayofweek/Library
	fi
	rm -f $backuppath/current
	ln -s daily.$dayofweek $backuppath/current
else
	rsync -rltDPhu --exclude=*/Library/* --exclude=*/.Trash/* /Users $backuppath/weekly
	rm -f $backuppath/current
	ln -s weekly $backuppath/current
fi
```
###Finally, we unmount the backup share.
```
umount /Volumes/Backups
```
