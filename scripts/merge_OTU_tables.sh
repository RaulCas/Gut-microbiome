#!/bin/bash -l

module unload python
module load qiime

# Install "biom-format": sudo pip install biom-format

# Convert .txt to .biom format

biom convert -i G13027_otutab_norm.txt -o G13027_json.biom --table-type="OTU table" --to-json
biom convert -i G13028_otutab_norm.txt -o G13028_json.biom --table-type="OTU table" --to-json

# Use quimee script to merge tables

merge_otu_tables.py -i G13027_json.biom,G13028_json.biom -o merged_otu_table.biom

# Convert back to .txt

biom convert -i merged_otu_table.biom -o OTU_table.merged.txt --to-tsv

# Get some stats from the table

usearch -otutab_stats OTU_table.merged.txt -output report.txt
