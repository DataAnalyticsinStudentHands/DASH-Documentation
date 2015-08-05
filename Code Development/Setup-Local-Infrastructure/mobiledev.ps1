# Run this in an elevated PowerShell prompt
<# This script worked on a fresh Windows Server 2012 VM in Azure and the following were the latest versions of each package at the time:
* Chocolatey 0.9.8.27
* java.jdk 7.0.60.1
* apache.ant 1.8.4
* android-sdk 22.6.2
* cordova 3.5.0-0.2.6
* nodejs.install 0.10.29
#>
# Note: there is one bit that requires user input (accepting the Android SDK license terms)
 
# Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco # Check this works
 
# Install Java JDK
cinst java.jdk -force
# Set Java bin dir as first thing on path to override java.exe in Windows
[System.Environment]::SetEnvironmentVariable("PATH", [System.Environment]::GetEnvironmentVariable("JAVA_HOME","Machine") + "\bin;" + [System.Environment]::GetEnvironmentVariable("Path","Machine"), "Machine")
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
javac # Check this works
 
# Install ant
cinst apache.ant -force
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
ant # Check this works
 
# Install Android SDK
cinst android-sdk -force
[System.Environment]::SetEnvironmentVariable("PATH", [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";$env:LOCALAPPDATA\android\android-sdk\tools;$env:LOCALAPPDATA\android\android-sdk\platform-tools", "Machine")
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
 
# Update Android SDK bits
android list sdk <# This lists out all the things to install.
You want to choose the marked items (x) next to the following for the next command:
x1- Android SDK Tools, revision 23
x2- Android SDK Platform-tools, revision 20
x3- Android SDK Build-tools, revision 19.1
 4- Documentation for Android SDK, API 19, revision 2
x5- SDK Platform Android 4.4.2, API 19, revision 3
 ...
Alternatively, you can just run "android" and use the GUI :)
#>
android update sdk --no-ui --filter "1,2,3,5,6,9,58,60" # You will need to enter "y[enter]" to accept the license terms
adb # Check this works
 
# Install nodejs
cinst nodejs.install -force
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
npm # Check this works

# Install virtualbox, GenyMotion, SourceTree
cinst virtualbox -force
cinst genymotion -force
cinst SourceTree -force
cinst Brackets -force

# Install Cordova
npm install -g cordova
cordova # Check this works
 
# Check everything works
cordova create helloworld
cd helloworld
cordova platform add android
cordova build
cd ..
 
# Install Phonegap (optional)
npm install -g phonegap
phonegap # Check this works
 
# Check everything works
phonegap create helloworld2
cd helloworld2
phonegap build android
cd ..

# Install bower
npm install -g bower --quiet

# Install ionic
npm install -g ionic --quiet

# Check everything works
bower