#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### build Python ###############################################################

get_source $PYTHON_URL

# remove '--enable-optimizations' to speed things up for testing purposes
configure_make_makeinstall "\
  --enable-framework=$FRA_DIR\
  --with-openssl=$WRK_DIR\
  --enable-optimizations\
  --with-tcltk-includes=$SDKROOT/usr/include\
  --with-tcltk-libs=$SDKROOT/usr/lib\
  " "" "PYTHONAPPSDIR=$TMP_DIR"
