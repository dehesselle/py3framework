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

### change link paths for libraries in: lib-dynload ############################

while IFS= read -r library; do
  reset_library_name $library
  set_library_link_path @loader_path/../../../Libraries $library
done < <(find $PY3_FRA_LIB_PY3_DIR/lib-dynload -maxdepth 1 -name "*.so")

### change link paths for libraries in: site-packages ##########################

while IFS= read -r library; do
  reset_library_name $library
  set_library_link_path @loader_path/../../../Libraries $library
done < <(find $PY3_FRA_LIB_PY3_DIR/site-packages -maxdepth 1 -name "*.so")

### change link paths for libraries in: Libraries ##############################

while IFS= read -r library; do
  reset_library_name $library
  set_library_link_path @loader_path $library
done < <(find $PY3_FRA_EXT_LIB_DIR -maxdepth 1 -name "*.dylib")

### change link paths for libraries in: bin ####################################

set_library_link_path \
    @executable_path/.. \
    $PY3_FRA_BIN_DIR/python$PY3_MAJOR.$PY3_MINOR \
    $(dirname $PY3_FRA_LIB)

chmod 755 $PY3_FRA_BIN_DIR/python$PY3_MAJOR.$PY3_MINOR

### change link paths for libraries in: Python.app #############################

set_library_link_path \
    @executable_path/../../../.. \
    $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python \
    $(dirname $PY3_FRA_LIB)
set_library_link_path \
    @executable_path/../../../../Libraries \
    $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python \
    $LIB_DIR

chmod 755 $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python

### change link paths for libraries in: main Python library ####################

set_library_link_path @loader_path/Libraries $PY3_FRA_LIB

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
/" $PY3_FRA_BIN_DIR/python$PY3_MAJOR.${PY3_MINOR}-config

# turn 'pip3' into a symlink to 'pip$PY3_MAJOR.$PY3_MINOR'
cd $PY3_FRA_BIN_DIR
ln -sf pip$PY3_MAJOR.$PY3_MINOR pip3
