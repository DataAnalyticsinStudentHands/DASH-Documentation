### Introduction
Since our servers are virtual machines we use [TriLead](https://www.trilead.com/download/) to create full backups. These backups are stored on the "VM Backups" share on the Synology NAS. The TriLead software is installed on hc-management und connects to ESX host. Those backups are not scheduled and created manually, usually around major updates on the servers.

  
### Which servers get backed up?

| Server                        |  
|-------------------------------|
|hc-management |
|hc-deployment |
|hc-papercut   |
