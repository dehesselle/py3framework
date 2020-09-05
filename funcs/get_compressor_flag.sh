# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

function get_compressor_flag
{
  local file=$1

  local extension=${file##*.}

  case $extension in
    gz)  echo "z" ;;
    bz2) echo "j" ;;
    xz)  echo "J" ;;
    *)   echo_e "unknown extension $extension" >&2
  esac
}