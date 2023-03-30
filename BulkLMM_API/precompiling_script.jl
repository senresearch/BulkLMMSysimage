using BulkLMM
bulklmmdir = dirname(pathof(BulkLMM));
include(realpath(joinpath(bulklmmdir, "..", "test", "runtests.jl")))

# TODO add CVS write and TABLEs

# geno_file = joinpath(bulklmmdir,"..","data/bxdData/spleen-bxd-genoprob.csv");
# geno = BulkLMM.DelimitedFiles.readdlm(geno_file, ',', header = false);
# geno_processed = geno[2:end, 1:2:end] .* 1.0;
# knshp = calcKinship(geno_processed); 