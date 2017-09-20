## Data Warehouse

The Honors College is hosting most of it's data in an in-house FileMaker database which is used by admissions, advisors and recruitment.

### Setup & Administration

We are currently running FileMaker 14 on both sides, the server as well as our clients. FileMaker server is installed on a Mac Mini which is located in the copy/storage room (Honors IT office). The host system is running Mac OS 10.10.5 and uses a RAID1.

The host can be reached under `larry.honors.e.uh.edu`. It is using a static IP address - 172.27.56.1.

The FileMaker Server can be managed via a web console. It is reachable via https://172.27.56.1:16000

### Backup

1. We are using the build in backup funtionality to backup the data files locally into the folder `/Library/FileMaker Server/Data/Backup`. This will create 4 hour, daily, weekly and monthly backups. The files are stored in the default `*.fmp12` format.

### Restore
The software can be installed with installer files that we directly download from FileMaker Inc. , e.g.  https://accounts.filemaker.com/software/?k=mSjTuq36YPQ6KwSPajF7C8QkUwgLSjj7KYyVeLi7 This download link also contains the registration keys. The current download link is only available via request through the Honors College BA (Brenda Ramirez)

The databases are stored as files and can be restored by placing the files:

1. Upload the files that need to be restored into the folder: `/Library/FileMaker Server/Data/Databases`.
2. Open the FileMaker Server Admin console: `Activity -> Open Database`

### FileMaker Client

We are purchasing yearly licenses. Instructions for import into Munki can be found at the following solution https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000015667-software-packaging-maintenance-guide.

