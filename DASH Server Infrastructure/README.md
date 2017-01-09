<img src="assets/img/dash.png" width="100">

# DASH Backend Server Infrastructure

DASH is using a couple of virtual servers that are hosted on one server housed inside the RCC.

Here is how we should connect to them in our frontend/backend code base.

Type | Local | Development | Production
--- | --- | --- | ---
Frontend | localhost:8080 | http://hnetdev.hnet.uh.edu | http://housuggest.org
Backend | localhost:8100 | https://hnetdev.hnet.uh.edu:8443/ | https://housuggest.org:8443
Meteor | localhost:3000 | http://tcan.hnet.uh.edu:3000/ |

Here is the list virtual servers:

| Name    | DNS Name   | IP Address                 |
|-----------------|--------------|---------------------------|
| hnetdev     | hnetdev.hnet.uh.edu | 129.7.54.56 |
| _housuggest_     | dash.hnet.uh.edu | 129.7.54.58 |
| tcan (development)     | tcan.hnet.uh.edu | 129.7.54.63 |

All the virtual servers are running RedHat Enterprise Linux 7 (RHEL 7). There is a firewall on each server which is using [FirewallD](http://www.certdepot.net/rhel7-get-started-firewalld/). The host system is managed by RCC and our contact is Alan Pfeiffer-Traum. He also updates the virtual machines with security patches and can assist with issues related to the server software infrastructure.

We have a small collection of useful commands for [system administration]().

## Services

* PHP and Java
> java version "1.7.0_51"  
Java(TM) SE Runtime Environment (build 1.7.0_51-b13)  
Java HotSpot(TM) 64-Bit Server VM (build 24.51-b03, mixed mode)

* Webserver [[Apache|Apache]]
* Tomcat
* MariaDB (MySQL)

## Server Certificates

### 1. dash.hnet.uh.edu (Production)

We have installed a SSL server certificate for Tomcat to serve the SSL connections. The certificate is issued by [Comodo](https://www.namecheap.com/security/ssl-certificates/comodo/positivessl.aspx) and we managed it via an account at [namecheap](https://www.namecheap.com/). The account is associated with plindner[at]uh.edu and costs $10 per year. It has to be renewed in November.

Instructions for the installation can be found within the namecheap [documentation](https://www.namecheap.com/support/knowledgebase/article.aspx/9441/0/tomcat-using-keytool). To check the validity of the csr, you can use this [link](https://decoder.link/result/)

### 2. hnetdev.hnet.uh.edu (Development)

We have installed a SSL server certificate for Tomcat & Apache to serve the SSL connections. The certificate is managed via [letsencrypt](https://letsencrypt.org/) and we followed installation instructions at this [blog](https://digitz.org/blog/lets-encrypt-ssl-centos-7-setup/) as well as  [general](https://letsencrypt.org/howitworks/) instructions on their website. To import the certificate into a JKS keystore we followed instructions [here](https://community.letsencrypt.org/t/how-to-use-the-certificate-for-tomcat/3677/3) and used the following command.

`openssl pkcs12 -export -in cert.pem -inkey privkey.pem -out cert_and_key.p12 -name tomcat -CAfile chain.pem -caname root`

`keytool -importkeystore -deststorepass ***** -destkeypass ***** -destkeystore devkeystore.jks -srckeystore /etc/letsencrypt/live/hnetdev.hnet.uh.edu/pkcs.p12 -srcstoretype PKCS12 -srcstorepass ***** -alias *****`

`keytool -import -trustcacerts -alias root -file chain.pem -keystore devkeystore.jks`

Move the keystore into the tomcat configuration folder and restart Tomcat. The setup of the Tomcat server configuration file is the same as on the production server.
Note: Make sure the keystore password and the key password are the same.

The certifcate expires every 90 days. Just run `./letsencrypt-auto renew` for renewal and repeat the Tomcat configuration steps.

## Backup - only on dash.hnet.uh.edu

Since we run with a virtual machine and our code is in GitHub, we only backup the database files.

Backups are done on a daily basis and are dumped into _/var/backup_. Additional backups are done weekly and on the first day of the month. Backups are synced to the S3 storage using s3cmd. The script [runmysqlbackup](../blob/master/runmysqlbackup) is a wrapper around calls to tools for backup and sends emails. It can be configured with the [runmysqlbackup.conf](../blob/master/backup/runmysqlbackup.conf) which is self explaining. The script runs daily as a cron job by user _backup_.

`backup@ip-172-31-19-109:~> crontab -l`

> \# m h dom mon dow user command  
0 0 * * * /home/backup/runmysqlbackup

We made some changes to remove annoying warning message since MySQL 5.6
> if [[ -s "$log_errfile" ]]; then
sedtmpfile="/tmp/$(basename $0).$$.tmp"
grep -v "Warning: Using a password on the command line interface can be insecure." "$log_errfile" > $sedtmpfile
mv $sedtmpfile $log_errfile
fi

### MySQL
We use a tool [[automysqlbackup|http://sourceforge.net/projects/automysqlbackup/]] that is basically a wrapper for mysqldump. It can be configured with [automysqlbackup.conf](../blob/master/backup/automysqlbackup.conf) which is self explaining. The configration file needs to placed into _/etc/automysqlbackup/_.
