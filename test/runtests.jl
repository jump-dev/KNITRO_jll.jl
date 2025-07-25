# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

using Test

using KNITRO_jll

@testset "is_available" begin
    @test KNITRO_jll.is_available()
end

@testset "libknitro" begin
    @test KNITRO_jll.libknitro_path isa String
    length = 15
    release = zeros(Cchar, length)
    GC.@preserve release begin
        @ccall libknitro.KN_get_release(length::Cint, release::Ptr{Cchar})::Cint
        @test unsafe_string(pointer(release)) == "Knitro 15.0.0"
    end
end

@testset "knitroampl" begin
    @test KNITRO_jll.knitroampl_path isa String
    contents = sprint() do io
        try
            run(pipeline(`$(knitroampl()) -v`; stdout = io))
        catch
        end
    end
    @test occursin("Knitro 15.0.0", contents)
end
