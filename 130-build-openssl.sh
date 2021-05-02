#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install OpenSSL ############################################################

get_source $URL_OPENSSL

# OpenSSL needs special treatment to configure correctly for an alternate SDK.
./config --prefix=$WRK_DIR -mmacosx-version-min=$MACOSX_DEPLOYMENT_TARGET

make_makeinstall
