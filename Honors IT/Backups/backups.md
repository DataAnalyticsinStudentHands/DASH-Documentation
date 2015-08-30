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
