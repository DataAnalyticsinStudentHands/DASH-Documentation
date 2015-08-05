DASH System Infrastructure
==========================

Description:
Collection of system scripts and installation procedures to run on the DASH backend. Main purpose is backup and notification.

Backup Script:
=======
runmysqlbackup - uses runmysqlbackup.conf and calls automysqlbackup as well as s3cmd sync

11/03/2014
Changes made to original automysqlbackup script in /usr/local/bin

# Remove annoying warning message since MySQL 5.6
if [[ -s "$log_errfile" ]]; then
sedtmpfile="/tmp/$(basename $0).$$.tmp"
grep -v "Warning: Using a password on the command line interface can be insecure." "$log_errfile" > $sedtmpfile
mv $sedtmpfile $log_errfile
fi
