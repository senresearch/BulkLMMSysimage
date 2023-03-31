#!/bin/bash
# chmod u+x cmdtest.sh
julia --project --sysimage=bin/BulkLMM_API.so bin/single_trait_scan.jl data/preprocessed/single_trait.csv data/preprocessed/geno.csv data/preprocessed/kinship.csv data/output/lod_1.csv 1000 