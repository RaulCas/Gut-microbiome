#!/bin/bash

#============================================================================================
# Script to remove Shewanella and Halomonas contaminants from bile datasets (low input DNA)
#	
# REQUIRES: "clean_reads.fasta" and "clean_reads.sintax" files 
#
# USAGE: Place all files from multiple samples in the same folder and run the script  
#============================================================================================

module unload python
module load qiime

for i in *.clean.sintax; do grep -v -E 'Shewanella|Halomonas' "$i" > "$i"_filtered; done;
for i in *.clean.sintax; do grep -E 'Shewanella|Halomonas' "$i" > "$i"_discarded; done;
for i in *.clean.sintax_filtered; do less "$i" | awk '{print $1}' > "$i"_IDretain.txt; done;

# Rename fastas for running the following qiime script in all samples at once

for i in *.clean.fasta; do mv "$i" "${i%.clean.fasta}.clean"; done;  


# Extract good seqs from .clean files, using "_IDretain.txt" IDs as reference
  
for i in *.clean; do filter_fasta.py -f "$i" -o "$i"_filtered.fasta -s "$i".sintax_filtered_IDretain.txt; done; 

# Move intermediate files to new folder

mkdir temp_files;
mv *.sintax_filtered_IDretain.txt temp_files;
mv *.sintax_discarded temp_files;
mv *.clean temp_files;
mv *clean.sintax* temp_files;
cd temp_files;

# Rename fastas back too their original name

for i in *.clean; do mv "$i" "${i%.clean}.clean.fasta"; done;   

