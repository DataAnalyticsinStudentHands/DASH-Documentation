# DASH backend infrastructure

We refer commonly to our backend infrastructure as _housuggest_ server. This server runs on a AWS EC2 instance (Amazon Cloud). The instance uses a SUSE Linux Enterprise Server 11 distribution ([SLES11](https://www.suse.com/documentation/sles11/)). We are using IAM for key management (instructions can be found [[here|http://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingCredentials.html#Using_CreateAccessKey]]).

## Tools for AWS

Create Access Key and Secret Key for an admin user (_plindner`_) and _backup_ through our S3 Amazon account. Create user policy to access S3 buckets and bucket policy! We followed instructions on the AWS [[documentation|http://docs.aws.amazon.com/AmazonS3/latest/dev/example-walkthroughs-managing-access-example1.html]] page. The credentials created for user _backup_ have be used for the configuration of the AWS CLI and s3cmd.

### AWS CLI
First install [[pip|http://www.pip-installer.org/en/latest/index.html]] as install tool for aws. Then  
`pip install awscli`  
`aws configure`

### s3cmd
`# http://s3tools.org/repo/SLE_11/s3tools.repo`  
`# zypper install s3cmd`

Configure s3cmd Environment

`# s3cmd --configure`

## Services

Most of the services require PHP and Java. We installed [[Orcale Java|http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html]] as rpm through the command line. 

> java version "1.7.0_51"  
Java(TM) SE Runtime Environment (build 1.7.0_51-b13)  
Java HotSpot(TM) 64-Bit Server VM (build 24.51-b03, mixed mode)

PHP has been installed through YAST. 


We have installed the following services:
* Webserver [[Apache|Apache]] 

We are using the built in version of Apache 2.2 that came with SLES 11. The manual can be accessed here. Configuration is done via YAST.

The html document root is currently under /srv/www/htdocs
* Servlet Engine Apache [[Tomcat 7|Tomcat]] version 7.0.53

## Backup

Backups are done on a daily basis and are dumped into _/var/backup_. Additional backups are done weekly and on the first day of the month. Backups are synced to the S3 storage using s3cmd. The script [runmysqlbackup](../blob/master/runmysqlbackup) is a wrapper around calls to tools for backup and sends emails. It can be configured with the [runmysqlbackup.conf](../blob/master/backup/runmysqlbackup.conf) which is self explaining. The script runs daily as a cron job by user _backup_.

`backup@ip-172-31-19-109:~> crontab -l`

> \# m h dom mon dow user command  
0 0 * * * /home/backup/runmysqlbackup

### MySQL
We use a tool [[automysqlbackup|http://sourceforge.net/projects/automysqlbackup/]] that is basically a wrapper for mysqldump. It can be configured with [automysqlbackup.conf](../blob/master/backup/automysqlbackup.conf) which is self explaining. The configration file needs to placed into _/etc/automysqlbackup/_.