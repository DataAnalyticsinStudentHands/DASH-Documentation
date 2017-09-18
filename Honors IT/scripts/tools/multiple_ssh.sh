#!/bin/bash

#replace the list of lab computer IPs with the desired list
#this script will ssh into each IP in the list, so that you can paste a command and run it
#it will ssh into the next host immediately after you exit from an ssh
#this is best for more drawn out processes, see multiple_ssh_command.sh for the execution of simple commands

USERNAME=hcadmin
HOSTS="172.27.56.195 172.27.56.167 172.27.56.225 172.27.56.222 172.27.56.224 172.27.56.240 172.27.56.153 172.27.56.218 172.27.56.203 172.27.56.237 172.27.56.151 172.27.56.223 172.27.56.158 172.27.56.157 172.27.56.248 172.27.56.234"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}
done
