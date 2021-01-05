#!/usr/bin/env bash
# This file is part of https://github.com/dehesselle/py3framework
# Licensed under GPLv3.

for script in 1??-*.sh; do
  ./$script
done

for script in 2??-*.sh; do
  ./$script
done
