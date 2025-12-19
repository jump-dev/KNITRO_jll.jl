#!/bin/bash
#
# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

if ! command -v pip &> /dev/null; then
    echo "Error: pip is not installed or not in PATH"
    echo "Please install pip before running this script"
    exit 1
fi

KNITRO_VERSION="15.1.0"

# Platform configuration: platform -> "pip_platform|license_path|min_version"
declare -A PLATFORM_CONFIG
PLATFORM_CONFIG["aarch64-apple-darwin"]="macosx_13_0_arm64|licenses/LICENSE|15.0.0"
PLATFORM_CONFIG["x86_64-w64-mingw32"]="win_amd64|LICENSE|15.0.0"
PLATFORM_CONFIG["x86_64-linux-gnu"]="manylinux_2_28_x86_64|licenses/LICENSE|15.0.0"
PLATFORM_CONFIG["aarch64-linux-gnu"]="manylinux_2_28_aarch64|licenses/LICENSE|15.1.0"

version_gte() {
    local v1=$1
    local v2=$2
    if [ "$(printf '%s\n' "$v2" "$v1" | sort -V | head -n1)" = "$v2" ]; then
        return 0
    else
        return 1
    fi
}

process_platform() {
    local platform=$1
    local config="${PLATFORM_CONFIG[$platform]}"

    IFS='|' read -r pip_platform license_path min_version <<< "$config"

    if ! version_gte "$KNITRO_VERSION" "$min_version"; then
        echo "Skipping $platform: KNITRO_VERSION $KNITRO_VERSION < MIN_VERSION $min_version"
        return
    fi

    echo "Processing $platform (KNITRO_VERSION $KNITRO_VERSION >= MIN_VERSION $min_version)"
    mkdir exdir
    pip download --only-binary=:all: --platform "$pip_platform" --no-deps --dest . "knitro==$KNITRO_VERSION"
    unzip knitro-*.whl -d exdir
    cp exdir/knitro-*/"$license_path" exdir/knitro/LICENSE
    rm -rf exdir/knitro/scipy
    rm -rf exdir/knitro/numpy
    rm -rf exdir/knitro/*.py
    mv exdir/knitro knitro
    tar -cjf "$platform.tar.bz2" knitro
    rm -rf exdir
    rm -rf knitro
    rm knitro-*.whl
}

mkdir /tmp/libknitro
cd /tmp/libknitro

for platform in "${!PLATFORM_CONFIG[@]}"; do
    process_platform "$platform"
done
