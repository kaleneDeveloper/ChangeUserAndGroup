#!/bin/bash
changeId() {
changeUser(){
        read -rp "Enter the name of the new user: " changeUser
        if [ -z "$changeUser" ]; then
            exit 1
        fi
    while true; do
        if getent passwd "$changeUser"; then
            sudo chown "$changeUser" "$file"
            echo "User $changeUser is changed"
            break
        else
            echo "User $changeUser does not exist"
            createNewId
            break
        fi
    done
}
changeGroup(){
        read -rp "Enter the name of the new group: " changeGroup
        if [ -z "$changeGroup" ]; then
            exit 1
        fi
    while true; do
        if getent group "$changeGroup"; then
            sudo chgrp "$changeGroup" "$file"
            echo "Group $changeGroup is changed"
            break
        else
            echo "Group $changeGroup does not exist"
            createNewId
            break
        fi
    done
}
}
createNewId() {
    createNewUser() {
    while true; do
        read -rp "Do you want create a new user $1 ? (y/n): " yn
        if [[ $yn == @(y|yes) ]]; then
                sudo adduser "$1"
                echo "User $1 create"
                break
        elif [[ $yn == @(n|no) ]]; then break
        else break
        fi    
    done
}
createNewGroup() {
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
}
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
echo "1. Add user"
echo "2. Group user"
while true; do
	read -rp "Do you want add USER or GROUP: " choose
	case $choose in
	'') exit 1 ;;
	'1'|'2') changeId "$choose" ;;
	*) echo 'Please, choose 1, 2 or leave empty.' ;;
	esac
done