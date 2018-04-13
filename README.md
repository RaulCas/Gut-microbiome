# Gut-microbiome



## Dependencies:

- fastqc
- flash
- BBMap
- usearch/10
- qimee
- seqtk
- SLURM




## Usage:

1- Run the first step of the pipeline on paired reads to obtain clean sequences:

*bash 16Spipeline_v1_v2.sh R1.fastq R2.fastq Sample_name*   (For v1-v2 region)

*bash 16Spipeline_v3_v4.sh R1.fastq R2.fastq Sample_name*    (For v3-v4 region)

2- Place all sintax and clean fastas in the same folder and remove contaminants (only if necessary):

*bash remove_contaminants.sh*

3- Run steps 1 to 9 of "clean_to_OTUS.sh" in batch.

4- Manually prepare and run the step 10 command of  "clean_to_OTUS.sh".

5- Run the rest of commands of "clean_to_OTUS.sh" in batch.

6- Run the diversity analysis commands (run_diversity.sh)

7- After obtaining OTU abundances, diversity analyses, etc, run "pair_samples.py" to compare results of the different primer sets

