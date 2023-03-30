# BulkLMMSysimage

`BulkLMMSysimage` contains the instructions to generate the `BulkLMM.jl sysimage` and the code of the commands-line functions. 

## Background  

Julia employs a just-in-time (JIT) compiler, which means that computer code is compiled during program execution, or at runtime, rather than before. When a function is called for the first time, Julia compiles it, which can be a time-consuming process. However, subsequent calls to that function within the same session will use the pre-compiled version for faster execution. If Julia is restarted, the compiled work is lost. To minimize this delay, one option is to use `PackageCompiler.jl`, which provides three different workflows. We decided to follow the `sysimage` workflow.

A `sysimage` is a file where we can save our loaded packages and compiled functions that we pass to Julia at the startup. In general, we cannot relocate a `sysimage` to another machine. The sysimage will only work on the machine where we created it.     
We can consider a `sysimage` file as a Julia session serialized to a file. When we start Julia with a `sysimage`, the stored Julia session is deserialized and loaded. By using the `sysimage` file, we expect that this "deserialization" will be faster than having to reload packages and recompile code from scratch.


*Reference:* [PackageCompiler.jl documentation](https://julialang.github.io/PackageCompiler.jl/stable/index.html)



## Synopsis

Let use an example to demonstrate how to create and use a `sysimage`.

The module `MyLineraRegression.jl` contains only one function `my_linear_regression` that takes 3 arguments: location of a dataset in CSV format, the name of a predictor, and the name of the response. It reads the dataset as a dataframe and apply a linear regression from the `GLM` package.


### Building `sysimage`

To generate the `sysimage` start Julia in this directory. To make the number of threads available to Julia you can start julia specifying the number of threads such as:

```
$ julia --threads 4
```

Then, run the following command:

```
julia> include("run_compilation.jl")
```

### Using `sysimage`

Once the `sysimage` is created, we can use our pre-compiled Julia version by using simply the following command line:

- Using sysimage command:
```
julia --project --sysimage=BulkLMM_API.so scan.jl data/bxdData/spleen-pheno-nomissing.csv 1112 data/bxdData/spleen-bxd-genoprob.csv
```

### BulkLMM_API: data


### BulkLMM_API: data





**NOTES:** Since our example uses a local module (i.e. MyLinearRegression), it is necessary to run those command lines from the MyLinearRegression directory. Otherwise, Julia will not recognize MyLinearRegression package/module. In the case we use a package that belongs to the registry or is included in the Project.toml,   we just have to specify the path of the sysimage and/or the script; the `--project` flag should be removed. 

