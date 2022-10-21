cron-backup:
	@chmod +x ./backup-cron.sh;
	@clear
	@RED='\e[1;31m'; \
	GREEN='\e[1;32m'; \
	YELLOW='\e[1;33m'; \
	NC='\e[0m'; \
	currentWorkingDir=$$(pwd); \
	# \
	# \
	# \
	# \
	####################################################################################################################################################################### \
	# start reading user input \
	####################################################################################################################################################################### \
	read -p "===> Enter path of the directory to be backedup : " dir; \
	read -p "===> Enter path of the backup destination directory (or leave it empty and press Enter to save to the default destination ~/cron-backups) : " backupDir; \
	read -p "===> Enter max-backups : " maxBackup; \
	####################################################################################################################################################################### \
	# end reading user input \
	####################################################################################################################################################################### \
	# \
	# \
	# \
	# \
	####################################################################################################################################################################### \
	# start input validations \
	####################################################################################################################################################################### \
	if [ -z "$${dir}" ]; then \
	    echo "\n$${RED}Error: must enter path of directory to be backedup!!!$${NC}\n"; \
        exit 0; \
	fi; \
	if [ -z "$${maxBackup}" ]; then \
	    echo "\n$${RED}Error: must enter max-backups!!!$${NC}\n"; \
        exit 0; \
	fi; \
	if [ "$${maxBackup}" = "0" ]; then \
	    echo "\n$${RED}Error: max-backups must be an integer more than 0!!!$${NC}\n"; \
        exit 0; \
	fi; \
    cd ;\
    if [ ! -d $$dir ]; then \
        echo "\n$${RED}Error: no directory with path ~/$$dir to be backedup!!!$${NC}\n"; \
        exit 0;\
    fi; \
	digitsCount=$$(echo $$maxBackup | grep -o [[:digit:]] | wc -l); \
	stringLength=$$(echo $$maxBackup | wc -m); \
	stringLength=$$(( $$stringLength - 1 )); \
    if [ $$digitsCount -ne $$stringLength ]; then \
        echo "\n$${RED}Error: max-backups must be an integer!!!\n"; \
        exit 0; \
    fi; \
	#######################################################################################################################################################################	\
	# end input validations \
	#######################################################################################################################################################################	\
	# \
	# \
	# \
	# \
	#######################################################################################################################################################################	\
	# start main:																																							\
	# 																																										\
	# 6 cases for backup destination directory:- 																															\
	# 	cases1: default directory(~/cron-backups) and it's not exiting ==============> will create it then proceed directly. 												\
	# 	cases2: default directory(~/cron-backups) and it's exiting but empty ========> will proceed directly. 																\
	# 	cases3: default directory(~/cron-backups) and it's exiting but not empty ====> will firstly ask the user if he want to delete all existing files in ~/cron-backups. \
	# 	cases4: user specified directory and it's not existing ======================> will create it then proceed directly. 												\
	# 	cases5: user specified directory and it's existing but empty ================> will proceed directly. 																\
	# 	cases6: user specified directory and it's existing but not empty ============> will display error message and then terminate execution without any deletion. 		\
	#######################################################################################################################################################################	\
	cd $$currentWorkingDir;\
	if [ -z "$$backupDir" ]; then \
        if [ -d ~/cron-backups ]; then \
			numberFiles=$$(ls ~/cron-backups | wc -l); \
			if [ $$numberFiles -gt 0 ]; then \
            	echo "\n$${YELLOW}The default destination directory contains old backups, are you sure you want to delete all these old backups? (y/n)$${NC}"; \
            	read userAns; \
            	while true; \
            	do\
            	    if [ -z $$userAns ]; then \
            	        echo "$${RED}Invalid input. Must enter (y/n)!!!$${NC}"; \
            	        read userAns; \
            	    elif [ $$userAns = "y" ] || [ $$userAns = "Y" ]; then \
            	        rm -rf ~/cron-backups/*; \
            	        break ;\
            	    elif [ $$userAns = "n" ] || [ $$userAns = "N" ]; then \
            	        echo  "$${GREEN}\nProgram is terminated.$${NC}\n"; \
            	        exit 0; \
            	    else \
            	        echo  "$${RED}Invalid input. Must enter (y/n)!!!$${NC}"; \
            	        read userAns; \
            	    fi; \
            	done; \
			fi; \
        elif [ ! -d ~/cron-backups ]; then \
            mkdir ~/cron-backups; \
        fi; \
		temp1=~/$$dir; \
		temp2=~/cron-backups; \
		rm -rf ~/.backup-cron-info; \
		mkdir ~/.backup-cron-info; \
		ls -Rlr ~/$$dir > ~/.backup-cron-info/directory-info.past; \
		currentDate=`date +"%Y-%m-%d-%H-%M-%S"`; \
		cd; \
		if [ ! -d ~/cron-backups ]; then \
		    mkdir ~/cron-backups; \
		fi; \
		cd $$currentWorkingDir; \
		cp -r ~/$$dir ~/cron-backups/$$currentDate;\
		crontab -l > cron_content; \
		echo "*/1 * * * * /bin/bash $${currentWorkingDir}/backup-cron.sh $$dir $$maxBackup" >> cron_content; \
		crontab cron_content; \
		rm cron_content; \
		clear; \
		echo "$${GREEN}Cron job installed successfully. System is backing up {$${temp1}} into {$${temp2}}...\n$${NC}"; \
	elif [ -d ~/$${backupDir} ]; then \
		if [ "$$dir" = "$$backupDir" ]; then \
			echo "\n$${RED}Error: can't backup a directory into itself!!!$${NC}\n"; \
		else \
			numberFiles=$$(ls ~/$$backupDir | wc -l); \
			if [ $$numberFiles -eq 0 ]; then \
				temp1=~/$$dir; \
				temp2=~/$$backupDir; \
				rm -rf ~/.backup-cron-info; \
				mkdir ~/.backup-cron-info; \
				ls -Rlr ~/$$dir > ~/.backup-cron-info/directory-info.past; \
				currentDate=`date +"%Y-%m-%d-%H-%M-%S"`; \
				cd; \
				if [ ! -d ~/$$backupDir ]; then \
				    mkdir ~/$$backupDir; \
				fi; \
				cd $$currentWorkingDir; \
				cp -r ~/$$dir ~/$$backupDir/$$currentDate;\
				crontab -l > cron_content; \
				echo "*/1 * * * * /bin/bash $${currentWorkingDir}/backup-cron.sh $$dir $$backupDir $$maxBackup" >> cron_content; \
				crontab cron_content; \
				rm cron_content; \
				clear; \
				echo "$${GREEN}Cron job installed successfully. System is backing up {$${temp1}} into {$${temp2}}...\n$${NC}"; \
			else \
				echo "\n$${RED}Error: can't backup to a non-empty destination directory (~/$${backupDir} is not empty)!!!$${NC}\n"; \
			fi; \
		fi; \
	else \
		mkdir ~/$$backupDir; \
		temp1=~/$$dir; \
		temp2=~/$$backupDir; \
		rm -rf ~/.backup-cron-info; \
		mkdir ~/.backup-cron-info; \
		ls -Rlr ~/$$dir > ~/.backup-cron-info/directory-info.past; \
		currentDate=`date +"%Y-%m-%d-%H-%M-%S"`; \
		cd; \
		if [ ! -d ~/$$backupDir ]; then \
		    mkdir ~/$$backupDir; \
		fi; \
		cd $$currentWorkingDir; \
		cp -r ~/$$dir ~/$$backupDir/$$currentDate;\
		crontab -l > cron_content; \
		echo "*/1 * * * * /bin/bash $${currentWorkingDir}/backup-cron.sh $$dir $$backupDir $$maxBackup" >> cron_content; \
		crontab cron_content; \
		rm cron_content; \
		clear; \
		echo "$${GREEN}Cron job installed successfully. System is backing up {$${temp1}} into {$${temp2}}...\n$${NC}"; \
	fi; \
	####################################################################################################################################################################### \
	# end main \
	####################################################################################################################################################################### \