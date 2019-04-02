DATA=../../data/2019-4-1

# build database
makeblastdb -in $DATA/Arobidopsis_thaliana.TAIR10.dna.toplevel.fa -dbtype nucl -out TAIR10 -parse_seqids
makeblastdb -in $DATA/Arobidopsis_thaliana.TAIR10.pep.all.fa -dbtype prot -out TAIR10 -parse_seqids

echo '>test' > query.fa
echo TGAAAGCAAGAAGAGCGTTTGGTGGTTTCTTAACAAATCATTGCAACTCCACAAGGCGCCTGTAATAGACAGCTTGTGCATGGAACTTGGTCCACAGTGCCCTACCACTGATGATGTTGATATCGGAAAGTGGGTTGCAAAAGCTGTTGATTGTTTGGTGATGACGCTAACAATCAAGCTCCTCTGGT >> query.fa

# local database
blastn -db TAIR10 -query query.fa > blastn.txt
blastn -db TAIR10 -query query.fa -query_loc 20-100 >> blastn.txt
# remote database
blastn -db nr -remote -query query.fa
blastn -db nt -remote -query query.fa

# -outfmt
blastn -task blastn -remote -db nr -query query.fa -outfmt 7 -out query.txt
head -n 15 query.txt


