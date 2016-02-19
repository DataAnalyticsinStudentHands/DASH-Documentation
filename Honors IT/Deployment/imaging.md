The following figures illustrate the workflow for imaging a computer and some other workflows involved.

<div style="width: 640px; height: 480px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:640px; height:480px" src="https://www.lucidchart.com/documents/embeddedchart/e7fae3b7-587c-4b59-90e3-f410ac3239ad" id="6l89Ew87hb7Q"></iframe></div>

In the following we describe the software that is used in the process of creating, maintenance and deploying images. We then describe the setup that used within Honors.

## Software Used

### AutoDMG

AutoDMG is used to create clean, never-booted dmg master images for use with DeployStudio. It can be found [on GitHub](https://github.com/MagerValp/AutoDMG). Download the latest release.

### CreateUserPkg

CreateUserPkg creates a package that is installed through DeployStudio that creates the hcadmin local user for computers. It can be found [on GitHub](https://github.com/MagerValp/CreateUserPkg).

### DeployStudio

DeployStudio is used to keep track of computer hostnames, deploy images, bind computers to Active Directory, and deploy first-boot settings. It can be found at http://deploystudio.com/

### Munki

Munki is a client-server application that uses a web server and plists to install software for each type of computer we support. It can be found [on GitHub](https://github.com/munki/).

### MunkiAdmin

MunkiAdmin is a GUI that allows us to managed the munki respository with little work. It can be found [on GitHub](https://github.com/hjuutilainen/munkiadmin).

### AutoPkgr

AutoPkgr creates packages from sets on instructions, called recipes, that integrated directly into munki. It can be found [on gi]

### Server.app

Server.app is Mac OS X's directory and server application. It provides Profile Manager, which pushes settings and printers to computers as well as NetBoot/NetInstall which allow DeployStudio to boot and deploy images over a network. It is provided through the Mac App Store and can be downloaded [here](https://itunes.apple.com/us/app/os-x-server/id883878097?mt=12).

**NOTE: Always download the latest versions of these tools before using them.**

## Setup

### Notes

- If not noted otherwise, all of this work will be done on the HC-Deployment virtual machine. It can be accessed through Apple Remote Desktop or by using the vCenter console installed on HC-Management.
- All of this software should be installed on HC-Deployment, or can be restored from a backup of HC-Deployment.
- All of the shares located on HC-Storage should be mounted on HC-Deployment before beginning this process.
- Make sure that OS X is up-to-date before proceeding.

### OS X Server

#### Install Server.app

Server.app should already be installed on HC-Deployment. If not, the VM should be restored from backup. If a backup does not exist, reinstall the app from the App Store.

#### Setup OS X Server

**Mac OS X Server should already be configured, the following instructions are for an installation from scratch.**

1. Go through the Mac OS Server setup process, and make sure that it will be set up on the computer HC-Deployment.
2. Once Server has completed its setup tasks, go to the settings tab the Overview page, and check that Enable Apple Push Notifications is checked. If not, check the box, and follow the instructions.
3. Turn on Websites service by selecting Websites in the left-hand pane and moving the toggle on the page to **ON**.
4. Enable Profile Manager by selecting Profile Manager in the left-hand pane and moving the toogle on the page to **ON**.
5. Configure Profile Manager by following the instructions [here](http://krypted.com/mac-security/configure-profile-manager-on-yosemite-server-yosemite-running-the-server-app/) under the section Setting Up Profile Manager. **Do not configure the Device Enrollment Program, or the Volume Purchase Program.**

### DeployStudio

#### Install DeployStudio

DeployStudio should already be installed on HC-Deployment. If not, the VM should be restored from backup. If a backup does not exist, reinstall the app from the download link above.

#### Setup DeployStudio

**DeployStudio should already be configured, the following instructions are for an installation from scratch.**

Follow the [DeployStudio Quick Installation Guide](http://www.deploystudio.com/Doc/Entries/2014/10/21_Quick_Install_Guide_files/Quick%20Install%20Guide.pdf).

Our DeployStudio installation will be using the following options:

- Full network configuration
- The repository will be located on HC-Storage at ```` smb://hc-storage.cougarnet.uh.edu/Deployment/ ````
- The server address will be ```` http://hc-deployment.cougarnet.uh.edu:60080/ ````
- The username will be ```` hcadmin ```` and password will be the local password for hcadmin.
- HC-Deployment will be set up as a DeployStudio master.
- Select **network sharepoint** as the location of the DeployStudio repository and enter the path given above. The user name is ```` deployment ```` and fill in the associated password.
- Don't enable email notifications.
- Don't encrypt traffic, use the default server port, and **do not** reject unknown computers.
- Don't configure any specific groups for DeployStudio access.
- Do not change multicast settings. UH's network is not compatible with multicast deployments.
- Make sure ```` Hardware Serial Number (default) ```` is selected as the computer identifier.

#### Create a NetBoot Set

Refer to the Creating a DeployStudio NetBoot Set in the [DeployStudio Quick Installation Guide](http://www.deploystudio.com/Doc/Entries/2014/10/21_Quick_Install_Guide_files/Quick%20Install%20Guide.pdf).

Use these options:

- Do not enable the DHCP server.
- Use the current boot volume as the source.
- Use the provided system name.
- Set the unique identifier to any number between 1 and 65535 that is not the provided one.
- Use the NFS protocol.
- Use the current language.
- Set the network time server to ```` cndc13.cougarnet.uh.edu ````.
- Select ````Connect to specific servers ```` and enter ```` http://hc-deployment.cougarnet.uh.edu:60080/ ```` in both the preferred and alternative text fields.
- The default login will be ```` hcadmin ```` and the associated password on HC-Deployment.
- Set the ARD user login to ```` hcadmin ```` and the password to ```` gocoogs ````. It need not be complex or secure because it is temporary.
- Disable wireless support
- Make sure the destination is set to ```` /Library/NetBoot/NetBootSP0 ````.
- Make it the default NetBoot set.

When NetBoot set creation is finished, go into Server.app and turn on the NetBoot service.

### AutoDMG

#### Setup

Use AutoDMG on HC-IT, do not use it on a Virtual Machine. Make sure that the Deployment share is mounted and writable. Download and mount the AutoDMG disk image. Download the latest Mac OS X installer from the [Mac App Store](https://itunes.apple.com/us/app/os-x-yosemite/id915041082?mt=12) and selecting "Continue" at the prompt. Wait for the download to complete.

#### Image Creation

Once the download has completed, open AutoDMG and follow the instructions in [this guide](http://www.theinstructional.com/guides/build-deploy-os-x-images-with-autodmg), and select apply updates, but **do not** install any additional packages. We will create a user package later, that will be deployed with DeployStudio.

Use the following information to name and save the image:

- Name the image ```` BaseImage.hfs.dmg````. **The image must have the extension ````.hfs.dmg```` to be recognized by DeployStudio.**
- The image should be saved to ````\Volumes\Deployment\Masters\HFS\```` to ensure that it is placed in the DeployStudio network share.

### CreateUserPkg

#### Setup

Use CreateUserPkg on HC-IT, mount the disk image and open the application.

#### Package Creation

Fill out the fields as follows:

- Full Name: ````The Honors College````
- Account Name: ````hcadmin````
- Password: Enter the hcadmin password
- Verify: Repeat the password from above
- Account Type: Administrator
- Package Type: ````edu.uh.honors.createhcadmin.pkg````
- Version: ````yyyy.mm```` Example: ````2015.03````

Save the created package to ````\Volumes\Deployment\Packages\````.

### Munki

Munki provides a client-server model for maintaining software on computers throughout the College. It replies on a HTTP server, client package, and PLIST files.

#### How Munki Works

Munki is installed on all client computers, and when called (or at boot), check for ````ManagedInstalls.plist```` in the ````/Library/Preferences```` directory of the client computer. This file contains the location for the munki server, as well as a ClientIdentifier, which maps to a manifest on the Munki server. There are serveral ````ManagedInstalls.plist```` files in the [thinimaging repository](http://github.com/thehonorscollege/thinimaging/). Each file is named after the user class they are meant to be used with. The deployment script uses ````cURL```` to download the file, rename it, and place it into the appropriate directory.

When called, munki checks the appropriate manifest on the server, then checks the catalogs available to that manifest. If a package appears on both the manifest, and in one of the available catalogs, it will be downloaded and installed.

#### Setup

Make sure that all the shares on HC-Storage are mounted and writable. Make sure that there is a folder labeled ````munki```` in the web folder, with the following subdirectories:
- catalogs
- manifests
- pkgs
- pkgsinfo

Install ````munkitools.dmg```` on the local computer. Munki setup is now complete.

### MunkiAdmin

#### Setup

Download the latest version of MunkiAdmin from GitHub, and copy it to the Applications folder on the local computer.

#### Managing a Munki Repository

Open MunkiAdmin, and navigate to the munki share, which should be ````\Volumes\Shared\web\munki\```` and open the repository. You can view all available packages, catalogs, and manifests.

**Remember that a package and the catalog it is assigned to must be enabled in the manifest.**

### AutoPkgr

AutoPkgr checks for updates to specified pieces of software, and automatically imports them to Munki. This often results in duplicate packages, so you may need to clean up the duplicates in MunkiAdmin every once in awhile. It is installed on HC-Deployment.

#### Setup

AutoPkgr should be configured according to [these instructions](https://derflounder.wordpress.com/2014/07/15/autopkgr-a-gui-for-autopkg/). Only select recipes that correspond to the Honors College Package List. Do not configure the email notifications. This is the path for the munki repository - ````\Volumes\Shared\web\munki\````. AutoPkgr should run automatically from here on out.
