#!/bin/bash
etag=$(/usr/bin/curl -si -H "Accept: application/json" -H "Content-Type: application/json" -I -X HEAD https://api.github.com/gists/8c4bd7bccdbe1b52abc2112a34756932 | grep -Fim 1 etag: | cut -d'"' -f 2)
if [ ! -f /Library/Application\ Support/tivoli/tsm/client/ba/bin/dsm.sys ] || [ $etag != $(/usr/bin/xattr -p etag /Library/Application\ Support/tivoli/tsm/client/ba/bin/dsm.sys) ]; then
  /usr/bin/curl -s https://gist.githubusercontent.com/emfilice/8c4bd7bccdbe1b52abc2112a34756932/raw -o /Library/Application\ Support/tivoli/tsm/client/ba/bin/dsm.sys
  /usr/bin/sed -i -e "s/HC-IT2/$(hostname -s)/1" /Library/Application\ Support/tivoli/tsm/client/ba/bin/dsm.sys #replaces default nodename with computer hostname'
  /usr/bin/xattr -w "etag" $etag /Library/Application\ Support/tivoli/tsm/client/ba/bin/dsm.sys
  /bin/bash /Library/Application\ Support/tivoli/tsm/client/ba/bin/StopCad.sh
  /bin/bash /Library/Application\ Support/tivoli/tsm/client/ba/bin/StartCad.sh
else echo Nothing to update.
fi
