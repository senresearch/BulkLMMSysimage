using BulkLMM
if length(ARGS) < 4
    
    start = time()
    pheno = BulkLMM.DelimitedFiles.readdlm(ARGS[1], ',', header = false);
    pheno_processed = pheno[2:end, 2:(end-1)].*1.0; 
    
    pheno_y = reshape(pheno_processed[:, parse(Int,ARGS[2])], :, 1);

    geno = BulkLMM.DelimitedFiles.readdlm(ARGS[3], ',', header = false);
    geno_processed = geno[2:end, 1:2:end] .* 1.0;

    kinship = calcKinship(geno_processed); 
    preprocessing_time = time() - start

    start = time()
    single_results = scan(pheno_y, geno_processed, kinship);# calculate K
    processing_time = time() - start

    println("σ²: ", single_results.sigma2_e,"\n",
            "h²: ", single_results.h2_null, "\n",
            "preprocessing time: ", preprocessing_time, "\n",
            "processing time: ", processing_time)
    
    
else
    println("4")
end

