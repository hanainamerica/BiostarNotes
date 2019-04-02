REF=../../data/2019-4-2/ebola/1976.fa

# get demo data
esearch -db sra -query PRJNA257197 | efetch -format runinfo > runinfo.csv
mkdir raw_data
cd raw_data
fastq-dump -X 10000 --split-files SRR1972739

# alignment
cd ..
R1=raw_data/SRR1972739_1.fastq
R2=raw_data/SRR1972739_2.fastq
# bwa-mem
bwa mem $REF $R1 $R2 > bwa_mem_out.sam
# bowite2
bowtie2 -x $REF -1 $R1 -2 $R2 > bowtie2_out.sam

