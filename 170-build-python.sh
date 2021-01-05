#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### build Python ###############################################################

get_source $URL_PYTHON

( # Apply any patches if present.

  shopt -s nullglob
  for patch in $SELF_DIR/*.patch; do
    patch -p1 < $patch
  done
)

(
  unset MAKEFLAGS    # revoke multi-core compilation
  export CFLAGS="\
    $CFLAGS \
    -I$SDKROOT/System/Library/Frameworks/Tk.framework/Versions/Current/Headers\
  "
  configure_make_makeinstall "\
    --enable-framework=$FRA_DIR\
    --with-openssl=$WRK_DIR\
    --enable-optimizations\
    " "" "PYTHONAPPSDIR=$TMP_DIR"

  # speedup for testing purposes: remove '--enable-optimizations'
)
