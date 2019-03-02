#!/bin/bash

#Easy front end for enabling UFW on Virtual Servers

#Test for root priveleges
if [ $EUID -ne 0 ];
then
         printf "\nPlease run with sudo/root priveleges. Exiting...\n\n"
         sleep 1
         exit
fi

printf "Interactive UFW Cool Stuff\n"

printf "\nCurrent UFW Status:\n"
ufw status numbered
sleep 2

printf "\nEnter Source address or leave blank for any: "
read source

if [ -z "$source" ];
then
	source="any"
fi

printf "\nEnter Destination address or leave blank for any: "
read destination

if [ -z "$destination" ];
then
	destination="any"
fi

printf "\nEnter port or leave blank for any: "
read port

printf "\nEnter protocol tcp/udp or leave blank for any: "
read protocol

printf "\nEnter any comments or leave blank: "
read comments

if [ -z $protocol ] && [ -z $port];
then
	printf "ufw allow from $source to $destination comment \"\'$comments \'\""
elif [ -z $protocol ] && [ ! -z port ];
then
	printf "ufw allow from $source to $destination port $port comment \"\'$comments \'\""
fi
