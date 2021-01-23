#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install lzma ###############################################################

XZUTILS_VER=5.2.5
XZUTILS_URL=https://tukaani.org/xz/xz-$XZUTILS_VER.tar.gz

get_source $XZUTILS_URL
configure_make_makeinstall
