# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

[ -z $FUNCS_INCLUDED ] && FUNCS_INCLUDED=true || return   # include guard

# Include common functions from https://github.com/dehesselle/bash_d

INCLUDE_DIR=$SELF_DIR/bash_d
source $INCLUDE_DIR/1_include_.sh
include_file echo_.sh
include_file error_.sh

# Include custom functions.

for func in $SELF_DIR/funcs/*.sh; do
  source $func
done
