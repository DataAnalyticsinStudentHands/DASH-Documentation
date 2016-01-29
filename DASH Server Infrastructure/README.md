<img src="../assets/img/dash.png" width="100">

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

## Backup

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
