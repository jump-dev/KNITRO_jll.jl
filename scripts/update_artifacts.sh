#!/bin/bash
#
# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

mkdir /tmp/libknitro
cd /tmp/libknitro

mkdir exdir

curl https://files.pythonhosted.org/packages/35/b4/2fe70abca447113efdbda7bea2f87d55e4aa1101da7da2af4437014d6059/knitro-15.1.0-py3-none-macosx_13_0_arm64.whl -o tmp.zip
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
curl https://files.pythonhosted.org/packages/da/c5/543ec0e5f11ed965ac59e6003eeecbf8d7c6201baade717981bbd59950c5/knitro-15.1.0-py3-none-win_amd64.whl -o tmp.zip
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
curl https://files.pythonhosted.org/packages/0d/de/dc56dd6c368fdcda8227c026d792095e1b49f9d3ef6ebccc3b2118a92147/knitro-15.1.0-py3-none-manylinux_2_28_x86_64.whl -o tmp.zip
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

mkdir exdir
curl https://files.pythonhosted.org/packages/53/c4/716861f408ca9cd6d25e36ee81f369ba7f7e84cbfa458c830f4abb2b3954/knitro-15.1.0-py3-none-manylinux_2_28_aarch64.whl -o tmp.zip
unzip tmp.zip -d exdir
cp exdir/knitro-*/licenses/LICENSE exdir/knitro/LICENSE
rm -rf exdir/knitro/scipy
rm -rf exdir/knitro/numpy
rm -rf exdir/knitro/*.py
mv exdir/knitro knitro
tar -cjf aarch64-linux-gnu.tar.bz2 knitro
rm -rf exdir
rm -rf knitro
rm tmp.zip
