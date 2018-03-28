#!/bin/bash -l

# ==============================================
#  Obtain OTUs from clean, unique, high quality reads
# ==============================================

# STEP 1: Concatenate all reads from samples (same primers sets)

cat *uniques* > all_merged.fa

# STEP 2: Dereplicate

usearch -fastx_uniques all_merged.fa -fastaout all_merged_uniques.fa -sizeout -relabel Uniq;

# STEP 3: Make 97% OTUs  ===> This step performs chimera-filtering

usearch -cluster_otus all_merged_uniques.fa -otus otus.fa -uparseout uparse.txt -relabel Otu

# STEP 4: Make OTU tree

$usearch -cluster_agg otus.fa -treeout otus.tree
