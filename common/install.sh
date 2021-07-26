#making sure its a sofiar device then installing the proper version
grep -q "ro.product.system.device=sofiar" /system/build.prop
if [[ $? = 0 ]]; then
  grep -q "ro.build.flavor=evolution_sofiar-userdebug" /system/build.prop
  if [[ $? = 0 ]]; then
    echo "Installing for Evolution X"
    cp -R $MODPATH/temp/evolution/system $MODPATH
  else
    grep -q "ro.build.flavor=xtended_sofiar-eng" /system/build.prop
    if [[ $? = 0 ]]; then
      echo "Installing for MSM Xtended XR"
      cp -R $MODPATH/temp/xtended/system $MODPATH
    else
      echo "You are using an unsupported rom"
    fi
  fi
else
  echo "This module is only for sofiar"
fi
#post install cleanup
rm -rf $MODPATH/temp
