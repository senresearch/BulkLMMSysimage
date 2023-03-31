using BulkLMM, CSV, Tables

bulklmmdir = dirname(pathof(BulkLMM));

include(realpath(joinpath(bulklmmdir, "..", "test", "runtests.jl")))

mat = rand(2,2);
path_file = joinpath(@__DIR__, "tmp.csv")
CSV.write(path_file, Tables.table(mat), header = false);
rm(path_file, force = true)
