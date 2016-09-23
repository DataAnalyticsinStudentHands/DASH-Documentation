##Backup How To-Dos

We have created a UNIX bash script that will run automatically via LaunchDeamons on machines where it gets installed. The standard installation happens when the "backup" option is selected with the [merged_restore](https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000015668-merged-restore-script) script (please see [instructions](https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000015668-merged-restore-script)).

### Checking Backups
Currenty, this is a manual task. Log on to web interface for the [Synology NAS hc-storage](http://hc-stoarge.cougaret.uh.edu:5000). Open the "File Station" view and got to "Backups" folder. Check each hostname/user/cougarnetID for latest backup times. Should be within the last few days if changes were made. Note any discrepancies.

### Fixing Issues
If the backup is old (more than 2 weeks), follow these steps:

Find the IP address of the host in Remote Desktop (hc-it)
1. SSH into the remote host
`ssh hcadmin@172.27.XXX.XXX`
(password is the standard hcadmin password)
2. Check if the backup script exists
`sudo ls -la /usr/local/bin/backup.sh`
3. If the backup script exists, run it (if not, make a ticket)
`sudo sh /usr/local/bin/backup.sh`
4. Verify that the backups are being created on HC-storage by running the find command listed above
5. TBD: (check launch daemons)
/Library/LaunchDaemons/edu.uh.honors.backup.plist
6. TBD: (check log files?)



















### The Backup Script explained
This is old and needs to updated ...

```backup.sh``` v2015.06.28

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
