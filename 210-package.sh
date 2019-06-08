#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(cd $(dirname "$0"); pwd -P)
for script in $SELF_DIR/0??-*.sh; do source $script; done

### create 'Libraries' symlink inside Framework bundle #########################

mkdir -p $FRA_EXT_LIB_DIR
ln -s $FRA_EXT_LIB_DIR $FRA_DIR

### add gettext ################################################################

cp $LIB_DIR/libintl.9.dylib $FRA_EXT_LIB_DIR
reset_dylib_name $FRA_EXT_LIB_DIR/libintl.9.dylib
chmod 755 $FRA_PY3_LIB
install_name_tool -change $LIB_DIR/libintl.9.dylib @loader_path/Libraries/libintl.9.dylib $FRA_PY3_LIB
chmod 555 $FRA_PY3_LIB

### add Readline ###############################################################

cp $LIB_DIR/libreadline.8.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libreadline.8.dylib 
reset_dylib_name $FRA_EXT_LIB_DIR/libreadline.8.dylib
install_name_tool -change $LIB_DIR/libreadline.8.dylib @loader_path/../../../Libraries/libreadline.8.dylib $FRA_LIB_DIR/python3.7/lib-dynload/readline.cpython-37m-darwin.so

### add OpenSSL ################################################################

cp $LIB_DIR/libssl.1.1.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libssl.1.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libssl.1.1.dylib
install_name_tool -change $LIB_DIR/libcrypto.1.1.dylib @loader_path/libcrypto.1.1.dylib $FRA_EXT_LIB_DIR/libssl.1.1.dylib
install_name_tool -change $LIB_DIR/libssl.1.1.dylib @loader_path/../../../Libraries/libssl.1.1.dylib $FRA_LIB_DIR/python3.7/lib-dynload/_hashlib.cpython-37m-darwin.so
install_name_tool -change $LIB_DIR/libssl.1.1.dylib @loader_path/../../../Libraries/libssl.1.1.dylib $FRA_LIB_DIR/python3.7/lib-dynload/_ssl.cpython-37m-darwin.so

cp $LIB_DIR/libcrypto.1.1.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
install_name_tool -change $LIB_DIR/libcrypto.1.1.dylib @loader_path/../../../Libraries/libcrypto.1.1.dylib $FRA_LIB_DIR/python3.7/lib-dynload/_hashlib.cpython-37m-darwin.so
install_name_tool -change $LIB_DIR/libcrypto.1.1.dylib @loader_path/../../../Libraries/libcrypto.1.1.dylib $FRA_LIB_DIR/python3.7/lib-dynload/_ssl.cpython-37m-darwin.so

### add XZ Utils ###############################################################

cp $LIB_DIR/liblzma.5.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/liblzma.5.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/liblzma.5.dylib
install_name_tool -change $LIB_DIR/liblzma.5.dylib @loader_path/../../../Libraries/liblzma.5.dylib $FRA_LIB_DIR/python3.7/lib-dynload/_lzma.cpython-37m-darwin.so

### make library link paths relative ###########################################

install_name_tool -change $FRA_PY3_LIB @executable_path/../Python $FRA_BIN_DIR/python3.7
install_name_tool -change $FRA_PY3_LIB @executable_path/../Python $FRA_BIN_DIR/python3.7m
install_name_tool -change $FRA_PY3_LIB @executable_path/../../../../Python $FRA_RES_DIR/Python.app/Contents/MacOS/Python
install_name_tool -change $LIB_DIR/libintl.9.dylib @executable_path/../../../../Libraries/libintl.9.dylib $FRA_RES_DIR/Python.app/Contents/MacOS/Python

### use environment lookup for interpreter path ################################

# The linebreaks are intentional: this is the way to insert newlines with
# this version of 'sed'.

PYTHON_BIN_DIR=$OPT_DIR/Frameworks/Python.framework/Versions/3.7/bin
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.7\
/' $PYTHON_BIN_DIR/2to3-3.7
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.7\
/' $PYTHON_BIN_DIR/idle3.7
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.7\
/' $PYTHON_BIN_DIR/pydoc3.7
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.7\
/' $PYTHON_BIN_DIR/python3.7m-config
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.7\
/' $PYTHON_BIN_DIR/pyvenv-3.7
