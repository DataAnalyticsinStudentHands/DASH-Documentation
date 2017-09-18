#!/bin/bash

#replace the list of lab computer IPs with the desired list
#replace "some command; another command" the desired command(s), separated by semicolon
#note that this script is not perfect and is best for simple commands. It may exit the ssh before a more involved process finishes

USERNAME=hcadmin
HOSTS="172.27.56.195 172.27.56.167 172.27.56.225 172.27.56.222 172.27.56.224 172.27.56.240 172.27.56.153 172.27.56.218 172.27.56.203 172.27.56.237 172.27.56.151 172.27.56.223 172.27.56.158 172.27.56.157 172.27.56.248 172.27.56.234"
SCRIPT="some command; sudo another command"
for HOSTNAME in ${HOSTS} ; do
    ssh -t -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done
