#Computer Backups 

##Introduction
The Honors College's backups are handled via a LaunchAgent that runs every day at 11:45 PM. It is installed when computers are reimaged using the `merged_restore.sh` script. It uses a combination of rsync and and symlinks to create a full backup every weekend, and incremental backups every weekday. These backups are stored on the Backups share on the Synology NAS.

###Security
In order to guarantee security of each user's files (from other users, not administrators), we create a folder on the NAS for each user's computer, and set the permissions on the folder to be only accessible by the HC Admins group and the user whose computer is being backed up.

In addition, the Backups share is not mounted by default for users. It is mounted at the time of backup and unmounted as soon as the backup is finished.

###Why not Time Machine?
Many Apple users extol the virtues of Time Machine as a backups solution. They're not wrong. Time Machine is a great backup solution for consumers. However, it does not scale well to our environment or offer the security requested by users. In additon, it locks us into using Macs to read the backed up data because Time Machine is Apple-only.

###Why not an actual enterprise-level backup solution?
Money. It's cheaper to send a student with a flash drive to each computer, than to spend the money on a subscription-based system such as CrashPlan, or to invest time and hardware into a system such as Symantec's BackupExec. The university does offer IBM Tivoli Backups, but those are unwieldy and have a restore time in days, rather than minutes. 

###Which computers get backed up?
We only back up faculty and staff computers. The lab, consulting, and classroom computers are not backed up and we offer no guarantee to retain the data on those computers. In addition, student services, and recruitment staff should be doing all their work on their respective UHSA1 shares, and saving nothing to the local computer. 

##Creating Backup Folders


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

