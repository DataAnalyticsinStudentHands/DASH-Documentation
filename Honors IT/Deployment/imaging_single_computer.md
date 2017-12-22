## Imaging A Computer

1. First, make sure your computer is connected to the network via ethernet.
2. Then, restart the computer. After the start up 'chime', hold down the N key.
3. This will cause the computer to boot from the network and connect to ActiveDirectory.
  * The admin password has not been updated, so you will not be logged in automatically. Until it is updated, there will be a NSURLErrorDomain error -1012. You can ignore this.
4. After naming the computer, you will be directed to a list of possible profiles to choose from. Select your desired profile, then press the 'play' button.
5. When prompted, enter an admin account username and password to bind computer to the domain. After completing the process, computer will restart.
6. If everything works properly, computer will complete binding to ActiveDirectory upon restart.

## Special Instructions for Reimaging facultystaff Computers

1. Rename the computer in System Preferences->Sharing, add something like "temp" or "reimaging" to the name.
* (e.g. "hc-tedestess" to "hc-tedestess-reimaging")
2. Run the backup.sh script as hcadmin:
* `sudo bash /usr/local/honors/backup.sh`
* and check the terminal output to ensure that it ran completely and successfully.
* Note: The purpose of steps 1 and 2 is to create a backup containing only current files from the staff member's machine. The normal backup folders on hc-storage contain a litany of older files as well, possibly so many that they won't all fit back onto the machine.
3. Check hc-storage to be sure the new backup folder is created as intended.
4. Reimage the machine via the instructions above. (You can put the name back to normal now)
5. Log into the machine as the faculty member, plug in the "MAC BACKUP PULL KEY" usb drive, unlock it, and run
* `bash /Volumes/keys/pull_mac_backup.sh hc-reimaging-name`
* (replace hc-reimaging-name with the new name you created in step 1)
* (yes, it should be run without sudo)
* Note: the script unmounts the usb drive when it finishes
6. Check the Terminal output for errors.
