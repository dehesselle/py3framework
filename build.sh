#!/usr/bin/env bash

### VARIABLES ##################################################################

WRK_DIR=/work
OPT_DIR=$WRK_DIR/opt
SRC_DIR=$OPT_DIR/src
TMP_DIR=$OPT_DIR/tmp
LIB_DIR=$OPT_DIR/lib
INC_DIR=$OPT_DIR/include

export CFLAGS=-I$INC_DIR
export CXXFLAGS=-I$INC_DIR
export LDFLAGS=-L$LIB_DIR
export MAKEFLAGS=-j$(sysctl -n hw.ncpu)

export MACOSX_DEPLOYMENT_TARGET=10.12

# version numbers have been set according to current Inkscape build pipeline
URL_PYTHON=https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
URL_OPENSSL=https://www.openssl.org/source/openssl-1.1.0g.tar.gz
URL_READLINE=ftp://ftp.cwru.edu/pub/bash/readline-7.0.tar.gz
URL_GETTEXT=https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.tar.gz
URL_XZUTILS=https://tukaani.org/xz/xz-5.2.4.tar.xz

### FUNCTIONS ##################################################################

function make_makeinstall
{
  make
  make install
}

function configure_make_makeinstall
{
  local flags="$*"

  ./configure --prefix=$OPT_DIR $flags
  make_makeinstall
}

function config_make_makeinstall
{
  local flags="$*"

  ./config --prefix=$OPT_DIR $flags
  make_makeinstall
}

function get_compressor_flag
{
  local file=$1

  local extension=${file##*.}

  case $extension in
    gz)  echo "z" ;;
    bz2) echo "j" ;;
    xz)  echo "J" ;;
    *)   echo "$FUNCNAME: ERROR unknown extension $extension" >&2
  esac
}

function get_source
{
  local url=$1
  local target_dir=$2   # optional argument, defaults to $SRC_DIR

  [ ! -d $TMP_DIR ] && mkdir -p $TMP_DIR
  local log=$(mktemp $TMP_DIR/$FUNCNAME.XXXX)
  [ ! -d $SRC_DIR ] && mkdir -p $SRC_DIR
  [ -z $target_dir ] && target_dir=$SRC_DIR

  cd $target_dir

  # This downloads a file and pipes it directly into tar (file is not saved
  # to disk) to extract it. Output is saved temporarily to determine
  # the directory the files have been extracted to.
  curl -L $url | tar xv$(get_compressor_flag $url) 2>$log
  local dir=$(head -1 $log | awk '{ print $2 }')   # get first file from archive
  dir=${dir%%/*}   # remove everything except the directory name
  cd $dir
  [ $? -eq 0 ] && rm $log || echo "$FUNCNAME: ERROR check $log"
}

function build_python
{
  get_source $PYTHON_DOWNLOAD_URL

  ./configure --prefix $OPT_DIR --enable-framework=$OPT_DIR/Frameworks


}

function reset_dylib_name
{
  local file=$1   # dylib filename

  local name=$(otool -D $file | tail -n 1)
  install_name_tool -id $(basename $name) $file   # remote path from library id
}

### MAIN #######################################################################

#set -e

get_source $URL_OPENSSL
config_make_makeinstall

get_source $URL_READLINE
configure_make_makeinstall

get_source $URL_GETTEXT
configure_make_makeinstall --without-emacs --disable-java --disable-native-java --disable-libasprintf --disable-csharp

get_source $URL_XZUTILS
configure_make_makeinstall

unset MAKEFLAGS

get_source $URL_PYTHON
configure_make_makeinstall --enable-framework=$OPT_DIR/Frameworks


# add 3rd party libraries to Framework
FRA_DIR=$OPT_DIR/Frameworks/Python.framework
FRA_EXT_LIB_DIR=$FRA_DIR/Versions/3.6/Libraries
FRA_RES_DIR=$FRA_DIR/Versions/3.6/Resources
FRA_BIN_DIR=$FRA_DIR/Versions/3.6/bin
FRA_LIB_DIR=$FRA_DIR/Versions/3.6/lib
FRA_PY3_LIB=$FRA_DIR/Versions/3.6/Python
mkdir -p $FRA_EXT_LIB_DIR
ln -s $FRA_EXT_LIB_DIR $FRA_DIR



cp $LIB_DIR/libintl.9.dylib $FRA_EXT_LIB_DIR
reset_dylib_name $FRA_EXT_LIB_DIR/libintl.9.dylib
chmod 755 $FRA_PY3_LIB
install_name_tool -change $LIB_DIR/libintl.9.dylib @loader_path/Libraries/libintl.9.dylib $FRA_PY3_LIB
chmod 555 $FRA_PY3_LIB

cp $LIB_DIR/libreadline.7.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libreadline.7.dylib 
reset_dylib_name $FRA_EXT_LIB_DIR/libreadline.7.dylib
install_name_tool -change $LIB_DIR/libreadline.7.dylib @loader_path/../../../Libraries/libreadline.7.dylib $FRA_LIB_DIR/python3.6/lib-dynload/readline.cpython-36m-darwin.so

cp $LIB_DIR/libssl.1.1.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libssl.1.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libssl.1.1.dylib
install_name_tool -change $LIB_DIR/libcrypto.1.1.dylib @loader_path/libcrypto.1.1.dylib $FRA_EXT_LIB_DIR/libssl.1.1.dylib
install_name_tool -change $LIB_DIR/libssl.1.1.dylib @loader_path/../../../Libraries/libssl.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_hashlib.cpython-36m-darwin.so
install_name_tool -change $LIB_DIR/libssl.1.1.dylib @loader_path/../../../Libraries/libssl.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_ssl.cpython-36m-darwin.so

cp $LIB_DIR/libcrypto.1.1.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/libcrypto.1.1.dylib
install_name_tool -change $LIB_DIR/libcrypto.1.1.dylib @loader_path/../../../Libraries/libcrypto.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_hashlib.cpython-36m-darwin.so
install_name_tool -change $LIB_DIR/libcrypto.1.1.dylib @loader_path/../../../Libraries/libcrypto.1.1.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_ssl.cpython-36m-darwin.so

cp $LIB_DIR/liblzma.5.dylib $FRA_EXT_LIB_DIR
chmod 644 $FRA_EXT_LIB_DIR/liblzma.5.dylib
reset_dylib_name $FRA_EXT_LIB_DIR/liblzma.5.dylib
install_name_tool -change $LIB_DIR/liblzma.5.dylib @loader_path/../../../Libraries/liblzma.5.dylib $FRA_LIB_DIR/python3.6/lib-dynload/_lzma.cpython-36m-darwin.so






# make library link paths relative
install_name_tool -change $FRA_PY3_LIB @executable_path/../Python $FRA_BIN_DIR/python3.6
install_name_tool -change $FRA_PY3_LIB @executable_path/../Python $FRA_BIN_DIR/python3.6m
install_name_tool -change $FRA_PY3_LIB @executable_path/../../../../Python $FRA_RES_DIR/Python.app/Contents/MacOS/Python
install_name_tool -change $LIB_DIR/libintl.9.dylib @executable_path/../../../../Libraries/libintl.9.dylib $FRA_RES_DIR/Python.app/Contents/MacOS/Python

# replace hard-coded interpreter path in shebang with an environment lookup
PYTHON_BIN_DIR=$OPT_DIR/Frameworks/Python.framework/Versions/3.6/bin
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/2to3-3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/idle3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/pydoc3.6
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/python3.6m-config
sed -i '' '1s/.*/#!\/usr\/bin\/env python3.6\
/' $PYTHON_BIN_DIR/pyvenv-3.6

