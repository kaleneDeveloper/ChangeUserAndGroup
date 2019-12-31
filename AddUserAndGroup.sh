#!/bin/bash
createNewUser() {
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
}
checkIfUserExist() {
getent passwd "$changeUser" &>/dev/null
}
changeUser(){
        read -rp "Enter the name of the new user: " changeUser
        if [ -z "$changeUser" ]; then
            exit 1
        fi
    while true; do
        if checkIfUserExist; then
            sudo chown "$changeUser" "$file"
            echo "User $changeUser is changed"
            break
        else
            echo "User $changeUser does not exist"
            createNewUser
            break
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
checkIfGroupExist() {
getent passwd "$changeGroup" &>/dev/null
}
changeGroup(){
        read -rp "Enter the name of the new group: " changeGroup
        if [ -z "$changeGroup" ]; then
            exit 1
        fi
    while true; do
        if checkIfGroupExist; then
            sudo chgrp "$changeGroup" "$file"
            echo "Group $changeGroup is changed"
            break
        else
            echo "Group $changeGroup does not exist"
            createNewGroup
            break
        fi
    done
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
    if [ -z "$choose" ]; then
        exit 1
    elif [ "$choose" = "1" ] || [ "$choose" = "2" ]; then
        case $choose in
            "1") changeUser "$@";;
            "2") changeGroup "$@";;
        esac
    fi
done