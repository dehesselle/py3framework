#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install Libxml2 ############################################################

get_source $URL_LIBXML2

(
  export PATH=$PY3_FRA_BIN_DIR:$PATH   # so libxml2 finds python3.8-config
  configure_make_makeinstall "--with-python=$PY3_FRA_BIN_DIR/python$PY3_MAJOR"
)
