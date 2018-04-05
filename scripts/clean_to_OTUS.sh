
module load BBMap
module load usearch/10

# Step 1: Concatenate sequences

cat *.clean.fasta > All.fasta

# Step 2: Generate length histogram 

readlength.sh All.fasta out=histogram_readlenght.txt bin=5;

# Step 3: Obtain fasta unique sequences

usearch -fastx_uniques All.fasta -fastaout uniques.fasta -sizeout -relabel Uniq;

# Step 4: Make 97% OTUs and filter chimeras

usearch -cluster_otus uniques.fasta -otus otus.fa -relabel Otu

# Step 5: Annotate OTUs

usearch -sintax otus.fa -db /rhome/rcastanera/bigdata/Kiel/Database/rdp_16s.udb -tabbedout otus.sintax -strand both -sintax_cutoff 0.8;

# usearch -sintax_summary otus.sintax -output phylum_summary.txt -rank p;


# Step 6: Create OTU Tables: 

for i in *.clean.fasta; do usearch -otutab "$i" -otus otus.fa -otutabout "$i"_otutab.txt -mapout "$i"_map.txt; done;

# Step 7: Normalize to 10,000 reads 


for i in *_otutab.txt; do usearch -otutab_norm "$i" -sample_size 10000 -output "$i"_norm.txt; done


# Step 8: Rename table headers

python /rhome/rcastanera/bigdata/Kiel/scripts/rename_table.py


# Step 9: Transform individual tables to .biom format, and merge with qiime scripts

module unload python
module load qiime

for i in *.txt_norm.txt_renamed; do biom convert -i "$i" -o "$i"_json.biom --table-type="OTU table" --to-json; done

# Step 10: Prepare manually the merge_otu_tables.py command using Sample_IDs.txt


merge_otu_tables.py -i ./F09240-L1_S194_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01749-L1_S243_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09242-L1_S196_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01750-L1_S244_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09243-L1_S197_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01752-L1_S246_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09244-L1_S198_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01753-L1_S247_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09245-L1_S199_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01754-L1_S248_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09247-L1_S201_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01755-L1_S249_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09248-L1_S202_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01756-L1_S250_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09249-L1_S203_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01758-L1_S252_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09250-L1_S204_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01759-L1_S253_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F09251-L1_S205_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01760-L1_S254_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13515-L1_S2_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01761-L1_S255_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13516-L1_S3_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01762-L1_S256_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13518-L1_S5_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01763-L1_S257_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13520-L1_S7_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01764-L1_S258_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13523-L1_S10_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01765-L1_S259_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13524-L1_S11_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01767-L1_S261_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13526-L1_S13_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01768-L1_S262_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13527-L1_S14_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01769-L1_S263_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13528-L1_S15_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01770-L1_S264_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13530-L1_S17_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02843-L1_S189_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13531-L1_S18_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02845-L1_S191_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13532-L1_S19_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02847-L1_S193_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,F13533-L1_S20_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02848-L1_S194_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01708-L1_S202_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02849-L1_S195_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01709-L1_S203_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02850-L1_S196_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01710-L1_S204_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02851-L1_S197_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01711-L1_S205_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02852-L1_S198_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01712-L1_S206_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02853-L1_S199_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01713-L1_S207_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02854-L1_S200_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01715-L1_S209_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02855-L1_S201_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01716-L1_S210_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02856-L1_S202_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01717-L1_S211_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02857-L1_S203_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01718-L1_S212_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02858-L1_S204_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01719-L1_S213_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02859-L1_S205_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01720-L1_S214_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02860-L1_S206_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01721-L1_S215_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02861-L1_S207_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01722-L1_S216_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02862-L1_S208_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01724-L1_S218_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02863-L1_S209_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01725-L1_S219_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02864-L1_S210_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01726-L1_S220_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02866-L1_S212_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01727-L1_S221_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02867-L1_S213_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01728-L1_S222_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02868-L1_S214_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01729-L1_S223_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02869-L1_S215_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01731-L1_S225_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02870-L1_S216_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01732-L1_S226_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02871-L1_S217_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01733-L1_S227_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02872-L1_S218_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01734-L1_S228_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02873-L1_S219_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01735-L1_S229_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02874-L1_S220_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01736-L1_S230_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02876-L1_S222_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01737-L1_S231_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02877-L1_S223_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01738-L1_S232_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02878-L1_S224_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01740-L1_S234_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02879-L1_S225_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01741-L1_S235_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02881-L1_S227_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01742-L1_S236_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02882-L1_S228_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01743-L1_S237_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02883-L1_S229_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01744-L1_S238_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02884-L1_S230_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01745-L1_S239_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02886-L1_S232_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01746-L1_S240_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02888-L1_S234_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01747-L1_S241_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G02889-L1_S235_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom,G01748-L1_S242_L001.clean.fasta_otutab.txt_norm.txt_renamed_json.biom -o Merged_OTU_table.biom
&

# Step 11: Convert to tsv:

biom convert -i Merged_OTU_tableV34.biom -o Merged_OTU_table.txt --to-tsv

# Step 12: Obtain statistics

usearch -sintax_summary otus.sintax -otutabin Merged_OTU_table.txt -rank p -output phylum_summary.txt


# Step 13: Obtain stats from OTU table

usearch -otutab_stats Merged_OTU_table.txt -output v12_OTU_report.txt









