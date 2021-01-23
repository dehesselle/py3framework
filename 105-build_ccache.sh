#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

### load settings and functions ################################################

for script in $(dirname ${BASH_SOURCE[0]})/0??-*.sh; do source $script; done

### halt on errors #############################################################

error_trace_enable

### source #####################################################################

CCACHE_VER=3.7.11
CCACHE_URL=https://github.com/ccache/ccache/releases/download/\
v$CCACHE_VER/ccache-$CCACHE_VER.tar.xz

### install iconv ##############################################################

get_source $CCACHE_URL
configure_make_makeinstall

ln -s $BIN_DIR/ccache $BIN_DIR/clang
ln -s $BIN_DIR/ccache $BIN_DIR/clang++
ln -s $BIN_DIR/ccache $BIN_DIR/gcc
ln -s $BIN_DIR/ccache $BIN_DIR/g++
ln -s $BIN_DIR/ccache $BIN_DIR/cc
ln -s $BIN_DIR/ccache $BIN_DIR/c++
