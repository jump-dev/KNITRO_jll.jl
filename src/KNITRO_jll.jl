# Copyright (c) 2025 Oscar Dowson, and contributors
#
# Use of this source code is governed by an MIT-style license that can be found
# in the LICENSE.md file or at https://opensource.org/licenses/MIT.

# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule KNITRO_jll

using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("KNITRO")

JLLWrappers.@generate_main_file("KNITRO", UUID("0e6b36f8-8e90-4eb5-b54e-06f667ea875c"))

end  # module KNITRO_jll
