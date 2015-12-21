Shared Folders

The Honors College infrastructure operates with two shared network spaces:

## 1. HC Share

This is a service offered through UH IT using a Windows Shared Folder that is mounted via Samba.

The mount point is \\uhsa1\HCShare

The HC Share is automatically mounted on staff, advisor, faculty and student service computers.

To test connections, use Finder -> Command+K and use the following address:

`smb://uhsa1/HCShare`

Access to the shared folders inside the HCShare folder is managed via Active Directory. You need a Windows Computer running "Administrative Tools -> Active Directory Users & Computers" to configure permissions.

Here is a list of the folders inside HCShare:


The access to each of those folders is handled via group permissions. The group "HC Admins" + a administrator from UH IT shoudl have always full control for each of the folders.

| Folder Name    | Group Access   | Description |
|-----------------|--------------|---------------------------|
| Admissions     | ? | Admissions shared folder |

## 2. Honors Share

This is a network share that we provide via our own hardware (Syncology NAS).
