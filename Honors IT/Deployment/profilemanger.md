
We only use Mac OS X Profile Manager to solely manage printing and mounting network shared at login. Those settings will then be imported for distribution via Munki and are based on User/Computer class.

The settings generated with the Profile Manager are named `*.mobileconfig`. Please refer to the "Software List" document about specific settings generated.

The Profile Manager has been setup on HC-Deployment (using Server.app) and accessible via: https://curly.cougarnet.uh.edu/

To generate a setting open Profile Manager and go to "Device Groups".

## Examples for Settings generated with the Profile Manager

### loginuhsa1.mobileconfig

This setting will mount the HCShare when a user logs in.

_Name of the Device Group: `Login to UHSA1`_

#### Select: Settings

*Login Items*
* Add an **Authenticated Network Mount**.
	*  Protocol: **SMB**.
	*  Hostname: **uhsa1.cougarnet.uh.edu**.
	*  Volume: **HCShare**.
