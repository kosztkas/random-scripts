echo off
echo Name:
hostname
echo Status:
w32tm /query /status
echo Sync with host:
cd "C:\Program Files\VMware\VMware Tools\"
VMwareToolboxCmd.exe timesync status
echo --
