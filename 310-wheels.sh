#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

### load settings and functions ################################################

SELF_DIR=$(F=$0; while [ ! -z $(readlink $F) ] && F=$(readlink $F); \
  cd $(dirname $F); F=$(basename $F); [ -L $F ]; do :; done; echo $(pwd -P))
for script in $SELF_DIR/0??-*.sh; do source $script; done

include_file echo_.sh
include_file error_.sh

### additional settings ########################################################

PYTHON_LXML_SRC=https://lxml.de/files/lxml-4.5.2.tgz

### build wheels ###############################################################

export PATH=$WRK_DIR/Frameworks/Python.framework/Versions/Current/bin:$PATH

pip3 install wheel

get_source $PYTHON_LXML_SRC

python3 setup.py bdist_wheel \
  --plat-name macosx_${MACOSX_DEPLOYMENT_TARGET/./_}_x86_64 \
  --bdist-dir $TMP_DIR/lxml \
  --dist-dir $WRK_DIR
