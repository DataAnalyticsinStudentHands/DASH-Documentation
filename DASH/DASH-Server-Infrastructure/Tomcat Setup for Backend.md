## Tomcat 7 on HouSuggest

The Tomcat home directory is _/opt/tomcat7_ (this is actually just a symbolic link that points to /opt/apache-tomcat-7.0.53). Tomcat has been installed at service level and will restart when the system needs to reboot.

### Start/Stop/Restart

`service tomcat7 start` will start Tomcat  
`service tomcat7 stop` will stop Tomcat  
`service tomcat7 restart` will restart Tomcat  

### Installation notes

All done as _root_. Has to have distribution files for [[ANT|http://ant.apache.org/]], TOMCAT and LOG4J ready in _/opt_.

### Set some configuration variables

Replace with the downloaded _versions_ (the versions listed here are the ones currently installed on HouSuggest)  
`ANT_VERSION=1.9.3`  
`TOMCAT_VERSION=7.0.53`  
`LOG4J_VERSION=1.2.16`  

### Use the installed JDK
`export JAVA_HOME=/usr/java/default/`

### Create tomcat user
`groupadd tomcat`  
`useradd -r -G tomcat tomcat`

### Install Apache Ant
`cd /opt`  
`tar xfz apache-ant-$ANT_VERSION-bin.tar.gz`  
`rm apache-ant-$ANT_VERSION-bin.tar.gz`  
`ln -s apache-ant-$ANT_VERSION ant`  
`export ANT_HOME=/opt/ant`  
`export PATH=$ANT_HOME/bin:$PATH`  

### Install Tomcat & Create Symlink
`cd /opt`  
`tar xfz apache-tomcat-$TOMCAT_VERSION.tar.gz`  
`rm apache-tomcat-$TOMCAT_VERSION.tar.gz`  
`ln -s apache-tomcat-$TOMCAT_VERSION tomcat7`  

### Delete the default webapps
`rm -r /opt/tomcat7/webapps/*`

### Create the Java Service Control Binary
This is needed to daemonize Tomcat ...

`cd /opt/tomcat7/bin`  
`tar xfz commons-daemon-native.tar.gz  `  
`cd commons-daemon-1.*-native-src/unix`  
`./configure > configure.log`  
`make > make.log`  
`cp jsvc /opt/tomcat7/bin` 

### Create the APR Connector for native networking
`cd /opt/tomcat7/bin`  
`tar xfz tomcat-native.tar.gz`  
`cd tomcat-native-1.*-src/jni/native`  
`./configure --with-apr=/usr/bin/ > configure.log`  
`make > make.log`  
`cd ..`  
`ant > ant.log`  
`cp -r /opt/tomcat7/bin/tomcat-native-1.*-src/jni/native /opt/tomcat7/bin/`  


### Configure tomcat to use syslog for logging
See http://tomcat.apache.org/tomcat-7.0-doc/logging.html

Prerequisites: Copy _$TOMCAT_VERSION/bin/extras/tomcat-juli-adapters.jar_ and _$LOG4J_VERSION/log4j-$LOG4J_VERSION.jar_ into _/opt/tomcat7/lib/_

`cd /opt/tomcat7/bin`  
`rm tomcat-juli.jar`  
Copy _$TOMCAT_VERSION/bin/extras/tomcat-juli.jar_ into _/opt/tomcat7/bin_

Create a _log4j.properties_ file  in _/opt/tomcat7/lib/ _with the following content:


>log4j.rootLogger=INFO, SYSLOG

>log4j.appender.SYSLOG = org.apache.log4j.net.SyslogAppender
>log4j.appender.SYSLOG.syslogHost = 127.0.0.1
>log4j.appender.SYSLOG.layout = org.apache.log4j.PatternLayout
>log4j.appender.SYSLOG.layout.ConversionPattern = [tomcat] [%t] %-5p %c- %m%n
>log4j.appender.SYSLOG.Facility = LOCAL0

Last but not least ...  
`rm /opt/tomcat7/conf/logging.properties`

### Set Permissions for Tomcat
`chown -R root:tomcat /opt/tomcat7`  
`chown -R tomcat:tomcat /opt/tomcat7/conf`  
`find /opt/tomcat7 -type d | xargs chmod 750`  
`find /opt/tomcat7 -type f | xargs chmod 640`

### Add the filter to syslog ng
Add the following to _/etc/syslog-ng/syslog-ng.conf_

> #
> # Tomcat (Custom)
> #
> filter f_tomcat       { match('^\[tomcat\]'); };
> destination tomcat { file("/var/log/tomcat"); };
> log { source(src); filter(f_tomcat); destination(tomcat); };

`service syslog reload`

### Install Tomcat as system service
Create a file for  _/etc/init.d/tomcat7_ with the following content:



# Enable Tomcat at system start
echo "Enabling Tomcat Service"
chkconfig tomcat7 on
sleep 2

# Starting Tomcat
echo "Starting Tomcat"
service tomcat7 start

# Configure Tomcat To Support SSL/Https

in server.xml add:

    `<Connector SSLEnabled="true" clientAuth="false" keystoreFile="/path/to/certificate" keystorePass="***" maxThreads="150" port="8443" protocol="org.apache.coyote.http11.Http11Protocol" scheme="https" secure="true" sslProtocol="TLS"/>`

We are using a certificate from Comododo stored in the keystore.
    
