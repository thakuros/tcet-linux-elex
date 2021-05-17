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
    isolabel="tcetlinux_$iso_version-x86_64.iso"

    build_folder="iso_build/work/"
    iso_folder="iso_build/out/"

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
	mkdir iso_build/
	mkdir iso_build/work/
	mkdir iso_build/out/
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

	echo "Creating checksums for : "$isolabel
	echo "##################################################################"
	echo
	echo "Building sha1sum"
	echo "########################"
	sha1sum $isolabel | tee $isolabel.sha1
	echo "Building sha256sum"
	echo "########################"
	sha256sum $isolabel | tee $isolabel.sha256
	echo "Building md5sum"
	echo "########################"
	md5sum $isolabel | tee $isolabel.md5
	echo
	echo "Moving pkglist.x86_64.txt"
	echo "########################"
	cp $build_folder/iso/arch/pkglist.x86_64.txt  $iso_folder/$isolabel".pkglist.txt"


echo
echo "###################################################################"
tput setaf 2
echo "Step 6 :"
echo "- Creating Bootable USB"
tput sgr0
echo "###################################################################"
echo

    echo "Do you want to create a bootable USB? [y/n]"
    read answer
    yes="y"
    if [ "$answer" == "$yes" ];
    then
        echo "We are making TCET Linux Bootable USB, please wait..."
        echo "                               "
        tput sgr0

        #echo "Printing Partitions in Drive:"
        #lsblk

        echo "unmounting drive..."
        umount /dev/sdb*

        echo "Checking for any mounted partitions & unmounting them...."
        umount /dev/sdb*

        echo "==========================================================="
        tput setaf 1
        echo "Formatting with ext4.."
        tput sgr0
        sudo mkfs.ext4 /dev/sdb

        tput setaf 2
        echo "USB is Formatted.."
        tput sgr0

        echo "                                                           "
        echo "==========================================================="
        echo "Making TCET Linux bootable USB, this may take sometime...."
        cd ..
        cd iso_build/out/
        sudo dd if=tcetlinux_elex-$(date +%Y.%m)-x86_64.iso of=/dev/sdb status='progress'


        echo "D O N E! Your USB should be bootable now, with TCET Linux."
        echo "Thank YOU!"
    else
        continue
    fi

echo "##################################################################"
tput setaf 2
echo "DONE"
echo "- Check your out folder :"$iso_folder
tput sgr0
echo "################################################################## "
echo
