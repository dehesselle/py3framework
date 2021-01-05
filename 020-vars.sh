# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

[ -z $VARS_INCLUDED ] && VARS_INCLUDED=true || return   # include guard

### directories: self ##########################################################

# The fully qualified directory name in canonicalized form.

# The script magic here is is a replacement for GNU's "readlink -f".
SELF_DIR=$(F=$0; while [ ! -z $(readlink $F) ] && F=$(readlink $F); \
  cd $(dirname $F); F=$(basename $F); [ -L $F ]; do :; done; echo $(pwd -P))

### directories: work ##########################################################

if [ -z $WRK_DIR ]; then
  WRK_DIR=/Users/Shared/work/py3framework
fi

### directories: FSH-like tree below work ######################################

SRC_DIR=$WRK_DIR/src
TMP_DIR=$WRK_DIR/tmp
LIB_DIR=$WRK_DIR/lib
INC_DIR=$WRK_DIR/include
FRA_DIR=$WRK_DIR/Frameworks

### directories: temporary locations ###########################################

export TMP=$TMP_DIR
export TEMP=$TMP_DIR
export TMPDIR=$TMP_DIR
export XDG_CACHE_HOME=$TMP_DIR/xdgcache     # instead ~/.cache
export XDG_CONFIG_HOME=$TMP_DIR/xdgconfig   # instead ~/.config
export PIP_CACHE_DIR=$TMP_DIR/pip           # instead ~/Library/Caches/pip
export PIPENV_CACHE_DIR=$TMP_DIR/pipenv     # instead ~/Library/Caches/pipenv

### Python version #############################################################

# Set the Python version here. All directories and filenames will adapt
# accordingly using these variables.

PY3_MAJOR=3
PY3_MINOR=8
PY3_PATCH=6

### Python.framework directories ###############################################

PY3_FRA_DIR=$FRA_DIR/Python.framework
PY3_FRA_VER_PY3_DIR=$PY3_FRA_DIR/Versions/$PY3_MAJOR.$PY3_MINOR
PY3_FRA_BIN_DIR=$PY3_FRA_VER_PY3_DIR/bin
PY3_FRA_EXT_LIB_DIR=$PY3_FRA_VER_PY3_DIR/Libraries
PY3_FRA_LIB_DIR=$PY3_FRA_VER_PY3_DIR/lib
PY3_FRA_LIB_PY3_DIR=$PY3_FRA_LIB_DIR/python$PY3_MAJOR.$PY3_MINOR
PY3_FRA_RES_DIR=$PY3_FRA_VER_PY3_DIR/Resources

PY3_FRA_LIB=$PY3_FRA_VER_PY3_DIR/Python

### compiler settings ##########################################################

export CFLAGS=-I$INC_DIR
export CXXFLAGS=-I$INC_DIR
export LDFLAGS=-L$LIB_DIR

# FYI: Python and OpenSSL have problems with mutli-core compilation
export MAKEFLAGS=-j$(/usr/sbin/sysctl -n hw.ncpu)  # use all available cores

if [ ! -z $SDKROOT ]; then  # if set, use deployment target from SDK
  export SDKROOT
  export MACOSX_DEPLOYMENT_TARGET=$(/usr/libexec/PlistBuddy -c "Print :DefaultProperties:MACOSX_DEPLOYMENT_TARGET" $SDKROOT/SDKSettings.plist)
fi

### download URLs ##############################################################

URL_GNU_MIRROR=https://ftp.halifax.rwth-aachen.de/gnu

# Python $PY3_MAJOR.$PY3_MINOR.$PY3_PATCH and latest "everything else"

URL_GETTEXT=$URL_GNU_MIRROR/gettext/gettext-0.21.tar.xz
URL_ICONV=$URL_GNU_MIRROR/libiconv/libiconv-1.16.tar.gz
URL_LIBXML2=ftp://xmlsoft.org/libxml2/libxml2-2.9.10.tar.gz
URL_OPENSSL=https://www.openssl.org/source/openssl-1.1.1i.tar.gz
URL_PYTHON=https://www.python.org/ftp/python/$PY3_MAJOR.$PY3_MINOR.$PY3_PATCH/Python-$PY3_MAJOR.$PY3_MINOR.$PY3_PATCH.tar.xz
URL_READLINE=$URL_GNU_MIRROR/readline/readline-8.1.tar.gz
URL_XZUTILS=https://tukaani.org/xz/xz-5.2.5.tar.xz
URL_ZLIB=https://zlib.net/zlib-1.2.11.tar.gz
