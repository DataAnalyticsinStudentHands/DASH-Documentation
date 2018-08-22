<p>In order to streamline the process of pulling down backup files to a newly reimaged mac, we have a script that utilizes a password-less rsa key. The key is stored on a password protected flash drive labeled "mac backup pull key".&nbsp;</p>
<p><br></p>
<p><b>IT IS VERY IMPORTANT THAT id_rsa IS NEVER STORED ANYWHERE OTHER THAN THIS FLASHDRIVE</b></p>
<p><b><br></b></p>
<p>Anyone with access to this private key has password-less access to hc-storage.</p>
<p><br></p>
<p>To pull down backup files:</p>
<p><br></p>
<p>1. Have the faculty member log in to their machine.</p>
<p><br></p>
<p>2. Plug in the key and unlock it with admin credentials.</p>
<p><br></p>
<p>3. Open terminal, change directory to /Volumes/keys and <b>as the faculty member</b>, run <i>bash pull_mac_backup.sh backup_folder</i></p>
<p><i><br></i></p>
<p><i>backup_folder</i> is the name of the backup folder in hc-storage, such as HC-IT or hc-brunt. It is done this way in case the machine and folder names do not match.</p>
<p><br></p>
<p>4. The script will pull files and unmount the flash drive.</p>
