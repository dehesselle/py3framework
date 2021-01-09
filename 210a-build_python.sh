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

# use ~/Library/Caches/org.inkscape.Inkscape for PYTHONPYCACHEPREFIX
patch -p1 < $GITHUB_WORKSPACE/hardcode_pycache_prefix.patch

unset MAKEFLAGS    # revoke multi-core compilation
export CFLAGS="\
  $CFLAGS \
  -I$SDKROOT/System/Library/Frameworks/Tk.framework/Versions/Current/Headers\
"

# remove '--enable-optimizations' to speed things up for testing purposes
configure_make_makeinstall "\
  --enable-framework=$FRA_DIR\
  --with-openssl=$WRK_DIR\
  --enable-optimizations\
  " "" "PYTHONAPPSDIR=$TMP_DIR"
