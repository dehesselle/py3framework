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
FRA_EXT_LIB_DIR=$FRA_DIR/Versions/3.7/Libraries
FRA_RES_DIR=$FRA_DIR/Versions/3.7/Resources
FRA_BIN_DIR=$FRA_DIR/Versions/3.7/bin
FRA_LIB_DIR=$FRA_DIR/Versions/3.7/lib
FRA_PY3_LIB=$FRA_DIR/Versions/3.7/Python

### compiler settings ##########################################################

export CFLAGS=-I$INC_DIR
export CXXFLAGS=-I$INC_DIR
export LDFLAGS=-L$LIB_DIR

export MAKEFLAGS=-j$(sysctl -n hw.ncpu)  # use all available cores


# I'm not using on old SDK so it's not safe to go lower than 10.12.
# https://smallhacks.wordpress.com/2018/11/11/how-to-support-old-osx-version-with-a-recent-xcode/
export MACOSX_DEPLOYMENT_TARGET=10.12   # macOS Sierra required

### download URLs ##############################################################

URL_PYTHON=https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
URL_OPENSSL=https://www.openssl.org/source/openssl-1.1.0k.tar.gz
URL_READLINE=ftp://ftp.cwru.edu/pub/bash/readline-8.0.tar.gz
URL_GETTEXT=https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz
URL_XZUTILS=https://tukaani.org/xz/xz-5.2.4.tar.xz
