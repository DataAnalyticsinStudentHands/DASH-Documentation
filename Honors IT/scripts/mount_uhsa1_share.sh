#!/bin/sh

currentuser="$(whoami)"

if mount | grep "uhsa1.cougarnet.uh.edu/HCShare on /Volumes/HCShare" > /dev/null;
then
	echo "Mounted."
else
	mkdir /Volumes/HCshare
	#hcadmin doesn't need access to these things
	if [ $currentuser = "hcadmin" ]
	then
		exit 0
	else
		echo "Running as $currentuser..."
		/sbin/mount -t smbfs //$currentuser@uhsa1.cougarnet.uh.edu/HCSHare /Volumes/HCShare
	fi
fi

exit 0