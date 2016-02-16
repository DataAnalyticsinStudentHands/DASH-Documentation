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

### Firewall-cmd open port 3000

    firewall-cmd --permanent --zone=public --add-port=3000/tcp
    firewall-cmd --reload
    firewall-cmd --permanent --list-all

### Links for Some services

[MariaDB](http://sharadchhetri.com/2014/07/31/install-mariadb-server-centos-7-rhel-7/)
