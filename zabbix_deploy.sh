#!/bin/bash

# Funcs impost
.  lib/funcs.sh  

# Colors

RED='\033[0;31m'
NC='\033[0m'

# Main menu text
printf "${RED}Preinst Menu${NC}\n"

PS3='Please enter your choice: '
options=("Install repo and zabbix" "Configure Zabbix Agent" "Enable, Start and Reload services" "" "Quit")

select opt in "${options[@]}"
do
    case $opt in
	"Install repo and zabbix")
	check_os 
            ;;
	"Configure Zabbix Agent")
	configure_zabbix	
	    ;;
	"Enable, Start and Reload services")
    start_and_reload_services
            ;;
	"")
            ;;
	"Quit")
            exit 0
            ;;
        *) echo invalid option;;
    esac
done
 
