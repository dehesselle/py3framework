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

mkdir -p $FRA_EXT_LIB_DIR
cd $FRA_DIR
ln -sf Versions/Current/Libraries

### add gettext ################################################################

cp $LIB_DIR/libintl.8.dylib $FRA_EXT_LIB_DIR
reset_dylib_name $FRA_EXT_LIB_DIR/libintl.8.dylib
chmod 755 $FRA_PY3_LIB
relocate_dependency @loader_path/Libraries/libintl.8.dylib $FRA_PY3_LIB
chmod 555 $FRA_PY3_LIB

### add Readline ###############################################################

cp $LIB_DIR/libreadline.8.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libreadline.8.dylib 
reset_dylib_name $FRA_EXT_LIB_DIR/libreadline.8.dylib
relocate_dependency @loader_path/../../../Libraries/libreadline.8.dylib $FRA_LIB_DIR/python3.6/lib-dynload/readline.cpython-36m-darwin.so

### add OpenSSL ################################################################

cp $LIB_DIR/libssl.1.1.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libssl.1.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libssl.1.1.dylib
relocate_dependency @loader_path/libcrypto.1.1.dylib $FRA_EXT_LIB_DIR/libssl.1.1.dylib
relocate_dependency @loader_path/../../../Libraries/libssl.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_hashlib.cpython-36m-darwin.so
relocate_dependency @loader_path/../../../Libraries/libssl.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_ssl.cpython-36m-darwin.so

cp $LIB_DIR/libcrypto.1.1.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
relocate_dependency @loader_path/../../../Libraries/libcrypto.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_hashlib.cpython-36m-darwin.so
relocate_dependency @loader_path/../../../Libraries/libcrypto.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_ssl.cpython-36m-darwin.so

### add XZ Utils ###############################################################

cp $LIB_DIR/liblzma.5.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/liblzma.5.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/liblzma.5.dylib
relocate_dependency @loader_path/../../../Libraries/liblzma.5.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_lzma.cpython-36m-darwin.so

### add zlib ###################################################################

cp $LIB_DIR/libz.1.2.11.dylib $FRA_EXT_LIB_DIR/libz.1.dylib
chmod 644 $FRA_EXT_LIB_DIR/libz.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libz.1.dylib
relocate_dependency @loader_path/../../../Libraries/libz.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/zlib.cpython-36m-darwin.so
relocate_dependency @loader_path/../../../Libraries/libz.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/binascii.cpython-36m-darwin.so

### add iconv ##################################################################

cp $LIB_DIR/libiconv.2.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libiconv.2.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libiconv.2.dylib
relocate_dependency @loader_path/libiconv.2.dylib $FRA_EXT_LIB_DIR/libintl.8.dylib

### add Libxml2 ###############################################################

cp $LIB_DIR/libxml2.2.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libxml2.2.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency @loader_path/../../../../../Libraries/libxml2.2.dylib $FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/libz.1.dylib $FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/liblzma.5.dylib $FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/libintl.8.dylib $FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../../../Libraries/libiconv.2.dylib $FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency @loader_path/../../../Python $FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so

relocate_dependency @loader_path/libz.1.dylib $FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency @loader_path/liblzma.5.dylib $FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency @loader_path/libiconv.2.dylib $FRA_EXT_LIB_DIR/libxml2.2.dylib

### make library link paths relative ###########################################

relocate_dependency @executable_path/../Python $FRA_BIN_DIR/python3.6
relocate_dependency @executable_path/../Python $FRA_BIN_DIR/python3.6m
relocate_dependency @executable_path/../../../../Python $FRA_RES_DIR/Python.app/Contents/MacOS/Python
relocate_dependency @executable_path/../../../../Libraries/libintl.8.dylib $FRA_RES_DIR/Python.app/Contents/MacOS/Python

### use environment lookup for interpreter path ################################

# The linebreaks are intentional: this is the way to insert newlines with
# this version of 'sed'.

PYTHON_BIN_DIR=$OPT_DIR/Frameworks/Python.framework/Versions/3.6/bin
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/2to3-3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/easy_install-3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/idle3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/pip3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/pydoc3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/python3.6m-config
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/pyvenv-3.6

# fix 'pip3' not being a symlink to 'pip3.6'
cd $PYTHON_BIN_DIR
ln -sf pip3.6 pip3
