REF=ebola/1976.fa

# bwa
bwa index $REF

# bowtie2
bowtie2-build $REF $REF
