
Software is deployed via Munki. MunkiAdmin is the tool to be used to create packages and settings to be deployed. The list below describes how to configure packages for each software package.

Please make sure to keep copies of all software packages BEFORE import into Munki in hc-storage/Software.

## Standard Packages

### Package Format

- *.dmg

### Instructions

- Use MunkiAdmin to import the package. ````File > Import Package````
- Name package to match name of previous package (or, if it's the first time, use the name it comes with).
- Check if it shows up into the testing catalog.
- Add it to the testing manifest.
- Test.
- After successful test, move it into catalog available and into any manifest where desired.

## Microsoft Office 2011

### Package Format

- ISO disk image, downloaded from AccessUH.

### Instructions

- Use MunkiAdmin to import the package. ````File > Import Package````

## Adobe Flash Player

### Package Format

- Is injected into Munki via AutoPkg (as *.dmg)

### Testing Instructions

- Go to https://www.adobe.com/swf/software/flash/about/flashAbout_info_small.swf and run test

## Adobe Reader

### Package Format

- Download the latest DMG disk image from [Adobe Enterprise](http://get.adobe.com/reader/enterprise/).

### Instructions

- Use MunkiAdmin to import the package. ````File > Import Package````

## Adobe Acrobat Pro

### Package Format

- Download the latest package from AccessUH.
- Download the [Adobe Customization Wizard](http://www.adobe.com/support/downloads/detail.jsp?ftpID=5512).

### Instructions

- Follow the instructions on [Adobe's Website](http://www.adobe.com/devnet-docs/acrobatetk/tools/MacWiz/index.html).

Use the feature configuration section to configure the following options:

- Select the input .pkg installer you downloaded from AcccessUH.
- Serialize the product with the serial number on AccessUH.
- Accept the EULA automatically.
- Disable Registration.
- Disable Adobe PDF browser integration.
- Disable Online Activation/Allow Online Activation.

### Update

- Download the latest DMG disk image from Adobe's website. All updates with the exception of 11.0.15 requires Adobe Acrobat 11.0 or later to be installed on your system. 
- Use MunkiAdmin to import the package. File > Import Items...
- Change the DMG disk image properties to reflect that it is an update for Adobe Acrobat XI. Packages view > select update package > Properties > Requirements > add Acrobat XI to the "Update for" list.  

Do not use any feature lockdown customizations.

Save the package and use MunkiAdmin to import the package.

## FileMaker Pro Client

### Package Format

- currently .dmg (this may change with another release)
- needs to be downloaded from special link provided at time of purchase (contact Brenda Ramirez)

### Instructions

1. unpack the original installer 
2. modify the txt file to contain our license information (as discussed at http://help.filemaker.com/app/answers/detail/a_id/7099/~/assisted-install-for-filemaker-pro-and-filemaker-pro-advanced)
3. pack both together 
4. Import into munki and make adjustments if needed (array)

The following web sites might be of help:

https://github.com/munki/munki/wiki/FileMaker-Pro

https://technology.siprep.org/packaging-filemaker-pro-for-munki/

https://www.techwalla.com/articles/how-to-edit-dmg


