evo="Evolution X 5.9"
xtended="MSM Xtended XR 7.0"
bliss="Bliss 14.5"
spark="Spark vFlare"
configfolder=/sdcard/sigspoof/
#download and install files needed

Install() {
  if [ -e "$configfolder/$rom" ]; then
    echo "Files needed found"
    mkdir -p $MODPATH/temp
    cp -R /$configfolder/$rom /$MODPATH/temp
  elif [ -e "$MODPATH/temp/$rom" ]; then
    echo "Files needed found"
  else
    echo "Downloading files needed"
    mkdir $MODPATH/temp
    wget -P $MODPATH/temp https://github.com/ph4n70m-404/Sofiar-SigSpoof-Files/releases/download/1/$rom
  fi
  unzip -qq -d $MODPATH/temp $MODPATH/temp/$rom
  cp -R $MODPATH/temp/system $MODPATH
}
#check for the rom
RomCheck() {
  grep -q "ro.build.flavor=evolution_sofiar-userdebug" /system/build.prop
  if [[ $? = 0 ]]; then
    echo "Installing for $evo"
    export rom="evolution-x.zip"
    Install
  else
    grep -q "ro.build.flavor=xtended_sofiar-eng" /system/build.prop
    if [[ $? = 0 ]]; then
      echo "Installing for $xtended"
      export rom="msm-xtended-xr.zip"
      Install
    else
      grep -q "ro.build.flavor=bliss_sofiar-userdebug" /system/build.prop
      if [[ $? = 0 ]]; then
        echo "Installing for $bliss"
        export rom="bliss-os.zip"
        Install
      else
        grep -q "ro.build.flavor=spark_sofiar-userdebug" /system/build.prop
        if [[ $? = 0 ]]; then
          echo "Installing for $spark"
          export rom="spark-os.zip"
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
    echo "Installing test"
    export rom="test.zip"
    Install
  else
    echo "No test zip found, continuing with normal install"
    RomCheck
  fi
}
#make sure that the device is sofiar
grep -q "ro.product.system.device=sofiar" /system/build.prop
if [[ $? = 0 ]]; then
  #look for debug file
  if [ -f "$configfolder/debug.txt" ]; then
    echo "Debug mode enabled"
    DebugMode
  else
    RomCheck
  fi
else
  echo "This module is only for sofiar"
  exit 1
fi
#post install cleanup
rm -rf $MODPATH/temp
