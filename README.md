# Gut-microbiome



Dependencies:

- fastqc
- flash
- BBMap
- usearch/10
- qimee
- seqtk
- biom-format



USAGE:

1- Run the first step of the pipeline on paired reads to obtain clean sequences:

bash 16Spipeline_v1_v2.sh R1.fastq R2.fastq Sample_name   ---- For v1-v2 region

bash 16Spipeline_v3_v4.sh R1.fastq R2.fastq Sample_name   ---- For v3-v4 region

2- Run steps 1 to 9 of "clean_to_OTUS.sh" in batch.

3- Manually prepare and run the command of step 10 in  "clean_to_OTUS.sh".

4- Run the rest of commands of "clean_to_OTUS.sh" in batch.

