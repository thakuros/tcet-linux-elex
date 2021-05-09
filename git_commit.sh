#!/bin/bash
#set -e
#=================================================================================
#Author: DemonKiller
#SPDX-License-Identifier: GPL-3.0
#Warning! DO NOT RUN THIS SCRIPT BLINDLY. MAKE CHANGES ACCORDING TO YOUR WORKFLOW.
#RUN AT YOUR OWN RISK.
#=================================================================================

#Pull all files from online git repo
echo "Checking for newer files online first"
git pull

#Backup to local project directry
git add --all .

# Commit Comment
echo "####################################"
echo "Write your commit comment!"
echo "####################################"

read input

# Committing to the local repository with a message containing the time details and commit text
git commit -m "$input"

# Push the local files to github
git push

echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
