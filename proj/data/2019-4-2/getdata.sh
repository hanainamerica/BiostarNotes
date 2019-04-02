mkdir -p ebola
efetch -db=nuccore -format=fasta -id=AF086833 > ebola/1976.fa

# or download from ncbi
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/848/505/GCF_000848505.1_ViralProj14703/GCF_000848505.1_ViralProj14703_genomic.fna.gz


