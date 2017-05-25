#!/bin/bash

#replace the list of random IPs with the desired list
#this script will ssh into each IP in the list, so that you can paste a command and run it
#it will ssh into the next host immediately after you exit from an ssh
#this is best for more drawn out processes, see multiple_ssh_command.sh for the execution of simple commands

USERNAME=hcadmin
HOSTS="172.27.219.113 172.27.56.238 172.27.219.191 172.27.56.188 172.27.56.176 172.27.56.62 172.27.56.60"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME}
done
