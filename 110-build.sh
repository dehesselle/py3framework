#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(F=$0; while [ ! -z $(readlink $F) ] && F=$(readlink $F); \
  cd $(dirname $F); F=$(basename $F); [ -L $F ]; do :; done; echo $(pwd -P))
for script in $SELF_DIR/0??-*.sh; do source $script; done

include_file echo_.sh
include_file error_.sh

### halt on errors #############################################################

error_trace_enable

### preliminary checks #########################################################

if [ ! -d $SDKROOT ]; then
  echo_e "SDK not found: $SDKROOT"
  exit 1
fi

if [ -d $WRK_DIR ]; then
  echo_e "WRK_DIR exists: $WRK_DIR"
  exit 1
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
configure_make_makeinstall "\
  --disable-csharp\
  --without-emacs\
  --disable-java\
  --disable-libasprintf\
  --disable-native-java\
"

### install lzma ###############################################################

get_source $URL_XZUTILS
configure_make_makeinstall

### build Python ###############################################################

get_source $URL_PYTHON

# Apply any patches if present.
for patch in $SELF_DIR/*.patch; do
  patch -p1 < $patch
done

(
  unset MAKEFLAGS    # revoke multi-core compilation
  export CFLAGS="\
    $CFLAGS \
    -I$SDKROOT/System/Library/Frameworks/Tk.framework/Versions/Current/Headers\
  "
  configure_make_makeinstall "\
    --enable-framework=$FRA_DIR\
    --with-openssl=$OPT_DIR\
    --enable-optimizations\
    " "" "PYTHONAPPSDIR=$TMP_DIR"

  # speedup for testing purposes: remove '--enable-optimizations'
)

### install Libxml2 ############################################################

get_source $URL_LIBXML2

(
  export PATH=$PY3_FRA_BIN_DIR:$PATH   # so libxml2 finds python3.8-config
  configure_make_makeinstall "--with-python=$PY3_FRA_BIN_DIR/python$PY3_MAJOR"
)
