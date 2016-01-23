#!/bin/bash
# Script Name: AtoMiC Sick Beard Updater
# Author: htpcBeginner
# Publisher: http://www.htpcBeginner.com
# License: MIT License (refer to README.md for more details)
#

# DO NOT EDIT ANYTHING UNLESS YOU KNOW WHAT YOU ARE DOING.

if [[ $1 != *"setup.sh"* ]]
then
  echo
  echo -e '\e[91mCannot be run directly. Please run setup.sh from AtoMiC ToolKit root folder: \033[0msudo bash setup.sh'
  echo
  exit 0
fi

source $2/inc/commons.sh
source $SCRIPTPATH/inc/header.sh

echo -e $GREEN'AtoMiC Sick Beard Manual Update Script'$ENDCOLOR

source $SCRIPTPATH/inc/pause.sh

if [ ! -d "/home/$UNAME/.sickbeard" ]; 
then
	echo -e $RED'Error! '$CYAN'/home/'$UNAME/'.sickbeard'$RED' not found. Sick Beard not installed or incompatible installation.'$ENDCOLOR
	source $SCRIPTPATH/inc/exit.sh
fi

echo -e $YELLOW'--->Installing prerequisites...'$ENDCOLOR
sudo apt-get -y install git-core

echo
sleep 1

echo -e $YELLOW'--->Stopping Sick Beard...'$ENDCOLOR
sudo /etc/init.d/sickbeard stop >/dev/null 2>&1

echo
sleep 1

echo -e $YELLOW'--->Stashing any changes made to Sick Beard...'$ENDCOLOR
cd /home/$UNAME/.sickbeard
source $SCRIPTPATH/inc/gitstash.sh

echo
sleep 1

echo -e $YELLOW'--->Manually updating Sick Beard...'$ENDCOLOR
git fetch --all
git pull

echo
sleep 1

echo -e $YELLOW'--->Restarting Sick Beard...'$ENDCOLOR
/etc/init.d/sickbeard start

echo
echo -e $GREEN'--->All done. '$ENDCOLOR
echo -e 'Sick Beard should start within 10-20 seconds and your browser should open.'
echo -e 'If not you can start it using '$CYAN'/etc/init.d/sickbeard start'$ENDCOLOR' command.'

source $SCRIPTPATH/inc/thankyou.sh
source $SCRIPTPATH/inc/exit.sh