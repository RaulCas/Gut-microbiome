
# ==============================================
#  Obtain OTUs from clean, unique, quality reads
# ==============================================

# STEP 1: Concatenate all reads from samples (same primers sets)

cat *uniques* > all_merged.fa

# STEP 2: Dereplicate

usearch -fastx_uniques all_merged.fa -fastaout all_merged_uniques.fa -sizeout -relabel Uniq;

# STEP 3: Make 97% OTUs  ===> This step performs chimera-filtering

usearch -cluster_otus all_merged_uniques.fa -otus otus.fa -uparseout uparse.txt -relabel Otu

# STEP 4: Make OTU tree

$usearch -cluster_agg otus.fa -treeout otus.tree

# ================================
# Now continue with single samples
# ================================


# STEP 4: Create OTU Table:  Input should be reads before quality filtering and before discarding low-abundance unique sequences, e.g. singletons. This will improve sensitivity, because many low-quality and low-abundance reads will map successfully to OTUs

usearch -otutab /bigdata/castaneralab/rcastanera/Kiel/G09001/out.extendedFrags.fastq -otus otus.fa -otutabout G09001_otutab.txt -mapout G09001_map.txt

# STEP 5: Normalize to 10,000 reads

usearch -otutab_norm G09001_otutab.txt -sample_size 10000 -output G09001_norm.txt

# Alpha diversity
$usearch -alpha_div otutab.txt -output alpha.txt


# Beta diversity

mkdir beta/
$usearch -beta_div otutab.txt -tree otus.tree -filename_prefix beta/

# Rarefaction
$usearch -alpha_div_rare otutab.txt -output rare.txt

# Predict taxonomy
$usearch -sintax otus.fa -db ../data/rdp_16s_v16.fa -strand both \
  -tabbedout sintax.txt -sintax_cutoff 0.8

# Taxonomy summary reports
$usearch -sintax_summary sintax.txt -otutabin otutab.txt -rank g -output genus_summary.txt
$usearch -sintax_summary sintax.txt -otutabin otutab.txt -rank p -output phylum_summary.txt

