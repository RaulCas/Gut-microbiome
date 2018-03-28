#!/bin/bash -l

# ================================
# Run this step in every sample
# ================================


# STEP 1: Create OTU Tables: 

usearch -otutab /bigdata/castaneralab/rcastanera/Kiel/G09001/G09002.all.fasta -otus otus.fa -otutabout G09001_otutab.txt -mapout G09001_map.txt

# STEP 2: Normalize to 10,000 reads 

usearch -otutab_norm G09001_otutab.txt -sample_size 10000 -output G09001_norm.txt





