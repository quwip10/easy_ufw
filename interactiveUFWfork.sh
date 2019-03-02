#!/bin/bash

#Easy front end for enabling UFW on Virtual Servers

#Global variables
cont='y'

#Test for root priveleges
if [ $EUID -ne 0 ];
then
         printf "\nPlease run with sudo/root privileges. Exiting...\n\n"
         sleep 1
         exit
fi

printf "\nInteractive UFW Cool Stuff\n"

until [ $cont == 'n' ];
do
	printf "\nCurrent UFW Status:\n"
  printf "\nPress space for next page\n"
  printf "Press q to continue\n"
  read -p "Press [enter] to continue "

	ufw status numbered | less

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

	if [ -z "$protocol" ] && [ -z "$port" ];
	then
		printf "ufw allow from $source to $destination comment \"\'$comments \'\""
	elif [ -z $protocol ] && [ ! -z $port ];
	then
		printf "ufw allow from $source to $destination port $port comment \"\'$comments \'\""
	else
		printf "ufw allow from $source to $destination port $port proto $protocol comment \"\'$comments \'\""
	fi

	printf "\nEnter another rule y/n? "
	read cont
	cont=${cont:0:1}
	cont=${cont,,}
	printf "\ncont = $cont \n"
	sleep 1
done
