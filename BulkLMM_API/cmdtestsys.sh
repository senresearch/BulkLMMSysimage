#!/bin/bash
# chmod u+x cmdtest.sh
julia --project --sysimage=BulkLMM_API.so scan.jl data/bxdData/spleen-pheno-nomissing.csv 1112 data/bxdData/spleen-bxd-genoprob.csv
