cd ..
cd makeiso/airootfs/etc/systemd/system/
tput setaf 2
echo "Enabling SDDM and Graphical Target.."
tput sgr0
ln -sv /usr/lib/systemd/system/graphical.target default.target

ln -sv /usr/lib/systemd/system/sddm.service display-manager.service

tput setaf 2
echo "Enabling Network Manager..."
tput sgr0
ln -sv /usr/lib/systemd/system/NetworkManager.service multi-user.target.wants/NetworkManager.service

ln -sv /usr/lib/systemd/system/NetworkManager-wait-online.service network-online.target.wants/NetworkManager-wait-online.service

ln -sv /usr/lib/systemd/system/NetworkManager-dispatcher.service dbus-org.freedesktop.nm-dispatcher.service
