#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

# This is a variant of 210-package.sh, using canonical paths instead
# relative ones.

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
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libintl.8.dylib $PY3_FRA_LIB
chmod 555 $PY3_FRA_LIB

### add Readline ###############################################################

cp $LIB_DIR/libreadline.8.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libreadline.8.dylib 
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libreadline.8.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libreadline.8.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/readline.cpython-36m-darwin.so

### add OpenSSL ################################################################

cp $LIB_DIR/libssl.1.1.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/_hashlib.cpython-36m-darwin.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libssl.1.1.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/_ssl.cpython-36m-darwin.so

cp $LIB_DIR/libcrypto.1.1.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/_hashlib.cpython-36m-darwin.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libcrypto.1.1.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/_ssl.cpython-36m-darwin.so

### add XZ Utils ###############################################################

cp $LIB_DIR/liblzma.5.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/_lzma.cpython-36m-darwin.so

### add zlib ###################################################################

cp $LIB_DIR/libz.1.2.11.dylib $PY3_FRA_EXT_LIB_DIR/libz.1.dylib
chmod 644 $PY3_FRA_EXT_LIB_DIR/libz.1.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libz.1.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libz.1.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/zlib.cpython-36m-darwin.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libz.1.dylib $PY3_FRA_LIB_DIR/python3.6/lib-dynload/binascii.cpython-36m-darwin.so

### add iconv ##################################################################

cp $LIB_DIR/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR/libintl.8.dylib

### add Libxml2 ###############################################################

cp $LIB_DIR/libxml2.2.dylib $PY3_FRA_EXT_LIB_DIR
chmod 644 $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
reset_dylib_name $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib $PY3_FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libz.1.dylib $PY3_FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib $PY3_FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libintl.8.dylib $PY3_FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib $PY3_FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so
relocate_dependency $PY3_FRA_LIB $PY3_FRA_LIB_DIR/python3.6/site-packages/libxml2mod.so

relocate_dependency $PY3_FRA_EXT_LIB_DIR/libz.1.dylib $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/liblzma.5.dylib $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libiconv.2.dylib $PY3_FRA_EXT_LIB_DIR/libxml2.2.dylib

### make library link paths relative ###########################################

relocate_dependency $PY3_FRA_LIB $PY3_FRA_BIN_DIR/python3.6
relocate_dependency $PY3_FRA_LIB $PY3_FRA_BIN_DIR/python3.6m
relocate_dependency $PY3_FRA_LIB $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python
relocate_dependency $PY3_FRA_EXT_LIB_DIR/libintl.8.dylib $PY3_FRA_RES_DIR/Python.app/Contents/MacOS/Python

### use environment lookup for interpreter path ################################

# The linebreaks are intentional: this is the way to insert newlines with
# this version of 'sed'.

sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/2to3-3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/easy_install-3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/idle3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/pip3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/pydoc3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/python3.6m-config
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PY3_FRA_BIN_DIR/pyvenv-3.6

# fix 'pip3' not being a symlink to 'pip3.6'
cd $PY3_FRA_BIN_DIR
ln -sf pip3.6 pip3
