# Example: application on BXD spleen expression data

using BulkLMM
using CSV, DelimitedFiles, DataFrames, Statistics

bulklmmdir = dirname(pathof(BulkLMM));
pheno_file = joinpath(bulklmmdir,"..","data/bxdData/spleen-pheno-nomissing.csv");
pheno = readdlm(pheno_file, ',', header = false);
pheno_processed = pheno[2:end, 2:(end-1)].*1.0; # exclude the header, the first (transcript ID)and the last columns (sex)

geno_file = joinpath(bulklmmdir,"..","data/bxdData/spleen-bxd-genoprob.csv");
geno = BulkLMM.DelimitedFiles.readdlm(geno_file, ',', header = false);
geno_processed = geno[2:end, 1:2:end] .* 1.0;

# Compute the kinship matrix from the genotype probabilities using the function calcKinship
kinship = calcKinship(geno_processed); # calculate K


# Single trait scanning:
traitID = 1112;
pheno_y = reshape(pheno_processed[:, traitID], :, 1);

@time single_results = scan(pheno_y, geno_processed, kinship);

# VCs: environmental variance, heritability, genetic_variance/total_variance
(single_results.sigma2_e, single_results.h2_null)