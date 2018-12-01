#!/bin/bash
#
# This checks to see if the user is a member of either staff or students and sets the dock accordingly.
# Set to the path of dockutil
dockutil="/usr/local/bin/dockutil"
# Determine user group membership via distinguishedName
GROUP=`dscl -plist /Active\ Directory/MVSD/All\ Domains -read /Users/$USER distinguishedName | xpath "//string[1]/text()" 2>/dev/null | rev | cut -d ',' -f 4 | rev | cut -d "=" -f 2`
#
if [ $GROUP == "Students" ]
then
	# Delete everything in dock
	${dockutil} --remove all --no-restart
	sleep 2
	# Add apps and links to network shares
	${dockutil} --add /Applications/Launchpad.app --no-restart
	${dockutil} --add /Applications/Safari.app --no-restart
	${dockutil} --add /Applications/Firefox.app --no-restart
	${dockutil} --add /Applications/Google\ Chrome.app --no-restart
	${dockutil} --add smb://svrnas02.mvsd.local/Sites/MS/MS%20Student%20Shares --label "MS Student Shares" --no-restart
elif [ $GROUP == "Staff" ]
then
	# Delete everything in dock
	${dockutil} --remove all --no-restart
	sleep 2
	# Add apps and links to network shares
	${dockutil} --add /Applications/Launchpad.app --no-restart
	${dockutil} --add /Applications/Safari.app --no-restart
	${dockutil} --add /Applications/Firefox.app --no-restart
	${dockutil} --add /Applications/Mail.app --no-restart
	${dockutil} --add /Applications/Calendar.app --no-restart
	${dockutil} --add /Applications/Google\ Chrome.app --no-restart
	${dockutil} --add /Applications/Microsoft\ Word.app --no-restart
	${dockutil} --add /Applications/Microsoft\ PowerPoint.app --no-restart
	${dockutil} --add /Applications/Microsoft\ Excel.app --no-restart
	${dockutil} --add /Applications/Sophos\ Endpoint.app --no-restart
	${dockutil} --add smb://svrnas02.mvsd.local/Sites/MS/MS%20STAFF --label "MS Staff" --no-restart
	${dockutil} --add smb://svrnas02.mvsd.local/Home/StaffHome/$USER --label $USER
fi
