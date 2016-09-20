# MAC Computer Backups

## Introduction
The Honors College's backups are handled via a LaunchAgent that runs every day at 11:45 PM. It is installed when computers are imaged using the `merged_restore.sh` script. It uses a combination of rsync and and symlinks to create incremental backups every day. These backups are stored on the "Backups" share on the Synology NAS.

### Which computers get backed up?
We only back up the Users folder from faculty and staff Mac computers. The lab, consulting, and classroom computers are not backed up and we offer no guarantee to retain the data on those computers. Student services, and recruitment staff should be doing all their work on their respective UHSA1 shares, and saving nothing to the local computer.

We do not backup the full computer. We only backup certain data inside the Users folder (not backed up: Downloads, Trash and Cache). This strategy will make it easier to restore lost data since the backup is not convoluted.

| Users                         | Location    | Computer Name/Backup folder name |
|-------------------------------|-------------|-------------------------------------|
| kemayer                       | 206D        | hc-206d                             |
| jkgajan, cmbenz               | 204A        | hc-asmussen                         |
| jbbrown4                      | 204A        | hc-brown                            |
| cmbrunt2                      | CCW         | hc-brunt                            |
| rcremins                      | 206A        | hc-cremins                          |
| gtoti                         | DASH        | hc-dash5                            |
| dblamson                      | CCW         | hc-lamson                           |
| ehfletch                      | S17A        | hc-fletcher                         |
| FileMaker Server, hcadmin     | 212K        | hc-fmp                              |
| jrharvey                      | CCW         | hc-harvey                           |
| drainbow                      | 205D        | hc-drainbow                         |
| cleveaux                      | 212W        | hc-leveaux                          |
| plindner                      | DASH        | hc-lindner                          |
| lllyke                        | 212F        | hc-lyke                             |
| ipmorris                      | 204C        | hc-morrisson                        |
| kdmyrick                      | Dean's Area | hc-myrick                           |
| dprice3                       | DASH        | hc-price                            |
| cerios                        | Dean's Area | hc-rios                             |
| resirrieh                     | 212H        | hc-sirrieh                          |
| hkvalier                      | Gardens-16  | hc-valier                           |
| kweber2                       | 211         | hc-weber                            |
| D. Mikics/J.Ferguson          | 206C        | hc-206C                             |
| Honors IT                     | 212K        | hc-IT                               |
| Honors IT                     | 212K        | hc-it-laptop                        |
| jlzecher                      | 206A        | hc-zecher                           |
| gmaya                         | CCW         | hc-maya                             |
| sakeen                        | Bonner Base | hc-keen                             |
| jahennes                      | SSO         | hc-hennessy                         |
| bmonroe                       | Dean's Area | Dean Monroe's iMac                  |
|  awleland                      | Bonner Base | hc-leland                           |


No backup, should be added asap!

| Users                         | Location    | Computer Name/Backup folder name |
|-------------------------------|-------------|-------------------------------------|
| T. Estess/R. Zaretsky         | 203B        |                                     |

### Security
In order to guarantee security of each user's files (from other users, not administrators), we have a folder on the NAS for each user's computer, and set the permissions on the folder to be only accessible by the HC Admins group and hcbackupuser (account used for the backup).

In addition, the Backups share is not mounted by default for users. It is mounted at the time of backup and unmounted as soon as the backup is finished.

### Why not Time Machine?
Many Apple users extol the virtues of Time Machine as a backups solution. They're not wrong. Time Machine is a great backup solution for consumers. However, it does not scale well to our environment or offer the security requested by users. In addition, it locks us into using Macs to read the backed up data because Time Machine is Apple-only.

### Issues with current backups: To be updated regularly!

Please document any problems that appear when checking backups. This includes user accounts that should be backing up but are not.  

| Users                         | Location    | Computer Name/Backup folder name | Not Backed Up Since |
|-------------------------------|-------------|-------------------------------------|----------------------|
| ipmorris                      | 204C        | hc-morrisson                             | 8/8/16                   |
| gmaya                         | CCW         | hc-maya                             | 9/8/16                   |
| jlzecher                      | 206A        | hc-zecher                             | 8/8/16                   |
| FleMaker Server               | 212K        | hc-fmp                             | 6/24/15                  |
| hcadmin                       | 212K        | hc-fmp                             | 7/26/16                  |
| resirrieh                     | 212H        | hc-sirrieh                             | 8/9/16                   |
| lllyke                        | 212F        | hc-lyke                             | 8/10/16                  |
| gtoti                         | DASH        | hc-dash5                             | 8/8/16                   |
| cleveaux                      | 212W        | hc-leveaux                             | 8/8/16                   |
| cmbenz                        | 204A        | hc-asmussen                             | 12/10/15                 |
