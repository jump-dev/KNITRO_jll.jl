# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

export libknitro, knitroampl

JLLWrappers.@generate_wrapper_header("Knitro")

JLLWrappers.@declare_library_product(libknitro, "knitro.dll")

JLLWrappers.@declare_executable_product(knitroampl)

function __init__()
    JLLWrappers.@generate_init_header()
    JLLWrappers.@init_library_product(
        libknitro,
        "knitro/lib/knitro.dll",
        RTLD_LAZY | RTLD_DEEPBIND,
    )
    JLLWrappers.@init_executable_product(
        knitroampl,
        "knitro/knitroampl/knitroampl.exe",
    )
    JLLWrappers.@generate_init_footer()
    return
end  # __init__()
