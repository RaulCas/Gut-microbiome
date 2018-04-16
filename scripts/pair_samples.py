
#==============================================================================================
# Script for merging results according to sample pairing. Requires:
#
#  -  paired : file with sample pairing information separated by tab:  Sample1	Samplex
#  -  Requires the output tables of usearch "sintax_summary" command (v12 data and v34 data) .
#     Transpose the tables before running the script    
#==============================================================================================

# Read transposed tables with the relative abundances and sample info
v12_file=open('v12data', 'r')
v34_file=open('v34data', 'r')

# Read the file with sample-to-sample info
paired=open('paired', 'r')   

loop1=v12_file.readlines()
loop2=v34_file.readlines()

# Print header
print str(loop1[0]).strip()+'\t'+str(loop2[0]).strip()

# Match the info and print
for line in paired.readlines()[1:]:
	line=line.strip()
	sample_id1=str(line.split('\t')[0]) # v34
	sample_id2=str(line.split('\t')[1]) # v12
	# Iterate over v12 table
	for item in loop1:
		item=item.strip()
		v12_id=item.split('\t')[0]
		if sample_id2 == v12_id:
			# Iterate ovver v34 table
			for elto in loop2:
				elto=elto.strip() 
				v34_id=elto.split('\t')[0]
				#print sample_id1+'   '+v34_id
				if sample_id1 == v34_id:
					print item+'\t'+elto
		
