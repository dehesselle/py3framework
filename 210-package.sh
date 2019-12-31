#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(F=$0; while [ ! -z $(readlink $F) ] && F=$(readlink $F); \
  cd $(dirname $F); F=$(basename $F); [ -L $F ]; do :; done; echo $(pwd -P))
for script in $SELF_DIR/0??-*.sh; do source $script; done

### halt on errors #############################################################

set -e

### create 'Libraries' symlink inside Framework bundle #########################

mkdir -p $PY3_FRA_EXT_LIB_DIR
cd $PY3_FRA_DIR
ln -sf Versions/Current/Libraries

### add gettext ################################################################

cp $LIB_DIR/libintl.8.dylib $PY3_FRA_EXT_LIB_DIR

### add Readline ###############################################################

cp $LIB_DIR/libreadline.8.dylib $PY3_FRA_EXT_LIB_DIR

### add OpenSSL ################################################################

cp $LIB_DIR/libssl.1.1.dylib $PY3_FRA_EXT_LIB_DIR
cp $LIB_DIR/libcrypto.1.1.dylib $PY3_FRA_EXT_LIB_DIR

### add XZ Utils ###############################################################

cp $LIB_DIR/liblzma.5.dylib $PY3_FRA_EXT_LIB_DIR

### add zlib ###################################################################

cp $LIB_DIR/libz.1.2.11.dylib $PY3_FRA_EXT_LIB_DIR/libz.1.dylib

### add iconv ##################################################################

cp $LIB_DIR/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR

### add Libxml2 ################################################################

cp $LIB_DIR/libxml2.2.dylib $PY3_FRA_EXT_LIB_DIR

### use rpath ##################################################################

set_to_rpath $PY3_FRA_BIN_DIR/python$PY3_MAJOR.$PY3_MINOR
set_to_rpath $PY3_FRA_BIN_DIR/python$PY3_MAJOR.${PY3_MINOR}m

install_name_tool -add_rpath @executable_path/..                       $PY3_FRA_BIN_DIR/python$PY3_MAJOR.$PY3_MINOR
install_name_tool -change $PY3_FRA_LIB @rpath/$(basename $PY3_FRA_LIB) $PY3_FRA_BIN_DIR/python$PY3_MAJOR.${PY3_MINOR}m
install_name_tool -change $PY3_FRA_LIB @rpath/$(basename $PY3_FRA_LIB) $PY3_FRA_BIN_DIR/python$PY3_MAJOR.${PY3_MINOR}

set_to_rpath $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python
install_name_tool -add_rpath @executable_path/../../../..              $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python
install_name_tool -add_rpath @executable_path/../../../../Libraries    $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python
install_name_tool -change $PY3_FRA_LIB @rpath/$(basename $PY3_FRA_LIB) $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python

while IFS= read -r library; do
  chmod 644 $library
  reset_library_name $library
  set_to_rpath $library
done < <(find $PY3_FRA_DIR -name "*.dylib" -o -name "*.so")

chmod 644 $PY3_FRA_LIB
set_to_rpath $PY3_FRA_LIB
install_name_tool -add_rpath @loader_path/Libraries $PY3_FRA_LIB

### use environment lookup for interpreter path ################################

# The linebreaks are intentional: this is the way to insert newlines with
# this version of 'sed'.

sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/2to3-$PY3_MAJOR.$PY3_MINOR
sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/easy_install-$PY3_MAJOR.$PY3_MINOR
sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/idle$PY3_MAJOR.$PY3_MINOR
sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/pip$PY3_MAJOR.$PY3_MINOR
sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/pydoc$PY3_MAJOR.$PY3_MINOR
sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/python$PY3_MAJOR.${PY3_MINOR}m-config
sed -i '' "1s/.*/#!\/usr\/bin\/env python$PY3_MAJOR.$PY3_MINOR\
/" $PY3_FRA_BIN_DIR/pyvenv-$PY3_MAJOR.$PY3_MINOR

# fix 'pip3' not being a symlink to 'pip$PY3_MAJOR.$PY3_MINOR'
cd $PY3_FRA_BIN_DIR
ln -sf pip$PY3_MAJOR.$PY3_MINOR pip3
