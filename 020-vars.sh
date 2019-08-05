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
FRA_DIR=$OPT_DIR/Frameworks

### Python version #############################################################

# Set the Python version here. All directories and filenames will adapt 
# accordingly using these variables.

PY3_MAJOR=3
PY3_MINOR=7
PY3_PATCH=4

### Python.framework directories ###############################################

PY3_FRA_DIR=$FRA_DIR/Python.framework
PY3_FRA_EXT_LIB_DIR=$PY3_FRA_DIR/Versions/$PY3_MAJOR.$PY3_MINOR/Libraries
PY3_FRA_RES_DIR=$PY3_FRA_DIR/Versions/$PY3_MAJOR.$PY3_MINOR/Resources
PY3_FRA_BIN_DIR=$PY3_FRA_DIR/Versions/$PY3_MAJOR.$PY3_MINOR/bin
PY3_FRA_LIB_DIR=$PY3_FRA_DIR/Versions/$PY3_MAJOR.$PY3_MINOR/lib
PY3_FRA_LIB=$PY3_FRA_DIR/Versions/$PY3_MAJOR.$PY3_MINOR/Python

### compiler settings ##########################################################

export CFLAGS=-I$INC_DIR
export CXXFLAGS=-I$INC_DIR
export LDFLAGS=-L$LIB_DIR

# FYI: Python and OpenSSL have problems with mutli-core compilation
export MAKEFLAGS=-j$(sysctl -n hw.ncpu)  # use all available cores

export MACOSX_DEPLOYMENT_TARGET=10.11   # OS X El Capitan

### download URLs ##############################################################

# Python $PY3_MAJOR.$PY3_MINOR.$PY3_PATCH and latest "everything else"

URL_GETTEXT=https://ftp.halifax.rwth-aachen.de/gnu/gettext/gettext-0.20.1.tar.xz
URL_ICONV=https://ftp.halifax.rwth-aachen.de/gnu/libiconv/libiconv-1.16.tar.gz
URL_OPENSSL=https://www.openssl.org/source/openssl-1.1.1c.tar.gz
URL_PYTHON=https://www.python.org/ftp/python/$PY3_MAJOR.$PY3_MINOR.$PY3_PATCH/Python-$PY3_MAJOR.$PY3_MINOR.$PY3_PATCH.tar.xz
URL_READLINE=https://ftp.halifax.rwth-aachen.de/gnu/readline/readline-8.0.tar.gz
URL_LIBXML2=ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
URL_XZUTILS=https://tukaani.org/xz/xz-5.2.4.tar.xz
URL_ZLIB=https://zlib.net/zlib-1.2.11.tar.gz
