#!/bin/bash
#set -e
#=================================================================================
#Author: DemonKiller
#SPDX-License-Identifier: GPL-3.0
#Warning! DO NOT RUN THIS SCRIPT BLINDLY. MAKE CHANGES ACCORDING TO YOUR WORKFLOW.
#This script only needs to be run once on a machine.
#=================================================================================

set -e

git init
git config --global user.name "demonkiller2" #replace with your name
git config --global user.email "subhadravishwakarma8gris@gmail.com"
#git config --global user.email "enter your email address here" #replace string with mail
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple

echo "D O N E "
