#!/bin/sh

function scriptcontents {
curl = "/usr/bin/curl"

curl http://hc-storage.cougarnet.uh.edu/scripts/PolicyBanner.rtfd -o /Library/Security/PolicyBanner.rtfd
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
