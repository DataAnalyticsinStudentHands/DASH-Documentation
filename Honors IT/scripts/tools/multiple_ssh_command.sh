#!/bin/bash

#replace the list of random IPs with the desired list
#replace "some command; another command" the desired command(s), separated by semicolon
#note that this script is not perfect and is best for simple commands. It may exit the ssh before a more involved process finishes

USERNAME=hcadmin
HOSTS="172.27.219.113 172.27.56.238 172.27.219.191 172.27.56.188 172.27.56.176 172.27.56.62 172.27.56.60"
SCRIPT="some command; sudo another command"
for HOSTNAME in ${HOSTS} ; do
    ssh -t -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done
