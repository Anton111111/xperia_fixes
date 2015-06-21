adb push ./video_fix.sh /sdcard1/video_fix.sh &&
adb shell su -c "chmod 755 /sdcard1/video_fix.sh" &&
adb shell su -c "sh /sdcard1/video_fix.sh" &&
adb shell su -c "rm -f /sdcard1/video_fix.sh" 

