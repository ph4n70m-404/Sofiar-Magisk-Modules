#Rom version code variables
EvoVersion="5.9"
XtendedVersion="7.0"
BlissVersion="14.5"
SparkVersion="vflare"
configfolder=/sdcard/sigspoof/
#download and install files needed
Install() {
  if [ -e "$MODPATH/temp/$rom.zip" ]; then
    echo "Files needed found"
  elif [ -e "$configfolder/$rom.zip" ]; then
    echo "Files needed found"
    mkdir -p $MODPATH/temp
    cp -R /$configfolder/$rom.zip /$MODPATH/temp
  else
    echo "Downloading files needed"
    mkdir -p $MODPATH/temp
    wget -P $MODPATH/temp https://github.com/ph4n70m-404/Sofiar-Magisk-Modules/raw/main/Sofiar-Sigspoof/temp/$rom.zip
  fi
  unzip -qq -d $MODPATH/temp $MODPATH/temp/$rom
  cp -R $MODPATH/temp/system $MODPATH
}
#check for the rom
RomCheck() {
  grep -iq "ro.build.flavor=evolution_sofiar-userdebug" /system/build.prop
  if [[ $? = 0 ]]; then
    echo "Installing for Evolution X $EvoVersion"
    export rom="evolution-x-$EvoVersion"
    Install
  else
    grep -iq "ro.build.flavor=xtended_sofiar-eng" /system/build.prop
    if [[ $? = 0 ]]; then
      echo "Installing for MSM Xtended XR $XtendedVersion"
      export rom="msm-xtended-xr-$XtendedVersion"
      Install
    else
      grep -iq "ro.build.flavor=bliss_sofiar-userdebug" /system/build.prop
      if [[ $? = 0 ]]; then
        echo "Installing for Bliss $BlissVersion"
        export rom="bliss-$BlissVersion"
        Install
      else
        grep -iq "ro.spark.version=Spark-$SparkVersion-sofiar" /system/build.prop
        if [[ $? = 0 ]]; then
          echo "Installing for Spark $SparkVersion"
          export rom="spark-$SparkVersion"
          Install
        else
          echo "You are using an unsupported rom"
          exit 1
        fi
      fi
    fi
  fi
}
#check for test zip then set the rom to the test zip
DebugMode() {
  if [ -e "$configfolder/test.zip" ]; then
    echo "Installing test zip"
    export rom="test"
    Install
  else
    echo "No test zip found, continuing with normal install"
    RomCheck
  fi
}
#make sure that the device is sofiar
grep -iq "ro.product.system.device=sofiar" /system/build.prop
if [[ $? = 0 ]]; then
  #look for debug file
  if [ -f "$configfolder/debug.txt" ]; then
    echo "Debug mode enabled"
    DebugMode
  else
    RomCheck
  fi
else
  echo "This magisk module is only for sofiar"
  exit 1
fi
#post install cleanup
rm -rf $MODPATH/temp
