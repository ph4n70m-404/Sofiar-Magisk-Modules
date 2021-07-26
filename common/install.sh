evo="Evolution X 5.9"
xtended="MSM Xtended XR 7.0"
bliss="Bliss 14.5"
spark="Spark vFlare"
#download and install based on rom detection
Install() {
  mkdir $MODPATH/temp
  wget -P $MODPATH/temp https://github.com/ph4n70m-404/Sofiar-SigSpoof/releases/download/v3/$rom.zip
  unzip -qq -d $MODPATH/temp $MODPATH/temp/$rom
  cp -R $MODPATH/temp/system $MODPATH
}
#make sure that the device is sofiar and detect therom
grep -q "ro.product.system.device=sofiar" /system/build.prop
if [[ $? = 0 ]]; then
  grep -q "ro.build.flavor=evolution_sofiar-userdebug" /system/build.prop
  if [[ $? = 0 ]]; then
    echo "Installing for $evo"
    export rom="evolution-x"
    Install
  else
    grep -q "ro.build.flavor=xtended_sofiar-eng" /system/build.prop
    if [[ $? = 0 ]]; then
      echo "Installing for $xtended"
      export rom="msm-xtended-xr"
      Install
    else
      grep -q "ro.build.flavor=bliss_sofiar-userdebug" /system/build.prop
      if [[ $? = 0 ]]; then
        echo "Installing for $bliss"
        export rom="bliss-os"
        Install
      else
        grep -q "ro.build.flavor=spark_sofiar-userdebug" /system/build.prop
        if [[ $? = 0 ]]; then
          echo "Installing for $spark"
          export rom="spark-os"
          Install
        else
          echo "You are using an unsupported rom"
          exit 1
        fi
      fi
    fi
  fi
else
  echo "This module is only for sofiar"
  exit 1
fi
#post install cleanup
rm -rf $MODPATH/temp
