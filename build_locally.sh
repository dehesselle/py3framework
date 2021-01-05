#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# This file is part of https://github.com/dehesselle/py3framework

for script in 1??-*.sh; do
  ./$script
done

for script in 2??-*.sh; do
  ./$script
done
