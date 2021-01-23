#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install gettext ############################################################

GETTEXT_VER=0.21
GETTEXT_URL=https://ftp.halifax.rwth-aachen.de/gnu/gettext/gettext-$GETTEXT_VER.tar.xz

get_source $GETTEXT_URL
configure_make_makeinstall "\
  --disable-csharp\
  --without-emacs\
  --disable-java\
  --disable-libasprintf\
  --disable-native-java\
"
