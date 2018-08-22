<h1>Backup Verification</h1>
<p><br></p>
<h2>Overview</h2>
<p><span style=""><br></span></p>
<p><span style="">The verify_backups.sh script is used as a nightly job on hc-deployment, but the script is set up to work when run from any computer for testing purposes. The script attempts to detect the most recent time the backup directories were modified to determine the date of the most recent backup. There is simple or fast way to determine the most recently modified file in a directory tree other than traversing that tree and checking all of the files. This is obviously a very time consuming and slow process. When running on hc-it-laptop, it takes around {figure out how long this takes} for an average computer. To avoid having to check the modification date of every single file we backup, the actual backup script records the datetime upon completion in a .backup file. This allows us to simply check the file to see if it has backed up. If this check fails, we then fall back on the manual verification process. The results of the verification will be recorded in a file saved on hc-storage/backups. A report will also be emailed to honorsit@central.uh.edu.<br></span></p>
<p><span style=""><br></span></p>
<h2><span style="">Script Workflow</span></h2>
<div><br></div>
<p>Here is a detailed walkthrough of the script from top down.&nbsp;</p>
<p><br></p>
<p><br></p>
<p>1.&nbsp;Start the log file and the report. <b>The script will automatically determine if it is running "in production" on hc-deployment. If not it will use the dev path. Make sure this path is correct for the machine you are working on.&nbsp;</b></p>
<p>2. Ensure that the script is running as root. Without root privileges the script may fail ungracefully. Fail gracefully if not root.</p>
<p>3. Set the machine list. This is the list of machines stored in a .txt file on the host machine. This can be modified in development if you only want to test on certain machines for the sake of time. Fail gracefully if the machine list does not exist. <b>Again, the script will determine if it is running "in production". If not, it will use a dev path. Make sure this path is correct for the machine you are working on</b></p>
<p>4. Count the machines for the loop.</p>
<p>5. Check to see if the backup folder is mounted already. Fail gracefully if is already mounted. Mount it if it is not.</p>
<p>6. Set the maximum age in minutes for a backup to be valid. Any backup older than this will be considered invalid.</p>
<p>7. Check if this is a full or compressed verification. A full verification will ignore the .backup file for all backups and find the most recently modified directory to determine the age of the backup. This very time consuming and should not be the default setting.&nbsp;</p>
<p>8. Navigate to the backups directory, write the log headers</p>
<p>9. Set cleanup trap, define the log_backup function.</p>
<p><br></p>
<p>There are multiple nested if statements in this loop. Be careful and make sure you understand the logically fully before attempting to make changes</p>
<p><br></p>
<p>IN LOOP:</p>
<p></p>
<p><img src="https://attachment.freshservice.com/inline/attachment?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAwOTYxODc1OCwiZG9tYWluIjoiaG9ub3JzY29sbGVnZS5mcmVzaHNlcnZpY2UuY29tIiwidHlwZSI6MX0.pimJMmateetxqwUBH0zVHa7B7cHLJQJ3woatltVcK3o" class="inline-image" data-id="1009618758" data-store-type="1" style="cursor: default; height: 467px;" title="" data-height="467"></p>
<br><p></p>
