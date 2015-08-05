## 1. Install Java SDK (Standard Development Kit)

Check whether you have Java installed by opening a command line tool (cmd in Windows, Terminal in Mac OS) and type `java -version`. If it shows something like `java version "1.6.0_65"`
`Java(TM) SE Runtime Environment (build 1.6.0_65-b14-462-11M4609)`
`Java HotSpot(TM) 64-Bit Server VM (build 20.65-b04-462, mixed mode)` you are ok and don't have to install Java. Please move to step 2.

The JDK may be obtained from Oracle Corporation’s website using the [[URL|http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html]].

Assuming that a suitable JDK is not already installed on your system, download the latest JDK package that matches the destination computer system. You need to select a package that fits your machine, e.g. jdk-8u5-macosx-x64.dmg if you are using a Mac. Once downloaded, launch the installation executable and follow the on screen instructions to complete the installation process. (It may already be installed - Mac, look under System Preferences, Java, then the update tab for version info)

## 2. Install Android SDK Tools

### For Mac Users:

Use [MacPorts ](https://guide.macports.org/chunked/installing.macports.html)
`sudo port install android` from the Terminal command line will do all of the below.

### For Windows Users:

Get the Android development tools from the [[Android Developer site|http://developer.android.com/sdk/index.html#ExistingIDE]].
You only need to install the tools. Make sure you click on "Download the SDK tools for ..." where the ... should say Mac or Windows depending on your environment.

Locate the downloaded ADT zip file in a Windows Explorer window, right-click on it and select the Extract All… menu option. In the resulting dialog, choose a suitable location (e.g. create a new folder as C:\AndroidSDK) into which to unzip the file before clicking on the Extract button. 

### Setup environment variables 

We want to use the Java SDK and the Android SDK tools from a command prompt or terminal window. In order for the operating system on which you are developing to be able to find these tools, it will be necessary to add them to the system’s PATH environment variable.
Regardless of operating system, the PATH variable needs to be configured to include the following paths (where <path_to_adt_installation> represents the file system location into which the Android SDK Tools was installed):
`<path_to_adt_installation>/sdk/tools`
`<path_to_adt_installation>/sdk/platform-tools`

The steps to achieve this are operating system dependent:

### For Mac Users:

There are different ways of setting your default PATH variable. You can use ~/.bash_login but ~/.bash_profile also works. The Android tools are in the tools directory of the Android SDK. The following needs to be added to .bash_login: export PATH=$PATH:`<path_to_adt_installation>/android-sdk-mac_x86/tools, e.g.

`export PATH=$PATH:/Android/android-sdk-mac_x86/tools`

### For Windows Users (details here fit Windows 7 but can be adapted for any other Windows version)

1. Right click on Computer in the desktop start menu and select Properties from the resulting menu.

2. In the properties panel, select the Advanced System Settings link and, in the resulting dialog, click on the Environment Variables… button.

3. In the Environment Variables dialog, locate the _Path_ variable in the System variables list, select it and click on Edit…. Locate the end of the current variable value string and append the path to the android platform tools to the end, using a semicolon to separate the path from the preceding values. For example, assuming the ADT bundle was installed into /Users/demo/adt-bundle-windows-x86_64, the following would be appended to the end of the current Path value:

`;C:\Users\demo\adt-bundle-windows-x86_64\sdk\platform-tools;C:\Users\demo\adt-bundle-windows-x86_64\sdk\tools`

4. Click on OK in each dialog box and close the system properties control panel. Once the above steps are complete, verify that the path is correctly set by opening a Command Prompt window (Start -> All Programs -> Accessories -> Command Prompt) and at the prompt enter:

`echo %Path%`

The returned path variable value should include the paths to the Android SDK platform tools folders. Verify that the platform-tools value is correct by attempting to run the adb tool as follows:

`adb`

The tool should output a list of command line options when executed.

Similarly, check the tools path setting by attempting to launch the Android SDK Manager:

`android`
In the event that a message similar to following message appears for one or both of the commands, it is most likely that an incorrect path was appended to the Path environment variable:
'adb' is not recognized as an internal or external command,
operable program or batch file.

 - Windows

Stage 1. Locate the Java SDK Installation Directory

If you already know the installation path for the Java SDK, go to Stage 2 below. Otherwise, find the installation path by following these instructions:

If you didn't change the installation path for the Java SDK during installation, it will be in a directory under _C:\Program Files\Java_. Using Explorer, open the directory _C:\Program Files\Java_.
Inside that path will be one or more subdirectories such as _C:\Program Files\Java\dk1.8.0_05_. 

Stage 2. Set the JAVA_HOME Variable

Once you have identified the Java SDK installation path:

Right-click the My Computer icon on your desktop and select Properties.

Click the Advanced tab.

Click the Environment Variables button.

Under System Variables, click New.

Enter the variable name as _JAVA_HOME_.

Enter the variable value as the installation path for the Java Development Kit.
If your Java installation directory has a space in its path name, you should use the shortened path name (e.g. C:\Progra~1\Java\jdk1.8.0_05) in the environment variable instead.

Note for Windows users on 64-bit systems

Progra~1 = 'Program Files'

Progra~2 = 'Program Files(x86)'

Click OK.

Click Apply Changes.

Close any command window which was open before you made these changes, and open a new command window. There is no way to reload environment variables from an active command prompt. If the changes do not take effect even after reopening the command window, restart Windows.

### Finish Android SDK install

When you are done open a terminal and enter the command `android`, hit enter and the SDK configuration tool should open. Install the missing packages offered by the tool.


## 3. Install ant

### For Mac Users:
Use [MacPorts](https://guide.macports.org/chunked/installing.macports.html) and type

`sudo port install apache-ant`

### For Windows users

Follow instructions [[here|http://ant.apache.org/manual/install.html]]

## 4. Install nodeJS

For Mac and Windows Users

Step 1- download node-v0.10.26.pkg (or higher) from http://nodejs.org

Step 2- install the package and follow the directions to complete

v0.10.26 / current as of May 21 is 0.10.28

## 5. Install Phonegap

### For Mac users
step 1- enter the following command into a terminal 

`sudo npm install -g phonegap`

http://phonegap.com/install/

version 3.4


## 6. Install Brackets
Step 1- download Brackets.Sprint.38.dmg from [Brackets Download Page](http://brackets.io)
(39 is current)


Step 2- launch the .dmg and install the app by following the directions

version 3 

##7. If you are working on a project that involves [ionic](http://ionicframework.com/getting-started/) 
`sudo npm install -g cordova`