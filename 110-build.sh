#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(F=$0; while [ ! -z $(readlink $F) ] && F=$(readlink $F); \
  cd $(dirname $F); F=$(basename $F); [ -L $F ]; do :; done; echo $(pwd -P))
for script in $SELF_DIR/0??-*.sh; do source $script; done

### halt on errors #############################################################

set -e

### preliminary checks #########################################################

if [ ! -d $SDKROOT ]; then
  echo "error: SDK not found: $SDKROOT"
  exit 1
fi

if [ -d $WRK_DIR ]; then
  echo "error: WRK_DIR exists: $WRK_DIR"
fi

### install iconv ##############################################################

get_source $URL_ICONV
configure_make_makeinstall

### install zlib ###############################################################

get_source $URL_ZLIB
configure_make_makeinstall

### install OpenSSL ############################################################

get_source $URL_OPENSSL

# OpenSSL needs special treatment to configure correctly for an alternate SDK.
./config --prefix=$OPT_DIR -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET

(
  unset MAKEFLAGS    # revoke multi-core compilation
  make_makeinstall
)

### install readline ###########################################################

get_source $URL_READLINE
configure_make_makeinstall

### install gettext ############################################################

get_source $URL_GETTEXT
configure_make_makeinstall "--without-emacs --disable-java --disable-native-java --disable-libasprintf --disable-csharp"

### install lzma ###############################################################

get_source $URL_XZUTILS
configure_make_makeinstall

### build Python ###############################################################

get_source $URL_PYTHON

(
  unset MAKEFLAGS    # revoke multi-core compilation
  export CFLAGS="$CFLAGS -I$SDKROOT/System/Library/Frameworks/Tk.framework/Versions/Current/Headers"
  configure_make_makeinstall "--enable-framework=$FRA_DIR --with-openssl=$OPT_DIR --enable-optimizations" "" "PYTHONAPPSDIR=$TMP_DIR"
  # speedup for testing purposes: without '--enable-optimizations'
  #configure_make_makeinstall "--enable-framework=$FRA_DIR --with-openssl=$OPT_DIR" "" "PYTHONAPPSDIR=$TMP_DIR"
)

### install Libxml2 ############################################################

get_source $URL_LIBXML2
configure_make_makeinstall "--with-python=$PY3_FRA_BIN_DIR/python$PY3_MAJOR"
