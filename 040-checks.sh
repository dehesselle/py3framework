# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### check if WRK_DIR is usable #################################################

if  [ $(mkdir -p $WRK_DIR 2>/dev/null; echo $?) -eq 0 ] &&
    [ -w $WRK_DIR ] ; then
  : # WRK_DIR has been created or was already there and is writable
else
  echo_e "WRK_DIR not usable: $WRK_DIR"
  exit 1
fi

### check if SDK present #######################################################

if [ ! -f $SDKROOT/SDKSettings.plist ]; then
  echo_e "SDK not found: $SDKROOT"
  exit 1
fi
