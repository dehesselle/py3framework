#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(cd $(dirname "$0"); pwd -P)
for script in $SELF_DIR/0??-*.sh; do source $script; done

### halt on errors #############################################################

set -e

### install OpenSSL ############################################################

get_source $URL_OPENSSL
config_make_makeinstall

### install readline ###########################################################

get_source $URL_READLINE
configure_make_makeinstall

### install gettext ############################################################

get_source $URL_GETTEXT
configure_make_makeinstall --without-emacs --disable-java --disable-native-java --disable-libasprintf --disable-csharp

### install lzma ###############################################################

get_source $URL_XZUTILS
configure_make_makeinstall

### install Python #############################################################

unset MAKEFLAGS   # compile this single-threaded only, breaks otherwise

get_source $URL_PYTHON
configure_make_makeinstall --enable-framework=$OPT_DIR/Frameworks --enable-optimizations

