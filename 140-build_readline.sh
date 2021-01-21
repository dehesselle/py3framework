#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### install readline ###########################################################

READLINE_VER=8.1
READLINE_URL=https://ftp.halifax.rwth-aachen.de/gnu/readline/readline-$READLINE_VER.tar.gz

get_source $READLINE_URL
configure_make_makeinstall
