#!/bin/bash
changeId() {
    if test "$1" -eq 1; then
        id='user'; database='passwd'; cmd='chown'
    else
        id='group'; database='group'; cmd='chgrp'
    fi

    read -rp "Enter the $id name: " idName
    if [ -z "$idName" ]; then
        exit 1
    fi
    if ! getent "$database" "$idName" &>/dev/null; then
        echo "${id^} $idName does not exist"
        createNewId "$1" "$idName" || return 1
    fi
  
    sudo "$cmd" "$idName" "$file" &>/dev/null
    echo "${id^} $idName is changed"
}
createNewId() {
    if test "$1" -eq 1; then
        id='user';  cmd='adduser'
    else
        id='group';  cmd='groupadd'
    fi 

    read -rp "Do you want create a new $1 $2 ? (y/n): " yn 
    if [[ $yn == @(y|yes) ]]; then
            sudo "$cmd" "$2" && echo "${id^} $2 create"
    else return 1
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
printf '%s\n' "1. Change user" "2. Change group" "q. Quit"
while true; do
	read -rp "What do you want to change the USER or GROUP: " choose
	case $choose in
	'') exit 1 ;;
	'1'|'2') changeId "$choose" ;;
    'q') exit 0 ;;
	*) echo 'Please, choose 1, 2 or leave empty.' ;;
	esac
done