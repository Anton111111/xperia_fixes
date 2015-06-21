mount -o rw,remount /system 

originalPattern="ACDBID 545:2"
stringForReplace="ACDBID 528:2"

findNumLines=`grep -c "$originalPattern" /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3`
findLines=`grep -B 30 "$originalPattern" /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3`
checkName=`echo $findLines | grep -B 30 -c "Name \"Camcorder Stereo\""`

if [ $findNumLines = 0 ]; 
then
	echo "Pattern has not found. Seems like snd_soc_msm_2x_Fusion3 was already patched.";
	exit;
fi


if [ $findNumLines != 1 ]; 
then
	echo "Something wrong with check number of lines. Send the following output to author.";
	grep -A 20 -B 30 "$originalPattern" /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3
	exit;
fi

if [ $checkName != 1 ]; 
then
	echo "Something wrong with check name. Send the following output to author.";
	echo $findLines
	exit;
fi

echo "Make backup snd_soc_msm_2x_Fusion3 to snd_soc_msm_2x_Fusion3.bkp"

cp /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3  /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3.bkp &&
chmod 644 /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3.bkp &&

echo "Start fix"
sed s/"$originalPattern"/"$stringForReplace"/g /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3 >/system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3.new &&
chmod 644 /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3.new &&
rm /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3
mv /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3.new /system/etc/snd_soc_msm/snd_soc_msm_2x_Fusion3

echo "All done. You must reboot phone."
