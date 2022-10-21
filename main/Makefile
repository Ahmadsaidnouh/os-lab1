cron-backup:
	@chmod +x ./backupd.sh;
	@clear
	@RED='\e[1;31m'; \
	GREEN='\e[1;32m'; \
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
	read -p "===> Enter path of the backup destination directory (or leave it empty and press Enter to save to the default destination ~/backups) : " backupDir; \
	read -p "===> Enter interval in seconds : " interval; \
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
	if [ -z "$${interval}" ]; then \
	    echo "\n$${RED}Error: must enter interval in seconds!!!$${NC}\n"; \
        exit 0; \
	fi; \
	if [ "$${interval}" = "0" ]; then \
	    echo "\n$${RED}Error: interval must be an integer more than 0!!!$${NC}\n"; \
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
	digitsCount=$$(echo $$interval | grep -o [[:digit:]] | wc -l);\
	stringLength=$$(echo $$interval | wc -m); \
	stringLength=$$(( $$stringLength - 1 ));\
    if [ $$digitsCount -ne $$stringLength ]; then \
        echo "\n$${RED}Error: interval-sec must be an integer!!!\n"; \
        exit 0; \
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
	    ./backupd.sh $$dir $$interval $$maxBackup; \
	elif [ -d ~/$${backupDir} ]; then \
		if [ "$$dir" = "$$backupDir" ]; then \
			echo "\n$${RED}Error: can't backup a directory into itself!!!$${NC}\n"; \
		else \
			numberFiles=$$(ls ~/$$backupDir | wc -l); \
			if [ $$numberFiles -eq 0 ]; then \
				./backupd.sh $$dir $$backupDir $$interval $$maxBackup; \
			else \
				echo "\n$${RED}Error: can't backup to a non-empty destination directory (~/$${backupDir} is not empty)!!!$${NC}\n"; \
			fi; \
		fi; \
	else \
		mkdir ~/$$backupDir; \
		./backupd.sh $$dir $$backupDir $$interval $$maxBackup; \
	fi; \
	####################################################################################################################################################################### \
	# end main \
	####################################################################################################################################################################### \