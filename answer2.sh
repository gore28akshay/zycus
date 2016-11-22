#!/bin/bash
cat $1|sed s/,/\\n/g > hostname #Accept file name containing list of hosts and create file hostname with single host on each line.sed is used to seperate hostnames using delimiter ','
for i in `cat hostname` # for loop to display hostname and execute command via ssh on every host
do
echo "Hostname " $i #display hostname
ssh root@$i $2 # $2 is command
echo "####################################"
done

#execute above script using below command
# sh  shell_script.sh list_hostnames ls -l /root
# where
#        shell_script.sh is script
#        list_hostnames is file containing ',' seperated hostnames
#        ls -l /root is command to be executed 
