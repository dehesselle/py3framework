#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install gettext ############################################################

get_source $URL_GETTEXT
configure_make_makeinstall "\
  --disable-csharp\
  --without-emacs\
  --disable-java\
  --disable-libasprintf\
  --disable-native-java\
"
