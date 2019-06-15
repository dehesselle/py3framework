# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

[ -z $VARSSDK109_INCLUDED ] && VARSSDK109_INCLUDED=true || return   # include guard

### change settings to compile against MacOSX10.9.sdk ##########################

# If this file is present, it overrides some settings from 020-vars.sh to 
# compile against 10.9 SDK instead of 10.13 SDK.

# add flags to use 10.9 SDK
export CFLAGS="$CFLAGS -mmacosx-version-min=10.9 -isysroot /Developer/SDKs/MacOSX10.9.sdk"
export CXXFLAGS="$CXXFLAGS -mmacosx-version-min=10.9 -isysroot /Developer/SDKs/MacOSX10.9.sdk"
export LDFLAGS="$LDFLAGS -mmacosx-version-min=10.9 -isysroot /Developer/SDKs/MacOSX10.9.sdk"

# re-set the deployment target accordingly
export MACOSX_DEPLOYMENT_TARGET=10.9

# remove workarounds for 10.13 SDK
unset ac_cv_func_futimens
unset ac_cv_func_utimensat

