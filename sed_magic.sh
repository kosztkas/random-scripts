# uncomment specific line in the sudoers file with sed + create a backup of the file
sed -i.bkp 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
