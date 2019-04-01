# human/chr22.fa
curl http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr22.fa.gz | gunzip > chr22.fa

# KU182908.fa
efetch -id KU182908 -db nucleotide -format fasta > KU182908.fa

# get all genomes from the ebola project
esearch -db nuccore -query PRJNA257197 | efetch -format fasta > ebola.fa

