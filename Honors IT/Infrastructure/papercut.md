##Introduction
PaperCut is a commercial software package that we use to track student printing in the Computer Lab. It's installed on all the computers via Munki, and has a LaunchAgent to keep it from being closed out by students. PaperCut-NG is very heavily documented in its own right, and the answers to many questions can be found in PaperCut's [knowledge base](http://www.papercut.com/kb/).


##Server
The PaperCut Server application does all of the heavy lifting and is installed on HC-Papercut, a machine solely dedicated to this purpose. The PaperCut Administration interface is accessible at [http://hc-papercut.local:9191/admin](http://hc-papercut.local:9191/admin). The password can be found in the password vault.

The server is mostly a set it and forget it operation, unless it messes up majorly.


###User Limit
The Honors College has purchased a 2500 user license to PaperCut. This means that there can only be 2500 or less people in the group allowed to print at any given time. If we need more users, speak to the College Business Administrator to buy another license.


##Client
The PaperCut client is a small Java applet that uses a student's Cougarnet credentials to authenticate to the server and make sure they have enough of a balance left to print. If a guest, or user who isn't in the HC-Students Active Directory group tries to print, the applet will not allow printing until they supply a valid Cougarnet ID and password.


##Authentication
Only current students of the Honors College may print from the computer lab computers, which means the list changes once a semester. The PaperCut Server authenticates directly with Active Directory to provide this service. More information on AD binding can be found on the [User and Group Synchronization](http://www.papercut.com/products/ng/manual/ch-sys-mgmt-user-group-sync.html) page of the PaperCut KB.

If there are user synchronication errors, check that the account being used for synchronization has a valid password, and has not been locked.

Make sure that only the **HC-Students** group is being synced to Active Directory, and the the option **Delete users that do not exist in the selected source** is selected to enable pruning of old users.

##Maintenance
Every semester, a manual sync needs to be run on the HC-Students group to keep it up to date.

Every ninety days, update the password for the AD sync account in PaperCut.
