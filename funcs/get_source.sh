# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

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
  [ $? -eq 0 ] && rm $log || echo_e "check $log"
}