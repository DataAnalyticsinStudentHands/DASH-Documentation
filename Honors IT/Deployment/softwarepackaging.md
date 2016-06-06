# Software Packaging Guide

Software is deployed via Munki. MunkiAdmin is the tool to be used to create packages and settings to be deployed. The list below describes how to configure packages for each software package.

## Microsoft Office 2011

### Package Format

- ISO disk image, downloaded from AccessUH.

### Instructions

- Use MunkiAdmin to import the package. ````File > Import Package````

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

Do not use any feature lockdown customizations.

Save the package and use MunkiAdmin to import the package.

## EasyFind

## List of Software Installed automatically

<<<<<<< HEAD:Honors IT/Deployment/softwareinstallation.md
AdobeFlashPlayer
AdobeReader
Cyberduck
Dropbox
Firefox
GoogleChrome
GoogleDrive
Handbrake
MakeCatalogs
OracleJava7
OracleJava8
SilverLight
Skype
Spotify
TextMate2
VLC
MunkiTools2

## List of Software Installed manually

AutoDMG
Brackets
CreateUserPkg
DeployStudioAdmin
EasyFind
EclipseLuna
FileZilla
LaTeXiT
MunkiAdmin
R.Munki
SequelPro
SublimeText3
TeXLiveUtility
TeamViewer
TeamViewerQS
MacTex
Node.Munki
smcFanControl
=======
- AdobeFlashPlayer
- AdobeReader
- Cyberduck
- Dropbox
- Firefox
- GoogleChrome
- GoogleDrive
- Handbrake
- MakeCatalogs
- OracleJava7
- OracleJava8
- SequelPro
- SilverLight
- Skype
- Spotify
- TextMate2
- VLC
- MunkiTools2

## List of Software Installed manually

- AutoDMG
- Brackets
- CreateUserPkg
- DeployStudioAdmin
- EasyFind
- EclipseLuna
- FileZilla
- LaTeXiT
- MunkiAdmin
- R.Munki

- SublimeText3
- TeXLiveUtility
- TeamViewer
- TeamViewerQS
- MacTex
- Node.Munki
- smcFanControl
>>>>>>> 70f10d6816e71520de2bb8a1e287f10d8d8790bd:Honors IT/Deployment/softwarepackaging.md
