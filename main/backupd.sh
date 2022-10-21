#! /usr/bin/bash

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
NC='\e[0m' # No Color
numberOfArguments=$#
currentWorkingDir=$(pwd)
dir=""
backupDir=""
interval=""
maxBackup=""

#########################################################################################################
# start utility functions
#########################################################################################################
function argumentsParsing() {
    if [ $numberOfArguments -lt 3 ]
    then
        echo -e "\n${RED}Error: must enter either three or four arguments!!!${NC}\n"
        exit 0;
    elif [ $numberOfArguments == 3 ]
    then
        dir=$1
        backupDir=~/backups
        interval=$2
        maxBackup=$3
    else 
        dir=$1
        backupDir=~/$2
        interval=$3
        maxBackup=$4
    fi
}
function destinationDirectoryValidation() {
    if [ $numberOfArguments == 3 ]
    then
        if [ -d $backupDir ] 
        then
            numberFiles=$(ls $backupDir | wc -l);
            if [ $numberFiles -gt 0 ]
            then
                echo -e "\n${YELLOW}The default destination directory contains old backups, are you sure you want to delete all these old backups? (y/n)${NC}"
                read userAns
                while true
                do
                    if [ -z $userAns ]
                    then
                        echo -e "${RED}Invalid input. Must enter (y/n)!!!${NC}"
                        read userAns
                    elif [ $userAns == "y" -o $userAns == "Y" ]
                    then
                        rm -rf $backupDir/*
                        break
                    elif [ $userAns == "n" -o $userAns == "N" ]
                    then
                        echo -e "${GREEN}\nProgram is terminated.${NC}\n"
                        exit 0;
                    else
                        echo -e "${RED}Invalid input. Must enter (y/n)!!!${NC}"
                        read userAns
                    fi
                done
            fi
        elif [ ! -d $backupDir ]
        then
            mkdir $backupDir
        fi
    fi
}
function backupDirectory() {
    currentDate=`date +"%Y-%m-%d-%H-%M-%S"`
    cd
    if [ ! -d $backupDir ]
    then
        mkdir $backupDir
    fi
    cd $currentWorkingDir
    cp -r ~/$dir "$backupDir/$currentDate";
}
function isChangeOccured() {
    return $(cmp -s ~/.backup-info/directory-info.new ~/.backup-info/directory-info.past);
}
#########################################################################################################
# end utility functions
#########################################################################################################
#
#
#
# 
#########################################################################################################
# start arguments parsing
#########################################################################################################
if [ numberOfArguments == 3 ]
then
    argumentsParsing $1 $2 $3
else
    argumentsParsing $1 $2 $3 $4
fi
#########################################################################################################
# end arguments parsing
#########################################################################################################
#
#
#
#
#########################################################################################################
# start destination directory validation
#########################################################################################################
destinationDirectoryValidation
#########################################################################################################
# end destination directory validation
#########################################################################################################
#
#
#
#
#########################################################################################################
# start main body
#########################################################################################################
# start main body
clear;
temp=~/$dir;
echo -e "${GREEN}System is backing up {${temp}} successfully into {${backupDir}}...${NC}"

rm -rf ~/.backup-info
mkdir ~/.backup-info

ls -Rlr ~/$dir > ~/.backup-info/directory-info.past
backupDirectory

while true
do
    sleep $interval
    ls -Rlr ~/$dir > ~/.backup-info/directory-info.new
    
    isChangeOccured
    isChangeOccuredRes=$?

    if [ $isChangeOccuredRes == 1 ]; then
        if [ -d $backupDir ]
        then
            numberFiles=$(ls $backupDir | wc -l);
        else
            numberFiles=0
        fi

        if [ $numberFiles -ge $maxBackup ]
        then
            for file in $backupDir/*
            do
                rm -r $file
                break
            done
        fi
        
        cp ~/.backup-info/directory-info.new ~/.backup-info/directory-info.past
        backupDirectory
    fi
done
#########################################################################################################
# end main body
#########################################################################################################