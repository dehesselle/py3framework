#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### build Python ###############################################################

get_source $URL_PYTHON

( # Apply any patches if present.

  shopt -s nullglob  # to not break loop code if no patches present
  for patch in $SELF_DIR/*.patch; do
    patch -p1 < $patch
  done
)

(
  unset MAKEFLAGS  # Python does not like being built in parallel with '-jN'

  configure_make_makeinstall "\
    --enable-framework=$FRA_DIR\
    --with-openssl=$WRK_DIR\
    --with-tcltk-includes=$SDKROOT/usr/include\
    --with-tcltk-libs=$SDKROOT/usr/lib\
    --enable-optimizations\
    " "" "PYTHONAPPSDIR=$TMP_DIR"
)
