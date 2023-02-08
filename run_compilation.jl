using PackageCompiler, Pkg

cd("BulkLMM_API");

Pkg.activate(".")

PackageCompiler.create_sysimage(:BulkLMM_API;
                                  sysimage_path="BulkLMM_API.so",
                                  precompile_execution_file="precompiling_script.jl")