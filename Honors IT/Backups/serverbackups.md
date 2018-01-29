### Introduction
Since our servers are virtual machines we use [HP VM Explorer Free](http://www8.hp.com/us/en/software-solutions/vm-server-backup/index.html?compURI=tcm:245-2240017) to create full backups. These backups are stored on the "VMBackups" share on the Synology NAS (hc-storage). The VM Explorer software is installed on hc-management und connects to the ESX host. Those backups are not scheduled and created manually, usually around major updates on the servers.


### Which servers get backed up?

| Server       |  Last Backup |
|--------------|--------------|
|hc-management | 08-18-2016   |
|hc-deployment | 08-17-2016   |
|hc-papercut   | 08-22-2016   |
