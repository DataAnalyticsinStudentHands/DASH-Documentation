#!/bin/sh

function scriptcontents {
/usr/bin/smc -k F0Mn -w 1500
/usr/bin/smc -k F0Mx -w 2000

/usr/bin/smc -k F1Mn -w 1500
/usr/bin/smc -k F1Mx -w 2000
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
