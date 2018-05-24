#!/bin/sh

# Delete hcguest so that changes are removed
/usr/bin/dscl localhost delete /Local/Default/Users/hcguest
rm -rf /Users/hcguest

# Download and install guest package
curl hc-storage.cougarnet.uh.edu/packages/create_hcguest-1.0.pkg -o /usr/local/honors/create_hcguest-1.0.pkg
/usr/sbin/installer -pkg /usr/local/honors/create_hcguest-1.0.pkg -target /
