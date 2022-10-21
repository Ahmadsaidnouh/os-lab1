#! /usr/bin/bash

RED='\e[1;31m'
NC='\e[0m' # No Color
numberOfArguments=$#
currentWorkingDir=$(pwd)
dir=""
backupDir=""
maxBackup=""

#########################################################################################################
# start utility functions
#########################################################################################################
function argumentsParsing() {
    if [ $numberOfArguments -lt 2 ]
    then
        echo -e "\n${RED}Error: must enter either two or three arguments!!!${NC}\n"
        exit 0;
    elif [ $numberOfArguments == 2 ]
    then
        dir=$1
        backupDir=~/cron-backups
        maxBackup=$2
    else 
        dir=$1
        backupDir=~/$2
        maxBackup=$3
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
    return $(cmp -s ~/.backup-cron-info/directory-info.new ~/.backup-cron-info/directory-info.past);
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
if [ $numberOfArguments == 2 ]
then
    argumentsParsing $1 $2
else
    argumentsParsing $1 $2 $3 
fi
#########################################################################################################
# end arguments parsing
#########################################################################################################
#
#
#
#
#########################################################################################################
# start main body
#########################################################################################################
ls -Rlr ~/$dir > ~/.backup-cron-info/directory-info.new; # update directory-info.new

isChangeOccured # call isChangeOccured function to check if directory-info.new == directory-info.past
isChangeOccuredRes=$? # store the output of isChangeOccured function in a variable

if [ $isChangeOccuredRes == 1 ]; then # change occured
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
    
    cp ~/.backup-cron-info/directory-info.new ~/.backup-cron-info/directory-info.past
    backupDirectory
fi
#########################################################################################################
# end main body
#########################################################################################################