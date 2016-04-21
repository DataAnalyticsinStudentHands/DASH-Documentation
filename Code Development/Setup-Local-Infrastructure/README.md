The two files in this directory: `installer.bat` and `mobiledev.ps1` help setup a development environment for developing for DASH. It is focused towards the front end developer, though some tools for backend development are also included. This script currently only works on windows operating system. The bat file ascertains Administrative rights before launching the powershell script which uses Chocolatey package manager to install the necessary software. Users can edit the script before install to add/remove packages based on need. Please contribute necessary packages/updates to the script in this repository.

#### How to Use
1. Download the two files and place in same folder.
1. Double click on `installer.bat` which will request Admin privileges.
1. Interact with requested options (minimal) throughout the install process.

#### List of Installed Software
1. Chocolatey Package Manager
1. Java JDK + Add to PATH
1. Apache ANT
1. Android SDK
1. Android SDK Tools - may need to be updated manually
1. NodeJS (npm)
1. Virtualbox
1. Genymotion
1. SourceTree
1. Brackets
1. Cordova
1. bower
1. ionic