# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

[ -z $VARS_INCLUDED ] && VARS_INCLUDED=true || return   # include guard

### build directories ##########################################################

WRK_DIR=/work
OPT_DIR=$WRK_DIR/opt
SRC_DIR=$OPT_DIR/src
TMP_DIR=$OPT_DIR/tmp
LIB_DIR=$OPT_DIR/lib
INC_DIR=$OPT_DIR/include

### Framework directories ######################################################

FRA_DIR=$OPT_DIR/Frameworks/Python.framework
FRA_EXT_LIB_DIR=$FRA_DIR/Versions/3.6/Libraries
FRA_RES_DIR=$FRA_DIR/Versions/3.6/Resources
FRA_BIN_DIR=$FRA_DIR/Versions/3.6/bin
FRA_LIB_DIR=$FRA_DIR/Versions/3.6/lib
FRA_PY3_LIB=$FRA_DIR/Versions/3.6/Python

### compiler settings ##########################################################

export CFLAGS=-I$INC_DIR
export CXXFLAGS=-I$INC_DIR
export LDFLAGS=-L$LIB_DIR

# FYI: Python and OpenSSL have problems with mutli-core compilation
export MAKEFLAGS=-j$(sysctl -n hw.ncpu)  # use all available cores

export MACOSX_DEPLOYMENT_TARGET=10.11   # OS X El Capitan

### download URLs ##############################################################

# latest Python 3.6.x and latest "everything else"

URL_GETTEXT=https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz
URL_OPENSSL=https://www.openssl.org/source/openssl-1.1.0k.tar.gz
URL_PYTHON=https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz
URL_READLINE=ftp://ftp.cwru.edu/pub/bash/readline-8.0.tar.gz
URL_XZUTILS=https://tukaani.org/xz/xz-5.2.4.tar.xz
URL_ZLIB=https://zlib.net/zlib-1.2.11.tar.gz
