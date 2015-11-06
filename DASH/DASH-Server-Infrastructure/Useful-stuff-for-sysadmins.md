### Disk usage

`df -h` will tell about general disk usage

`du -sh [directory or file]` will give sum of disk usage for folder or file

`sudo /usr/sbin/lsof | grep deleted` check with lsof if there are files held open, space will not be freed until they are closed




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

