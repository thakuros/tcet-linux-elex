#!/bin/bash
#set -e
#=================================================================================
#Author: DemonKiller
#SPDX-License-Identifier: GPL-3.0
#Warning! DO NOT RUN THIS SCRIPT BLINDLY. MAKE CHANGES ACCORDING TO YOUR WORKFLOW.
#RUN AT YOUR OWN RISK.
#=================================================================================


echo
echo "################################################################## "
tput setaf 2
echo "Step 1 : "
echo "Setting General Parameters for TCET Linux"
tput sgr0
echo "################################################################## "
echo

    desktop="plasma"
    version="v1"
    iso_version="elex"
    isolabel="tcetlinux_'$iso_version'-x86_64.iso"

    build_folder="build/work/"
    iso_folder="build/out/"

    archisoVersion=$(sudo pacman -Q archiso)
    archisoRequiredVersion="archiso 53-1"

    echo "################################################################## "
	echo "Building the desktop                   : "$desktop
	echo "Building version                       : "$version
	echo "Iso label                              : "$isolabel
	echo "Do you have the right archiso version? : "$archisoVersion
	echo "What is the required archiso version?  : "$archisoRequiredVersion
	echo "################################################################## "

	if [ "$archisoVersion" == "$archisoRequiredVersion" ]; then
		tput setaf 2
		echo "##################################################################"
		echo "Archiso has the correct version. Continuing ..."
		echo "##################################################################"
		tput sgr0
	else
	tput setaf 1
	echo "###################################################################################################"
	echo "You need to install the correct version of Archiso"
	echo "Use 'sudo downgrade archiso' to do that"
	echo "or update your system"
	echo "###################################################################################################"
	tput sgr0
	exit 1
	fi

echo
echo "################################################################## "
tput setaf 2
echo "Step 2 : "
echo "Deleting old build folders"
tput sgr0
echo "################################################################## "
echo

    echo "Running the cleanup script"
    ./cleanup.sh

echo
echo "###########################################################"
tput setaf 2
echo "Step 3 :"
echo "- Cleaning the cache from /var/cache/pacman/pkg/"
tput sgr0
echo "###########################################################"
echo

	echo "Cleaning the cache from /var/cache/pacman/pkg/"
	yes | sudo pacman -Scc

echo
echo "################################################################## "
tput setaf 2
echo "Step 4 :"
echo "- Building the TCET Linux iso - this can take a while - be patient"
tput sgr0
echo "################################################################## "
echo

	cd ..
	mkdir build/work/
	mkdir build/out/
	sudo mkarchiso -v -w $build_folder -o $iso_folder makeiso

echo
echo "###################################################################"
tput setaf 2
echo "Step 5 :"
echo "- Creating checksums"
tput sgr0
echo "###################################################################"
echo

	cd $iso_folder

	echo "Creating checksums for : "$isoLabel
	echo "##################################################################"
	echo
	echo "Building sha1sum"
	echo "########################"
	sha1sum $isoLabel | tee $isoLabel.sha1
	echo "Building sha256sum"
	echo "########################"
	sha256sum $isoLabel | tee $isoLabel.sha256
	echo "Building md5sum"
	echo "########################"
	md5sum $isoLabel | tee $isoLabel.md5
	echo

echo "##################################################################"
tput setaf 2
echo "DONE"
echo "- Check your out folder :"$iso_folder
tput sgr0
echo "################################################################## "
echo
