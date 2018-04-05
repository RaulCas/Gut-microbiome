#=======================================================================================================================================
#  This script renames the header in single OTU Tables, prior to transforming to .biom and running merge_otu_tables.py script from qiime
#  Uses information of the filename (split by '-') to add it as header in the second column
#=======================================================================================================================================

import os

for filename in os.listdir("."):
	if filename.endswith(".txt_norm.txt"):
		working=open(filename, 'r')
		outfile=open(filename+"_renamed", 'w')
		newfilename=str(filename.split('-')[0])
		newheader="OTU ID "+str(newfilename)
		outfile.write(newheader+'\n')
		for line in working.readlines()[1:]:
			outfile.write(line)
		outfile.close()
