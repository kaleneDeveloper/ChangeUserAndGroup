#!/bin/bash
changeId() {
if [ "$1" = 1 ]; then
        read -rp "Enter the group user name: " changeUser
        if [ -z "$changeUser" ]; then
            exit 1
        fi
    while true; do
        if getent passwd "$changeUser" &>/dev/null; then
            sudo chown "$changeUser" "$file"
            echo "User $changeUser is changed"
            break
        else
            echo "User $changeUser does not exist"
            createNewId "$@"
            break
        fi
    done
fi
if [ "$1" = 2 ]; then
        read -rp "Enter the group name: " changeGroup
        if [ -z "$changeGroup" ]; then
            exit 1
        fi
    while true; do
        if getent group "$changeGroup" &>/dev/null; then
            sudo chgrp "$changeGroup" "$file" 
            echo "Group $changeGroup is changed"
            break
        else
            echo "Group $changeGroup does not exist"
            createNewId "$@"
            break
        fi
    done
fi
}
createNewId() {
if [ "$1" = 1 ]; then
    while true; do
        read -rp "Do you want create a new user $changeUser ? (y/n): " yn
        if [[ $yn == @(y|yes) ]]; then
                sudo adduser "$changeUser"
                echo "User $changeUser create"
                break
        elif [[ $yn == @(n|no) ]]; then break
        else break
        fi    
    done
fi
if [ "$1" = 2 ]; then
    while true; do
        read -rp "Do you want create a new group $changeGroup ? (y/n): " yn
        if [[ $yn == @(y|yes) ]]; then
                sudo groupadd "$changeGroup" 
                echo "Group $changeGroup create"
                break 
        elif [[ $yn == @(n|no) ]]; then break 
        else break      
        fi
    done
fi
}
while true; do
    read -rp "Enter the name of the file to change: " file
    if [ -z "$file" ]; then
        echo "Insert file pls."
    elif [ -f "$file" ]; then
        echo "$file selected."
        break
    else 
        echo "$file file not found."    
    fi
done
echo "1. Change user"
echo "2. Change group"
while true; do
	read -rp "What do you want to change the USER or GROUP: " choose
	case $choose in
	'') exit 1 ;;
	'1'|'2') changeId "$choose" ;;
	*) echo 'Please, choose 1, 2 or leave empty.' ;;
	esac
done