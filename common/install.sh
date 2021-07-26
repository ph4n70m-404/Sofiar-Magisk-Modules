#making sure its a sofiar device then installing the proper version
grep -q "ro.product.system.device=sofiar" /system/build.prop
if [[ $? = 0 ]]; then
  grep -q "ro.build.flavor=evolution_sofiar-userdebug" /system/build.prop
  if [[ $? = 0 ]]; then
    echo "Installing for Evolution X 5.9"
    cp -R $MODPATH/temp/evolution/system $MODPATH
  else
    grep -q "ro.build.flavor=xtended_sofiar-eng" /system/build.prop
    if [[ $? = 0 ]]; then
      echo "Installing for MSM Xtended XR 7.0"
      cp -R $MODPATH/temp/xtended/system $MODPATH
    else
      grep -q "ro.build.flavor=bliss_sofiar-userdebug" /system/build.prop
      if [[ $? = 0 ]]; then
        echo "Installing for Bliss 14.5"
        cp -R $MODPATH/temp/bliss/system $MODPATH
      else
        grep -q "ro.build.flavor=spark_sofiar-userdebug" /system/build.prop
        if [[ $? = 0 ]]; then
          echo "Installing for Spark vFlare"
          cp -R $MODPATH/temp/spark/system $MODPATH
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
