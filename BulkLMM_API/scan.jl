using BulkLMM
if length(ARGS) < 4

    # ARGS[1] => path of pheno CSV file
    # ARGS[2] => index pheno column
    # ARGS[3] => path of geno CSV file
    
    ##################
    # Pre-processing #
    ##################

    start = time()
    # read pheno
    pheno = BulkLMM.DelimitedFiles.readdlm(ARGS[1], ',', header = false);
    pheno_processed = pheno[2:end, 2:(end-1)].*1.0; 
    
    # select single trait for scanning
    pheno_y = reshape(pheno_processed[:, parse(Int,ARGS[2])], :, 1);

    # read geno
    geno = BulkLMM.DelimitedFiles.readdlm(ARGS[3], ',', header = false);
    geno_processed = geno[2:end, 1:2:end] .* 1.0;

    # compute kinship matrix     
    kinship = calcKinship(geno_processed); 
    preprocessing_time = time() - start


    ##############
    # Processing #
    ##############
    
    start = time()
    single_results = scan(pheno_y, geno_processed, kinship);
    processing_time = time() - start

    ###########
    # Results #
    ###########
    
    println("σ²: ", single_results.sigma2_e,"\n",
            "h²: ", single_results.h2_null, "\n",
            "preprocessing time: ", preprocessing_time, "\n",
            "processing time: ", processing_time)
    
    
else
    println("Check number of arguments")
end
