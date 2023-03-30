using BulkLMM, CSV, Tables
if length(ARGS) == 4

    # ARGS[1] => path of pheno CSV file
    # ARGS[2] => path of geno CSV file
    # ARGS[3] => path of kinship CSV file
    # ARGS[3] => path of output LOD CSV file
    
    ##################
    # Pre-processing #
    ##################

    start = time()
    # read single_trait pheno
    pheno = BulkLMM.DelimitedFiles.readdlm(ARGS[1], ',', header = false, Float64);
    
    # read geno
    geno = BulkLMM.DelimitedFiles.readdlm(ARGS[2], ',', header = false, Float64);
    
    # compute kinship matrix     
    kinship = BulkLMM.DelimitedFiles.readdlm(ARGS[3], ',', header = false, Float64);

    reading_time = time() - start
    
    ##############
    # Processing #
    ##############
    
    start = time()
    single_results = scan(pheno, geno, kinship);
    processing_time = time() - start

    ###########
    # Results #
    ###########
    start = time()
    CSV.write(ARGS[4], Tables.table(single_results.lod), header = false);
    writing_time = time() - start
    
    println("σ²: ", single_results.sigma2_e,"\n",
            "h²: ", single_results.h2_null, "\n",
            "reading time: ", reading_time, "\n",
            "processing time: ", processing_time,
            "writing time: ", writing_time
            )
    
    
else
    println("Check number of arguments ", length(ARGS))
end
