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
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libintl.8.dylib
chmod 755 $PY3_FRA_LIB
relocate_dependency @loader_path/Libraries/libintl.8.dylib $PY3_FRA_LIB
chmod 555 $PY3_FRA_LIB

### add Readline ###############################################################

cp $LIB_DIR/libreadline.8.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libreadline.8.dylib 
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libreadline.8.dylib
relocate_dependency @loader_path/../../../Libraries/libreadline.8.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/readline.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so

### add OpenSSL ################################################################

cp $LIB_DIR/libssl.1.1.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib
relocate_dependency @loader_path/libcrypto.1.1.dylib $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib
relocate_dependency @loader_path/../../../Libraries/libssl.1.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/_hashlib.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so
relocate_dependency @loader_path/../../../Libraries/libssl.1.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/_ssl.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so

cp $LIB_DIR/libcrypto.1.1.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
relocate_dependency @loader_path/../../../Libraries/libcrypto.1.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/_hashlib.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so
relocate_dependency @loader_path/../../../Libraries/libcrypto.1.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/_ssl.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so

### add XZ Utils ###############################################################

cp $LIB_DIR/liblzma.5.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib
relocate_dependency @loader_path/../../../Libraries/liblzma.5.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/_lzma.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so

### add zlib ###################################################################

cp $LIB_DIR/libz.1.2.11.dylib $PY3_FRA_EXT_LIB_DIR/libz.1.dylib
chmod 644 $PY3_FRA_EXT_LIB_DIR/libz.1.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libz.1.dylib
relocate_dependency @loader_path/../../../Libraries/libz.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/zlib.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so
relocate_dependency @loader_path/../../../Libraries/libz.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/lib-dynload/binascii.cpython-$PY3_MAJOR${PY3_MINOR}m-darwin.so

### add iconv ##################################################################

cp $LIB_DIR/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib
relocate_dependency @loader_path/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR/libintl.8.dylib

### add Libxml2 ###############################################################

cp $LIB_DIR/libxml2.2.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency @loader_path/../../../../../Libraries/libxml2.2.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/libz.1.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/liblzma.5.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/libintl.8.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/libiconv.2.dylib $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../Python $PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR/site-packages/libxml2mod.so

relocate_dependency @loader_path/libz.1.dylib $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency @loader_path/liblzma.5.dylib $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency @loader_path/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib

### make library link paths relative ###########################################

relocate_dependency @executable_path/../Python $PY3_FRA_BIN_DIR/python$PY3_MAJOR.$PY3_MINOR
relocate_dependency @executable_path/../Python $PY3_FRA_BIN_DIR/python$PY3_MAJOR.${PY3_MINOR}m
relocate_dependency @executable_path/../../../../Python $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python
relocate_dependency @executable_path/../../../../Libraries/libintl.8.dylib $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python

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

