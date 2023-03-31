using PackageCompiler, Pkg

cd("BulkLMM_API");

Pkg.activate(".")

PackageCompiler.create_sysimage(:BulkLMM_API;
                                  sysimage_path="bin/BulkLMM_API.so",
                                  precompile_execution_file="precompile/precompiler.jl")