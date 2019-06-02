#!/usr/bin/env bash

### VARIABLES ##################################################################

WRK_DIR=/work
OPT_DIR=$WRK_DIR/opt
SRC_DIR=$OPT_DIR/src
TMP_DIR=$OPT_DIR/tmp
LIB_DIR=$OPT_DIR/lib
INC_DIR=$OPT_DIR/include


# version numbers have been set according to current Inkscape build pipeline
URL_PYTHON=https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
URL_OPENSSL=https://www.openssl.org/source/openssl-1.1.0g.tar.gz
URL_READLINE=ftp://ftp.cwru.edu/pub/bash/readline-7.0.tar.gz
URL_GETTEXT=https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.tar.gz


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
  otool -id $(basename $name) $file   # remote path from library id
}

### MAIN #######################################################################

set -e

export CFLAGS=-I$INC_DIR
export CXXFLAGS=-I$INC_DIR
export LDFLAGS=-L$LIB_DIR
export MAKEFLAGS=-j$(sysctl -n hw.ncpu)

get_source $URL_OPENSSL
config_make_makeinstall

get_source $URL_READLINE
configure_make_makeinstall

get_source $URL_GETTEXT
configure_make_makeinstall --without-emacs --disable-java --disable-native-java --disable-libasprintf --disable-csharp

unset MAKEFLAGS

get_source $URL_PYTHON
configure_make_makeinstall --enable-framework=$OPT_DIR/Frameworks


# add 3rd party libraries to Framework



# make library link paths relative
install_name_tool -change $OPT_DIR/Frameworks/Python.framework/Versions/3.6/Python @executable_path/../../../Versions/3.6/Python $OPT_DIR/Frameworks/Python.framework/Versions/3.6/bin/python3.6
install_name_tool -change $OPT_DIR/Frameworks/Python.framework/Versions/3.6/Python @executable_path/../../../Versions/3.6/Python $OPT_DIR/Frameworks/Python.framework/Versions/3.6/bin/python3.6m
install_name_tool -change $OPT_DIR/Frameworks/Python.framework/Versions/3.6/Python @executable_path/../../../../Python $OPT_DIR/Frameworks/Python.framework/Versions/3.6/Resources/Python.app/Contents/MacOS/Python




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

