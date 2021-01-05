#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install OpenSSL ############################################################

get_source $URL_OPENSSL

if [ ! -z $MACOSX_DEPLOYMENT_TARGET ]; then
  # OpenSSL needs special treatment to target alternative platforms.
  MMACOSX_VERSION_MIN=-mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET
fi

./config --prefix=$WRK_DIR $MMACOSX_VERSION_MIN

unset MAKEFLAGS    # revoke multi-core compilation
make_makeinstall
