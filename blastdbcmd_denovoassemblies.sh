#!/bin/bash

### Blast script where $1=input file with coordinates to extract
### and $2 is the outputfile name you would like to use
### 

Fastafile=$1
echo Start!
while read line; do
#echo "blastdbcmd -db ~/Genomes/IPO323/IPO323_BLAST_DB "$line" "
blastdbcmd -db ~/Genomes/IPO323/IPO323_BLAST_DB $line
done <$Fastafile >$2.fa
echo Finished!

#blastdbcmd_denovoassemblies.sh WAI320_intersect_exononlyzero_blastcmd.txt WAI320exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI321_intersect_exononlyzero_blastcmd.txt WAI321exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI322_intersect_exononlyzero_blastcmd.txt WAI322exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI323_intersect_exononlyzero_blastcmd.txt WAI323exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI324_intersect_exononlyzero_blastcmd.txt WAI324exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI326_intersect_exononlyzero_blastcmd.txt WAI326exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI327_intersect_exononlyzero_blastcmd.txt WAI327exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI328_intersect_exononlyzero_blastcmd.txt WAI328exon_IPOintersect_zercov
#blastdbcmd_denovoassemblies.sh WAI329_intersect_exononlyzero_blastcmd.txt WAI329exon_IPOintersect_zercov
