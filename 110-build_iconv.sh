#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### source #####################################################################

ICONV_VER=1.16
ICONV_URL=https://ftp.halifax.rwth-aachen.de/gnu/libiconv/libiconv-$ICONV_VER.tar.gz

### install iconv ##############################################################

get_source $ICONV_URL
configure_make_makeinstall
