#1. Install Java SDK (Standard Development Kit)

Check whether you have Java installed by opening a command line tool (cmd in Windows, Terminal in Mac OS) and type `java -version`. If it shows something like `java version "1.6.0_65"`
`Java(TM) SE Runtime Environment (build 1.6.0_65-b14-462-11M4609)`
`Java HotSpot(TM) 64-Bit Server VM (build 20.65-b04-462, mixed mode)` you are ok and don't have to install Java. Please move to step 2.

The JDK may be obtained from Oracle Corporation’s website using the [URL](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html).

Assuming that a suitable JDK is not already installed on your system, download the latest JDK package that matches the destination computer system. You need to select a package that fits your machine, e.g. jdk-8u5-macosx-x64.dmg if you are using a Mac. Once downloaded, launch the installation executable and follow the on screen instructions to complete the installation process. (It may already be installed - Mac, look under System Preferences, Java, then the update tab for version info)

## 2. Install MySQL and Tomcat
 You have two choices:   
A) Use the XAMPP distribution, [download](https://www.apachefriends.org/download.html)
- **(Mac Users)** XAMPP for Mac does not contain Tomcat, so it will need to be installed separately. See B).
- Follow the XAMPP installation wizard for a complete and usable installation of MySQL Database, Apache Web Server, and phpMyAdmin. All distributions are usable out-of-the-box.

B) Individual installation of the components

### Tomcat 7 on  Mac OSMavericks
Follow instructions [here](http://wolfpaulus.com/jounal/mac/tomcat7/)

### Tomcat 8 on Mac OS Yosemite
Follow instructions [here](http://wolfpaulus.com/jounal/mac/tomcat8/)

## 3. Install Eclipse Luna
Eclipse IDE for Java EE Developers [here](https://eclipse.org/downloads/)

Setup Tomcat inside Eclipse