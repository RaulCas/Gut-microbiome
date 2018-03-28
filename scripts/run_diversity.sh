#!/bin/bash -l


# =================================================
# Create final OTU TABLE and run diversity analyses
# =================================================

# Merge all otu tables into single one using "merge_OTU_tables.sh"

bash merge_OTU_tables.sh 


# Alpha diversity
usearch -alpha_div otutab.txt -output alpha.txt

# Beta diversity

mkdir beta/
usearch -beta_div otutab.txt -tree otus.tree -filename_prefix beta/

# Rarefaction
usearch -alpha_div_rare otutab.txt -output rare.txt

# Predict taxonomy
usearch -sintax v3_4_otus.fa -db /rhome/rcastanera/bigdata/Kiel/Database/rdp_16s.udb -strand both -tabbedout v3_4_otus_sintax.txt -sintax_cutoff 0.8

# Taxonomy summary reports
$usearch -sintax_summary sintax.txt -otutabin otutab.txt -rank g -output genus_summary.txt
$usearch -sintax_summary sintax.txt -otutabin otutab.txt -rank p -output phylum_summary.txt
