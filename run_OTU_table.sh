#!/bin/bash -l

# ================================
# continue with single samples
# ================================


# STEP 1: Create OTU Tables: #### """ Repeat this Step for all samples """ ####

usearch -otutab /bigdata/castaneralab/rcastanera/Kiel/G09001/out.extendedFrags.fastq -otus otus.fa -otutabout G09001_otutab.txt -mapout G09001_map.txt

# STEP 2: Normalize to 10,000 reads #### """ Repeat this Step for all samples """ ####

usearch -otutab_norm G09001_otutab.txt -sample_size 10000 -output G09001_norm.txt





