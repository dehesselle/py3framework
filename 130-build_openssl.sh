#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install OpenSSL ############################################################

OPENSSL_VER=1.1.1i
OPENSSL_URL=https://www.openssl.org/source/openssl-$OPENSSL_VER.tar.gz

get_source $OPENSSL_URL

if [ ! -z $MACOSX_DEPLOYMENT_TARGET ]; then
  # OpenSSL needs special treatment to target alternative platforms.
  MMACOSX_VERSION_MIN=-mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET
fi

./config --prefix=$WRK_DIR $MMACOSX_VERSION_MIN

make_makeinstall
