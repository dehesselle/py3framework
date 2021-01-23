#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install zlib ###############################################################

ZLIB_VER=1.2.11
ZLIB_URL=https://zlib.net/zlib-$ZLIB_VER.tar.gz

get_source $ZLIB_URL
configure_make_makeinstall
