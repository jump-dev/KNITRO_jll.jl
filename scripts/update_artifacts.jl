# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

# mkdir /tmp/libknitro
# cd /tmp/libknitro
# mkdir exdir
#
# curl https://files.pythonhosted.org/packages/76/66/936edcd2255055cf6c8a060d1beeb8ce543ef078dceb631caad22a20002a/knitro-15.0.0-py3-none-macosx_13_0_arm64.whl -o tmp.zip
# unzip tmp.zip -d exdir
# cp exdir/knitro-*/licenses/LICENSE exdir/knitro/LICENSE
# rm -rf exdir/knitro/scipy
# rm -rf exdir/knitro/numpy
# rm -rf exdir/knitro/*.py
# mv exdir/knitro knitro
# tar -cjf aarch64-apple-darwin.tar.bz2 knitro
# rm -rf exdir/*
# rm tmp.zip
#
# curl https://files.pythonhosted.org/packages/13/3f/54953373ee3b631640b33b5d4bdb0217bdb1f8514b9374b08348e098ea2a/knitro-15.0.0-py3-none-win_amd64.whl -o tmp.zip
# unzip tmp.zip -d exdir
# cp exdir/knitro-*/LICENSE exdir/knitro/LICENSE
# rm -rf exdir/knitro/scipy
# rm -rf exdir/knitro/numpy
# rm -rf exdir/knitro/*.py
# mv exdir/knitro knitro
# tar -cjf x86_64-w64-mingw32.tar.bz2 knitro
#
# curl https://files.pythonhosted.org/packages/76/6e/ffe880b013ad244f0fd91940454e4f2bf16fa01e74c469e1b0fb75eda12a/knitro-15.0.0-py3-none-manylinux1_x86_64.whl -o tmp.zip
# unzip tmp.zip -d exdir
# cp exdir/knitro-*/licenses/LICENSE exdir/knitro/LICENSE
# rm -rf exdir/knitro/scipy
# rm -rf exdir/knitro/numpy
# rm -rf exdir/knitro/*.py
# mv exdir/knitro knitro
# tar -cjf x86_64-linux-gnu.tar.bz2 knitro


using Tar, Inflate, SHA, TOML

function get_artifact(data)
    filename = "$(data.arch)-$(data.name).tar.bz2"
    url = "https://github.com/jump-dev/KNITRO_jll.jl/releases/download/$(data.tag)/$filename"
    run(`curl $url -o $filename`)
    ret = Dict(
        "git-tree-sha1" => Tar.tree_hash(`gzcat $filename`),
        "arch" => data.arch,
        "os" => data.os,
        "download" => Any[
            Dict("sha256" => bytes2hex(open(sha256, filename)), "url" => url),
        ]
    )
    rm(filename)
    return ret
end

function main()
    tag = "v15.0.0-binary"
    platforms = [
        (os = "linux", arch = "x86_64", name = "linux-gnu", tag = tag),
        (os = "macos", arch = "aarch64", name = "apple-darwin", tag = tag),
        (os = "windows", arch = "x86_64", name = "w64-mingw32", tag = tag),
    ]
    output = Dict("KNITRO" => get_artifact.(platforms))
    open(joinpath(dirname(@__DIR__), "Artifacts.toml"), "w") do io
        return TOML.print(io, output)
    end
    return
end

main()
