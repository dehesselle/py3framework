# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

function configure_make_makeinstall
{
  local configure_flags="$1"
  local make_flags="$2"
  local make_install_flags="$3"

  ./configure --prefix=$OPT_DIR $configure_flags
  make_makeinstall "$make_flags" "$make_install_flags"
}