In order to streamline the process of pulling down backup files to a newly reimaged mac, we have a script that utilizes a password-less rsa key. The key is stored on a password protected flash drive labeled "backup pull key".

IT IS VERY IMPORTANT THAT id_rsa IS NEVER STORED ANYWHERE OTHER THAN THIS FLASHDRIVE

## Anyone with access to this private key has password-less access to hc-storage.

To pull down backup files:

1. Have the faculty member log in to their machine.

2. Plug in the key and unlock it with admin credentials.

3. Open terminal, change directory to /Volumes/keys and **as the faculty member**, run *bash pull_mac_backup.sh backup_folder*

*backup_folder* is the name of the backup folder in hc-storage, such as HC-IT or hc-brunt. It is done this way in case the machine and folder names do not match.

4. The script will pull files and unmount the flash drive.
