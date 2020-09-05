# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

function make_makeinstall
{
  local make_flags="$1"
  local make_install_flags="$2"

  make $make_flags
  make install $make_install_flags
}