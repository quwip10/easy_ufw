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

printf "\nInteractive UFW \n"
sleep 1

#Checks for local file with preconfigured rules for automation
#I need to add this procedure later
#[insert code here]

#Loops through showing the ufw rule status
#Continues prompting user to enter rules until cont == 'n'
until [ $cont == 'n' ];
do
	printf "\nCurrent UFW Status:\n"
  printf "\nPress [enter] for next line\n"
  printf "Press [space] for next page\n"
  printf "Press q to exit status view\n \n"
  read -p "Press [enter] now to continue "

  #displays current ufw status/rules piped to less
	ufw status numbered | less

  #new rule prompts
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

  #prints variables for rule
	if [ -z "$protocol" ] && [ -z "$port" ];
	then
		printf "ufw allow from $source to $destination comment \"$comments \""
	elif [ -z $protocol ] && [ ! -z $port ];
	then
		printf "ufw allow from $source to $destination port $port comment \"$comments \""
	else
		printf "ufw allow from $source to $destination port $port proto $protocol comment \"$comments \""
	fi

  #Prompt to commit rule
  printf "Commit rule? (y/n)"
  read commit

  if [ $commit = 'y' ]
  then
    if [ -z "$protocol" ] && [ -z "$port" ];
    then
      ufw allow from $source to $destination comment \"$comments \"
    elif [ -z $protocol ] && [ ! -z $port ];
    then
      ufw allow from $source to $destination port $port comment \"$comments \"
    else
      ufw allow from $source to $destination port $port proto $protocol comment \"$comments \"
    fi
  fi

  #Prompts user to add another rule. Quits on no.
	printf "\nEnter another rule y/n? "
	read cont
	cont=${cont:0:1}
	cont=${cont,,}
	printf "\ncont = $cont \n"
	sleep 1
done
