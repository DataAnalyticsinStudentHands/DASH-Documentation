
# Introduction
Mac OS X Profile Manager is ideally supposed to be responsible for controlling most of the settings on Macintosh computers. However, it is bad at its job and tends to corrupt its database every once in awhile. Therefore, we have moved most of the settings away from Profile Manager to their command-line equivalents. We only use Profile Manager to solely manage printing and mounting network shared at login, because those are tasks that it can complete without suffering from amnesia.

# Settings used based on User/Computer class

1. Lab Computer Settings

### Printing
* Add **Honors Lab Printer 1 @ HC-Papercut**.
* Add **Honors Lab Printer 2 @ HC-Papercut**.
* Check **Allow printers that connect directly to user's computer**.

2. Employee Computer Settings

### Login Items
* Add an **Authenticated Network Mount**.
	*  Protocol: **SMB**.
	*  Hostname: **uhsa1.cougarnet.uh.edu**.
	*  Volume: **HCShare**.

3. Student Services Settings

### Printing
* Add **Student Services Printer**, IP Address: `172.27.56.196`
* Add **Copy/Storage Xerox**, IP Address: `172.27.56.7`
* Add **Xerox Phaser 7400dn**, IP Address: `172.27.56.199`

4. Settings available for Faculty/Staff

### Printing
* Add **204 POD Printer**
* Add **Copy/Storage Xerox**, IP Address: `172.27.56.7`
* Add **Dean's Area Xerox**, IP Address: `172.27.56.8`
* Add **205 POD Printer Printer**
* Add **206 POD Printer**
* Add **Dean's Area Printer**
* Add **Copy/Storage Xerox**, IP Address: `172.27.56.7`
* Add **Dean's Area Xerox**, IP Address: `172.27.56.8`


5. Recruitment Computer Settings

### Printing
* Add **Recruitment Printer**
* Add **Copy/Storage Xerox**, IP Address: `172.27.56.7`
* Add **Dean's Area Xerox**, IP Address: `172.27.56.8`
