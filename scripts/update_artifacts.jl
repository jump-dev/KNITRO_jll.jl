# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

using Tar, Inflate, SHA, TOML

function get_artifact(data)
    file = "$(data.arch)-$(data.name).tar.bz2"
    url = "https://github.com/jump-dev/KNITRO_jll.jl/releases/download/$(data.tag)/$file"
    filename = "/tmp/libknitro/$file"
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
    tag = "v15.0.1-binary"
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
