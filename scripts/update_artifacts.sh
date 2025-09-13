#!/bin/bash
#
# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

mkdir /tmp/libknitro
cd /tmp/libknitro

mkdir exdir
curl https://files.pythonhosted.org/packages/7e/05/faf197e94566bfd18124e3bec5e8d5b443104ee7ece979add309c69ee4db/knitro-15.0.1-py3-none-macosx_13_0_arm64.whl -o tmp.zip
unzip tmp.zip -d exdir
cp exdir/knitro-*/licenses/LICENSE exdir/knitro/LICENSE
rm -rf exdir/knitro/scipy
rm -rf exdir/knitro/numpy
rm -rf exdir/knitro/*.py
mv exdir/knitro knitro
tar -cjf aarch64-apple-darwin.tar.bz2 knitro
rm -rf exdir
rm -rf knitro
rm tmp.zip

mkdir exdir
curl https://files.pythonhosted.org/packages/49/52/39b3c752de920ce41b6bfa47e7732406c734c4d68e0bc0464a595f6cffa9/knitro-15.0.1-py3-none-win_amd64.whl -o tmp.zip
unzip tmp.zip -d exdir
cp exdir/knitro-*/LICENSE exdir/knitro/LICENSE
rm -rf exdir/knitro/scipy
rm -rf exdir/knitro/numpy
rm -rf exdir/knitro/*.py
mv exdir/knitro knitro
tar -cjf x86_64-w64-mingw32.tar.bz2 knitro
rm -rf exdir
rm -rf knitro
rm tmp.zip

mkdir exdir
curl https://files.pythonhosted.org/packages/8a/ea/b172c8c43ebb072fb54fefb5f3b6eb16bc56e2babc66d0e084a3083c3ec4/knitro-15.0.1-py3-none-manylinux1_x86_64.whl -o tmp.zip
unzip tmp.zip -d exdir
cp exdir/knitro-*/licenses/LICENSE exdir/knitro/LICENSE
rm -rf exdir/knitro/scipy
rm -rf exdir/knitro/numpy
rm -rf exdir/knitro/*.py
mv exdir/knitro knitro
tar -cjf x86_64-linux-gnu.tar.bz2 knitro
rm -rf exdir
rm -rf knitro
rm tmp.zip
