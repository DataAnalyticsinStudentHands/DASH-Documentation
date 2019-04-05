#!/bin/sh
exec 2>&1

function scriptcontents {
# Get MacOSX idletime. Based on mouse and keyboard activity
idleTime=$(/usr/sbin/ioreg -c IOHIDSystem | /usr/bin/awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')

# 809 is 14 minutes less thirty-one seconds, logout sends a dialog box that has a 1 minute warning.
# (This means the 1 minute warning is thrown sometime between 14.5 and 15.5 minutes of idle activity,
# since the plist that runs this script checks once per minute rather than continuously. Computers
# should be set to display sleep after 16 minutes, and although the script should not have issues
# running during sleep, all this gives at least a 30 second window for the script to run normally.)
# If after the warning passes the idletime has not gone down, the user is gone, kill apps and logout.

if (( $idleTime > 809 ))
then
answer=$(osascript -e 'tell application "System Events" to get the button returned of (display dialog "Closing all apps and logging out in 1 minute!" buttons {"No, wait!"} default button 1 giving up after 60)')
	if [ "$answer" == "No, wait!" ]
	then
		# If the button is clicked, they are still active. The issue is that when controlling a lab computer
		# via ARD this script will not see the control as HID activity, and continue to log out the user
		# after the button is clicked since idleTime2 will be over the threshold.
		exit 0
	fi

	# Check if the user manually controlling the computer has been active since the warning message popped up.
	idleTime2=$(/usr/sbin/ioreg -c IOHIDSystem | /usr/bin/awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')
	if (( $idleTime2 > 809 ))
	then
		# Exclude Finder at minimum because bad things happen, apparently
		declare -a excludedApps=("Finder")

		# Get processes
		IFS=',' read -r -a processList <<< "$(osascript -e 'tell application "System Events" to get the name of (every application process whose background only is false)')"
		IFS=',' read -r -a pidList <<< "$(osascript -e 'tell application "System Events" to get the unix id of (every application process whose background only is false)')"

		i=0
		for process in "${processList[@]}"
		do
			# Remove leftover whitespace at beginning of process names
			process=${process#" "}

			if [[ ! " ${excludedApps[@]} " =~ " $process " ]]
			then
				# Kill processes, suppress prompts asking whether to save work (remove beginning whitespace from ids too)
				id=${pidList[$i]}
				kill -9 ${id#" "}
			fi
			i=$(( $i + 1 ))
		done

		# Finally, with all apps closed, log out immediately
		osascript -e 'tell application "loginwindow" to «event aevtrlgo»'
	fi
fi

exit 0
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
