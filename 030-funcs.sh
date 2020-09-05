# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

[ -z $FUNCS_INCLUDED ] && FUNCS_INCLUDED=true || return   # include guard

# Include common functions from https://github.com/dehesselle/bash_d

INCLUDE_DIR=$SELF_DIR/bash_d
source $INCLUDE_DIR/1_include_.sh
include_file echo_.sh

# Include custom functions.

for func in $SELF_DIR/funcs/*.sh; do
  source $func
done
