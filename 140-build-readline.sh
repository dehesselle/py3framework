#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install readline ###########################################################

get_source $URL_READLINE
configure_make_makeinstall
