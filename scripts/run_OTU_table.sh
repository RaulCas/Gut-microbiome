#!/bin/bash -l

# ================================
# Run this step in every sample
# ================================


# STEP 1: Create OTU Tables: 

for i in *.clean.fasta; do usearch -otutab "$i" -otus otus.fa -otutabout "$i"+_otutab.txt -mapout "$i"+_map.txt; done

# STEP 2: Normalize to 10,000 reads 

usearch -otutab_norm G09001_otutab.txt -sample_size 10000 -output G09001_norm.txt





