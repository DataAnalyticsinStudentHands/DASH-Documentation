### Disk usage

`df -h` will tell about general disk usage

`du -sh [directory or file]` will give sum of disk usage for folder or file

`sudo /usr/sbin/lsof | grep deleted` check with lsof if there are files held open, space will not be freed until they are closed

### Count number of files

To count the number of files recursively in the current and all directories below it, use:

`find . -type f | wc -l`


### Find out the size of tables


    SELECT TABLE_NAME AS "Table",
	round(((data_length + index_length) / 1024 / 1024), 2) AS Size_in_MB
    FROM information_schema.TABLES
    WHERE table_schema = 'ibreathedb'
    ORDER BY Size_in_MB DESC

### List open ports

    sudo netstat -lptu
    sudo netstat -tulpn

### CentOS Enforcing

All our virtualized servers are running RHEL. There are some specifics with permissions called [Enforcing](https://www.centos.org/docs/5/html/5.2/Deployment_Guide/sec-sel-enable-disable-enforcement.html)

We have to change the mode by running something like:
    `chcon unconfined_u:object_r:httpd_config_t:s0  /etc/httpd/conf/certs/uhcommunityhealth_org.ca-bundle`
    
Check status:
    `ls -Z`

### Firewall-cmd open/close port 3000

    firewall-cmd --permanent --zone=public --add-port=3000/tcp
    firewall-cmd --reload
    firewall-cmd --permanent --list-all
    
    $ firewall-cmd --zone=public --remove-port=3000/tcp
    $ firewall-cmd --runtime-to-permanent 
    $ firewall-cmd --reload 

### Setup system services

    `[root@www ~]# systemctl start rsyncd 
     [root@www ~]# systemctl enable rsyncd 
     [root@www ~]# systemctl list-units --type=service
     
     [root@www ~]# service service.name status`

[Read](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)

### Links for Some services

[MariaDB](http://sharadchhetri.com/2014/07/31/install-mariadb-server-centos-7-rhel-7/)
