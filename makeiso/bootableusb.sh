#Bootable USB Maker for TCET Linux
#!/bin/bash
#set -e
#=================================================================================
#Author: DemonKiller
#SPDX-License-Identifier: GPL-3.0
#=================================================================================
#Warning: Insert One USB at a time only. If you have any other USB either remove them from the system or change the script accordingly. Check size with lsblk (uncommment line 10 & 11).

tput setaf 2
echo "Welcome to Bootable USB Maker!"
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
cd out/
sudo dd if=tcetlinux-elex-$(date +%Y.%m)-x86_64.iso of=/dev/sdb status='progress'


echo "D O N E! Your USB should be bootable now, with TCET Linux."
echo "Thank YOU!"
