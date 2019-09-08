#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(F=$0; while [ ! -z $(readlink $F) ] && F=$(readlink $F); \
  cd $(dirname $F); F=$(basename $F); [ -L $F ]; do :; done; echo $(pwd -P))
for script in $SELF_DIR/0??-*.sh; do source $script; done

### halt on errors #############################################################

set -e

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
configure_make_makeinstall --without-emacs --disable-java --disable-native-java --disable-libasprintf --disable-csharp

### install lzma ###############################################################

get_source $URL_XZUTILS
configure_make_makeinstall

### build Python ###############################################################

get_source $URL_PYTHON

(
  unset MAKEFLAGS    # revoke multi-core compilation
  export CFLAGS="$CFLAGS -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$MACOSX_DEPLOYMENT_TARGET.sdk/System/Library/Frameworks/Tk.framework/Versions/Current/Headers"
  configure_make_makeinstall --enable-framework=$FRA_DIR --with-openssl=$OPT_DIR --enable-optimizations
)

### remove stack_size linker flag ##############################################

# according to this
# https://gitlab.gnome.org/GNOME/gtk-osx/blob/5131320175b7048d48930bfa0e6173101747fcc2/README.md
# we need to replace
#   LINKFORSHARED: -Wl,stack_size,1000000 -framework CoreFoundation
# with
#   LINKFORSHARED: -framework CoreFoundation
# effectively removing the stack_size parameter

sed -i "" "s/-Wl,-stack_size,1000000/ /" $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/_sysconfigdata_m_darwin_darwin.py

### install Libxml2 ############################################################

get_source $URL_LIBXML2
configure_make_makeinstall --with-python=$PY3_FRA_BIN_DIR/python$PY3_MAJOR

