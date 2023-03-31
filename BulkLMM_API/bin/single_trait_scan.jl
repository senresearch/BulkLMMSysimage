using BulkLMM, CSV, Tables

# ARGS[1] => path of pheno CSV file
# ARGS[2] => path of geno CSV file
# ARGS[3] => path of kinship CSV file
# ARGS[3] => path of output LOD CSV file


###########
# Reading #
###########

# check path
realpath.(ARGS[1:3]);

start = time()
# read single_trait pheno
pheno = BulkLMM.DelimitedFiles.readdlm(ARGS[1], ',', header = false, Float64);

# read geno
geno = BulkLMM.DelimitedFiles.readdlm(ARGS[2], ',', header = false, Float64);

# compute kinship matrix     
kinship = BulkLMM.DelimitedFiles.readdlm(ARGS[3], ',', header = false, Float64);

reading_time = time() - start



if length(ARGS) == 4
   
    ##############
    # Processing #
    ##############
    
    start = time()
    single_results = scan(pheno, geno, kinship);
    processing_time = time() - start
    
    start = time()
    CSV.write(ARGS[4], Tables.table(single_results.lod), header = false);
    writing_time = time() - start

    println(
        "σ²: ", single_results.sigma2_e,"\n",
        "h²: ", single_results.h2_null, "\n",
    )

elseif length(ARGS) < 7
    
    start = time()
    single_results = scan(pheno, geno, kinship; 
                            permutation_test = true,
                            nperms = parse(Int, ARGS[5]),
                            original = true);
    processing_time = time() - start

    ###########
    # Results #
    ###########
    start = time()
    CSV.write(ARGS[4], Tables.table(single_results), header = false);
    writing_time = time() - start
    
else
    println("Check number of arguments ", length(ARGS))
end


println(
        "reading time: ", reading_time, "\n",
        "processing time: ", processing_time,
        "writing time: ", writing_time
)