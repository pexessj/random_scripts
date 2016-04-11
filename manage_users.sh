#!/bin/bash
#
# This script help us to manage Linux Users, Groups
#
# Created by: eu@matheuscarino.com.br
#

## Function create new user.

adduser(){
clear
echo "Enter the name of the new user."
read user
if [ ! "$user" ];
	then
		echo -en "\033[33;31m"
		clear
                echo -e "You need enter the user name"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
		return
fi
getent passwd | grep --quiet $user
if [ $? -eq 0 ]
        then
		echo -e "\033[33;31m"
		clear
                echo -e "The user $user already exists!"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 4
		return
        else
                echo "Creating the new user $user"
                sudo useradd $user --no-user-group -d /home/$user -s /bin/bash 2> /dev/null
fi
if [ $? -eq 0 ];
	then
		echo -e "\033[33;32m"
		clear
		echo "New user $user created successfully."
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
	else
		clear
		echo "Failed to create the new user $user."
		echo "Returning to the main menu..."
		sleep 5
fi
}

## Function create new group.

addgroup(){
clear
echo "Enter the name of the new group."
read group
if [ ! "$group" ];
	then
		echo -en "\033[33;31m"
		clear
                echo -e "You need enter the group name"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
		return
fi
getent group | grep --quiet $group
if [ $? -eq 0 ]
        then
		echo -e "\033[33;31m"
		clear
                echo -e "The group $group already exists!"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 4
		return
        else
                echo "Creating the new group $group"
                sudo groupadd $group 2> /dev/null
fi
if [ $? -eq 0 ];
	then
		echo -e "\033[33;32m"
		clear
		echo "New group $group created successfully."
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
	else
		clear
		echo "Failed to create the new group $group."
		echo "Returning to the main menu..."
		sleep 5
fi
}

## Function add user to a group.

addusergroup(){
clear
echo "Enter the name of the user."
read user
if [ ! "$user" ];
	then
		echo -en "\033[33;31m"
		clear
                echo -e "You need enter the user name"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
		return
fi
sudo getent passwd | grep --quiet $user
if [ $? -eq 1 ]
	then
		echo -en "\033[33;31m"
		clear
                echo -e "The user $user not exists."
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
		return
fi
echo "Enter the name of the group."
read group
if [ ! "$group" ];
	then
		echo -en "\033[33;31m"
		clear
                echo -e "You need enter the group name"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
		return
fi
sudo getent group | grep --quiet $group
if [ $? -eq 1 ]
	then
		echo -en "\033[33;31m"
		clear
                echo -e "The group $group not exists."
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
		return
fi
groups $user | grep --quiet $group
if [ $? -eq 0 ]
        then
		echo -e "\033[33;31m"
		clear
                echo -e "The user $user is already included in the group $group"
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 4
		return
        else
                echo "Adding user $user on group $group"
                sudo gpasswd -a $user $group 2> /dev/null
fi
if [ $? -eq 0 ];
	then
		echo -e "\033[33;32m"
		clear
		echo "The user $user was included in the $group group."
		echo -e '\e[0m'
		echo "Returning to the main menu..."
		sleep 5
	else
		clear
		echo "Failed to include the user $user in the group $group."
		echo "Returning to the main menu..."
		sleep 5
fi
}

## Function change user password.

#changepassword(){
#
#}


out(){
clear
exit
}

while : ; do

clear

echo -n "
--------------- USERS AND GROUPS ADMINISTRATION ------------------
1 - Create a new user
2 - Create a new group
3 - Add user to a group
4 - Change the password for a user
5 - Remove user
6 - Block a user
0 - Exit
Choose an option: "
read option
case "$option" in
1) adduser ;;
2) addgroup ;;
3) addusergroup ;;
4) changepassword ;;
5) deluser ;;
6) blockuser ;;
0) out

esac

done
