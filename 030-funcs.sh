# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

[ -z $FUNCS_INCLUDED ] && FUNCS_INCLUDED=true || return   # include guard

### configure, make, make install ##############################################

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

### determine compressor flag by file extension ################################

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

### download and extract source tarball ########################################

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

### remove build path from dylib id ############################################

function reset_dylib_name
{
  local file=$1   # dylib filename

  local name=$(otool -D $file | tail -n 1)
  install_name_tool -id $(basename $name) $file   # remote path from library id
}

