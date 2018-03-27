#!/bin/bash

################################################################
#
# USAGE: bash 16Spipeline_v1_v2.sh R1.fastq R2.fastq indexname
#
################################################################


module load fastqc
module load flash
module load BBMap
module load usearch/10
module load seqtk

# Step 1: FastQC

fastqc $1 $2;

# Step 2: Assemble paired reads with FLASH

flash $1 $2 --max-overlap 300 2>&1 | tee flash.log;
fastqc out.extendedFrags.fastq;

# Step 3: Quality and lenght trimming 

usearch --fastq_filter out.extendedFrags.fastq --fastq_maxee 1 --fastqout out.extendedFrags_maxee1.fastq

bbduk.sh -Xmx1g in1=out.extendedFrags_maxee1.fastq out1=out.extendedFrags_clean_q20_280_345.fastq qtrim=r trimq=30 minlength=280 maxlength=345;
fastqc out.extendedFrags_clean_q20_280_345.fastq;

# Step 4:Create histogram of read length

readlength.sh out.extendedFrags_clean_q20_280_345.fastq out=histogram_readlenght.txt bin=5;

# Step 5: Convert from Fastq to fasta using seqtk

seqtk seq -a out.extendedFrags_clean_q20_280_345.fastq > clean_q20_280_345.fasta;

# Step 6: Obtain fasta unique sequences

usearch -fastx_uniques clean_q20_280_345.fasta -fastaout uniques.fasta -sizeout -relabel Uniq;

# Step 7 annotate and summarize (all) sequences

usearch -sintax clean_q20_280_345.fasta -db /rhome/rcastanera/bigdata/Kiel/Database/rdp_16s.udb -tabbedout clean_q20_280_345.sintax -strand both -sintax_cutoff 0.8;

usearch -sintax_summary clean_q20_280_345.sintax -output phylum_summary.txt -rank p;


# Step 8 rename file and copy sequences to common fasta folder

rename clean_q20_280_345.fasta $3.all.fasta clean_q20_280_345.fasta;
rename uniques.fasta $3.uniques.fasta uniques.fasta;

cp *.fasta /rhome/rcastanera/bigdata/Kiel/OTUS


