using BulkLMM

if length(ARGS) ==  3
    npermutations = 1000;
    include_original = false;
elseif length(ARGS) == 5
    npermutations = parse(Int, ARGS[4]);
    include_original = parse(Bool, ARGS[5];
else
    error("Wrong number of arguments.")
end 
    
start = time()
pheno = BulkLMM.DelimitedFiles.readdlm(ARGS[1], ',', header = false);
pheno_processed = pheno[2:end, 2:(end-1)].*1.0; 
    
pheno_y = reshape(pheno_processed[:, parse(Int,ARGS[2])], :, 1);
geno = BulkLMM.DelimitedFiles.readdlm(ARGS[3], ',', header = false);
geno_processed = geno[2:end, 1:2:end] .* 1.0;

kinship = calcKinship(geno_processed); 
preprocessing_time = time() - start

start = time()
single_results_perms = scan_perms_lite(pheno_y, geno_processed, kinship; 
                                       nperms = npermutations, original = include_original));
processing_time = time() - start

println("preprocessing time: ", preprocessing_time, "\n",
        "processing time: ", processing_time)


