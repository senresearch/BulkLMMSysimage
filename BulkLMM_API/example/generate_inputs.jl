# Scripts to generate inputs for example
using BulkLMM, CSV, Tables

bulklmmdir = dirname(pathof(BulkLMM));

##################
# Pre-processing #
##################

# read pheno
pheno_file = joinpath(bulklmmdir,"..","data/bxdData/spleen-pheno-nomissing.csv");
pheno = BulkLMM.DelimitedFiles.readdlm(pheno_file, ',', header = false);
pheno_processed = pheno[2:end, 2:(end-1)].*1.0;# exclude the header, the first (transcript ID)and the last columns (sex)

# Single trait scanning:
traitID = 1112;
pheno_y = reshape(pheno_processed[:, traitID], :, 1);

# read geno
geno_file = joinpath(bulklmmdir,"..","data/bxdData/spleen-bxd-genoprob.csv")
geno = BulkLMM.DelimitedFiles.readdlm(geno_file, ',', header = false);
geno_processed = geno[2:end, 1:2:end] .* 1.0;

# Compute the kinship matrix from the genotype probabilities
kinship = calcKinship(geno_processed); # calculate K

#################
# Save matrices #
#################


fwrite_mat(path_file, dat) = CSV.write(
    path_file,
    Tables.table(dat), 
    header = false
);

fwrite_mat(
    joinpath(@__DIR__,"..","data/preprocessed/pheno.csv"),
    pheno_processed
)

fwrite_mat(
    joinpath(@__DIR__,"..","data/preprocessed/geno.csv"),
    geno_processed
)

fwrite_mat(
    joinpath(@__DIR__,"..","data/preprocessed/single_trait.csv"),
    pheno_y
)

fwrite_mat(
    joinpath(@__DIR__,"..","data/preprocessed/kinship.csv"),
    kinship
)


