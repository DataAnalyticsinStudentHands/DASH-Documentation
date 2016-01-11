# MAC Computer Backups

## Introduction
The Honors College's backups are handled via a LaunchAgent that runs every day at 11:45 PM. It is installed when computers are imaged using the `merged_restore.sh` script. It uses a combination of rsync and and symlinks to create a full backup every weekend, and incremental backups every weekday. These backups are stored on the "Backups" share on the Synology NAS.

### Which computers get backed up?
We only back up the Users folder from faculty and staff Mac computers. The lab, consulting, and classroom computers are not backed up and we offer no guarantee to retain the data on those computers. Student services, and recruitment staff should be doing all their work on their respective UHSA1 shares, and saving nothing to the local computer.

We do not backup the full computer. We only backup certain data inside the Users folder (not backed up: Downloads, Trash and Cache). This strategy will make it easier to restore lost data since the backup is not convoluted.

| Users                         | Location    | Computer Name |
|-------------------------------|-------------|-------------------------------------|
| kemayer                       | 206D        | hc-206d                             |
| jkgajan, cmbenz               | 204A        | hc-asmussen                         |
| plindner                      | DASH        | hc-lindner                          |
| jbbrown4                      | 204A        | hc-brown                            |
| ?                             | ?           | hc-brunt                            |
| gtoti                         | DASH        | hc-dash5                            |
| dblamson                      | ?           | hc-drainbow                         |
| ehfletch                      | ?           | hc-fletcher                         |

Need to check
| R. Cremins                    | 204D        | hc-cremins                          |

| C. Seitz                      | Dean's Area | HC-Seitz                            |
| E. Rios                       | Dean's Area | hc-rios                             |
| K. Myrick                     | Dean's Area | hc-myrick                                                               |
| D. Mikics/J. Ferguson         | 206C        |                                     |
| K. Weber                      | 211         | hc-weber                            |
| B. Monroe                     | 202A        |                                     |
| T. Estess/R. Zaretsky         | 203B        |                                     |
| C. LeVeaux-Haley              | 212W        | hc-leveaux                          |
| A. Hamilton                   | 212W        |                                     |
| R. Sirrieh                    | 212H        | HC-Sirrieh                          |
| L. Lyke                       | 212F        | hc-lyke                             |
| N. SakutriĘ                   | 212G        | hc-commstudent                      |

### Security
In order to guarantee security of each user's files (from other users, not administrators), we create a folder on the NAS for each user's computer, and set the permissions on the folder to be only accessible by the HC Admins group and the user whose computer is being backed up.

In addition, the Backups share is not mounted by default for users. It is mounted at the time of backup and unmounted as soon as the backup is finished.

### Why not Time Machine?
Many Apple users extol the virtues of Time Machine as a backups solution. They're not wrong. Time Machine is a great backup solution for consumers. However, it does not scale well to our environment or offer the security requested by users. In additon, it locks us into using Macs to read the backed up data because Time Machine is Apple-only.
