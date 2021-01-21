#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install Libxml2 ############################################################

LIBXML2_VER=2.9.10
LIBXML2_URL=ftp://xmlsoft.org/libxml2/libxml2-$LIBXML2_VER.tar.gz

get_source $LIBXML2_URL

(
  export PATH=$PY3_FRA_BIN_DIR:$PATH   # so libxml2 finds python3.8-config
  configure_make_makeinstall "--with-python=$PY3_FRA_BIN_DIR/python$PY3_MAJOR"
)
