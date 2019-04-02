# download genome
wget ftp://ftp.ensemblgenomes.org/pub/plants/release-36/fasta/arabidopsis_thaliana/dna/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz
gzip -d Arabidopsis_thaliana.TAIR10.dna.toplevel.fa.gz

# download protein
wget ftp://ftp.ensemblgenomes.org/pub/plants/release-36/fasta/arabidopsis_thaliana/pep/Arabidopsis_thaliana.TAIR10.pep.all.fa.gz
gzip -dArabidopsis_thaliana.TAIR10.pep.all.fa.gz
