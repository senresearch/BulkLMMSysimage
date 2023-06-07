# BulkLMMSysimage

`BulkLMMSysimage` includes instructions for generating the `BulkLMM.jl` sysimage along with the code for the command-line functions.

## Background  

Julia employs a just-in-time (JIT) compiler, which means that computer code is compiled during program execution, or at runtime, rather than before. When a function is called for the first time, Julia compiles it, which can be a time-consuming process. However, subsequent calls to that function within the same session will use the pre-compiled version for faster execution. If Julia is restarted, the compiled work is lost. To minimize this delay, one option is to use `PackageCompiler.jl`, which provides three different workflows. We decided to follow the `sysimage` workflow.

A `sysimage` is a file where we can save our loaded packages and compiled functions that we pass to Julia at the startup. In general, we cannot relocate a `sysimage` to another machine. The sysimage will only work on the machine where we created it.     
We can consider a `sysimage` file as a Julia session serialized to a file. When we start Julia with a `sysimage`, the stored Julia session is deserialized and loaded. By using the `sysimage` file, we expect that this "deserialization" will be faster than having to reload packages and recompile code from scratch.


*Reference:* [PackageCompiler.jl documentation](https://julialang.github.io/PackageCompiler.jl/stable/index.html)



## Synopsis

### Building `sysimage`

To generate the `sysimage` start Julia in this directory. 
```
BulkLMMSysimage$ julia
```

To make the number of threads available to Julia you can start julia specifying the number of threads such as:

```
BulkLMMSysimage$ julia --threads 4
```

Then, run the following command in Julia to build the `BulkLMM_API.so` sysimage:

```
julia> include("run_compilation.jl")
```

### Using `sysimage`

Once the `sysimage` is created, we can use our pre-compiled Julia version by using simply the following command line, assuming that we are in the `BulkLMM_API` directory:   


> julia --project --sysimage=<sysimage_path> <scan_function_path > <phenotype_file_path> <genotype_file_path> <kinship_file_path> <output_lod_file_path> <number_of_permutation>

#### Example
- Without permutations:
```
julia --project --sysimage=bin/BulkLMM_API.so bin/single_trait_scan.jl data/preprocessed/single_trait.csv data/preprocessed/geno.csv data/preprocessed/kinship.csv data/output/lod_1.csv
```

- With permutations:   
```
julia --project --sysimage=bin/BulkLMM_API.so bin/single_trait_scan.jl data/preprocessed/single_trait.csv data/preprocessed/geno.csv data/preprocessed/kinship.csv data/output/lod_1.csv 1000 
```




**NOTES:** In the case we use a package that belongs to the registry or is included in the Project.toml, we just have to specify the path of the sysimage and/or the script; the `--project` flag should be removed. 

