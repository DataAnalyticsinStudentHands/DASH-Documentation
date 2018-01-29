# Windows Computer Backups

## Introduction
The Honors College's backups are handled via [Veeam Backup Endpoint Free Edition](https://www.veeam.com/vmware-esxi-vsphere-virtualization-tools-hyper-v-products.html#free). This software needs to be installed manually on a Windows computer. The backups are stored on the "Backups" shared drive on the Synology NAS (hc-storage).

## How to Install Veeam

1. Login to the hc-storage web interface http:\\hc-storage.cougarnet.uh.edu:5000 and download and run the Veeam installer from Software\Windows Software for Client Computers
2. After the install, skip the setup for an external hard drive and uncheck the box on the "Finish" window.
3. After the wizard closes, search for and open the "Configure Backup" window. Select "file level backup", and select the user folder under Users on the hard disk.
4. Select "shared folder" and type in \\hc-storage.cougarnet.uh.edu\Backups and type in the hcbackup account credentials
5. Schedule backups as shown in the image below, maybe varying the time slightly so hc-storage is not bombarded all at once.

### Which computers get backed up?
We only back up user directories of faculty and staff Windows computers.

| User account                  | Backup folder name    | Computer Name |
|-------------------------------|-------------|-------------------------------------|
| bjohnson (B. Rhoden)          | hc-rhoden/Backup Job HC-RHODEN2 | HC-Rhoden2   |
| sbhojni (S. Bhojani)          | Backup Job HC-SBHOJANI | hc-bhojani |
| alittle (A. Little)           | Backup Job HC-LITTLE | hc-little |
| mhanke (M. Hanke)             | hc-hanke/Backup Job HC-HANKE | hc-hanke |  
| ghauser (G. Hauser)           | Backup Job HC-HAUSER | hc-hauser |
| losorio (L. Osorio)           | Backup Job HC-BUSINESS4 | HC-BUSINESS4 |
| baramire (B. Ramirez)         | Backup Job HC-BUSINESS1 | HC-BUSINESS1 |
| garcia (L. Lopez)             | Backup Job HC-BUSINESS5 | HC-BUSINESS5 |

Use these settings when setting up Veeam. However, do not include things like Google Drive, DropBox, OneDrive, Trash, and Downloads.
