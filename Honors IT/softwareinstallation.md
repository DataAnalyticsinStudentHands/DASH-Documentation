<!DOCTYPE html>
<html>
<title>Software Package List</title>

<xmp style="display:none;">	

#Honors College Software Installation Guides

The Honors College requires certain software packaged on its client computers to ensure the college runs smoothly. There are three classes of users in the Honors College, each with their own lists of packages. All packages will be imported into Munki for distrubtion, but certain software may require some work to create a distributable package.

The list below describes how to configure packages for each software package.


##Microsoft Office 2011

###Package Format

- ISO disk image, downloaded from AccessUH.

###Instructions

- Use MunkiAdmin to import the package. ````File > Import Package````

##Adobe Reader

###Package Format

- Download the latest DMG disk image from [Adobe Enterprise](http://get.adobe.com/reader/enterprise/).

###Instructions

- Use MunkiAdmin to import the package. ````File > Import Package````

##Adobe Acrobat Pro

###Package Format

- Download the latest package from AccessUH.
- Download the [Adobe Customization Wizard](http://www.adobe.com/support/downloads/detail.jsp?ftpID=5512).

###Instructions

- Follow the instructions on [Adobe's Website](http://www.adobe.com/devnet-docs/acrobatetk/tools/MacWiz/index.html).

Use the feature configuration section to configure the following options:

- Select the input .pkg installer you downloaded from AcccessUH.
- Serialize the product with the serial number on AccessUH.
- Accept the EULA automatically.
- Disable Registration.
- Disable Adobe PDF browser integration.
- Disable Online Activation/Allow Online Activation.

Do not use any feature lockdown customizations.

Save the package and use MunkiAdmin to import the package.

##EasyFind




####Software List
- Microsoft Office 2011
- Adobe Reader
- Adobe Acrobat Pro
- EasyFind (Allows for efficient searching of SMB shares, such as UHSA1)
- **FileMaker Pro (The Honors College's student data is stored in FileMaker)**
- Google Chrome
- Mozilla Firefox
- Adobe Flash Player
- Spotify
- Sublime Text 3
- Dropbox
- VLC

####Computer Configuration
- These users will be administrators of the computers they commonly use. For exapmle, SSO will have administrator rights on all of the SSO computers, but advisors will only administrator rights on the computer in their office.
- These computers will mount the Backup share on the HC-Storage at login, and configure Time Machine to use it for Backups.

###Faculty & Staff

Faculty & Staff are University employees and student workers who do not require access to student data.

####Software List
- Microsoft Office 2011
- Adobe Reader
- Adobe Acrobat Pro
- EasyFind (Allows for efficient searching of SMB shares, such as UHSA1)
- Google Chrome
- Mozilla Firefox
- Adobe Flash Player
- Spotify
- Sublime Text 3
- Dropbox
- VLC

####Computer Configuration
- These users will be administrators of the computers they commonly use. For exapmle, SSO will have administrator rights on all of the SSO computers, but advisors will only administrator rights on the computer in their office.
- These computers will mount the Backup share on the HC-Storage at login, and configure Time Machine to use it for Backups.

###Lab Computers, Classroom Computers & Consulting Offices

These computers are for general purpose computing, and will be accessed by many people.

####Software List
- Microsoft Office 2011
- Adobe Reader
- Google Chrome
- Mozilla Firefox
- Adobe Flash Player
- Silverlight
- Papercut Client (Manages Printing)
- Sublime Text 3

####Computer Configuration
- These users will **not** be administrators.
- Papercut is configured to start at login using a LaunchAgent, and cannot be exited.
- These computers will be connected to the Lab Printers.





</xmp>

<script src="http://strapdownjs.com/v/0.2/strapdown.js"></script>
</html>