REF=../../data/2019-4-2/ebola/1976.fa

dwgsim -N 100000 -e 0.01 -E 0.01 $REF data
R1=data.bwa.read1.fastq
R2=data.bwa.read2.fastq
time bwa mem $REF $R1 $R2 > bwa.sam
samtools flagstat bwa.sam
# 4s 94.96% 
time bowtie2 -x $REF -1 $R1 -2 $R2 > bowtie2.sam
# 11s 94.76%


dwgsim -N 100000 -e 0.1 -E 0.1 $REF data
R1=data.bwa.read1.fastq
R2=data.bwa.read2.fastq
time bwa mem $REF $R1 $R2 > bwa.sam
samtools flagstat bwa.sam
# 7s 83.00%
time bowtie2 -x $REF -1 $R1 -2 $R2 > bowtie2.sam
# 4s 29.17% 
