#!/bin/bash

#${BINARIES_DIR} is the directory of your image, and you will find a folder called rpi_firmware where you can find the config.txt 

#here this is a gaurd check if these lines already exists don't add them 
if [ ! `cat ${BINARIES_DIR}/rpi-firmware/config.txt | grep "dtparam=audio=on"` ]; then 

echo "#Enable soundcard" >> ${BINARIES_DIR}/rpi-firmware/config.txt
echo "dtparam=audio=on" >> ${BINARIES_DIR}/rpi-firmware/config.txt

fi

if [ ! `cat ${BINARIES_DIR}/rpi-firmware/config.txt | grep "uart_enable=1"` ]; then 

echo "#Enable Serial at boot time" >> ${BINARIES_DIR}/rpi-firmware/config.txt
echo "uart_enable=1" >> ${BINARIES_DIR}/rpi-firmware/config.txt

fi

#enable rootlogin in the sshd_config file 
echo "PasswordAuthentication yes" >> ${TARGET_DIR}/etc/ssh/sshd_config
echo "PermitRootLogin yes ">> ${TARGET_DIR}/etc/ssh/sshd_config


 
#THE PATH OF THIS FILE MUST BE ADDED IN THE MENUCONFIG TO BE EXECUTED 
