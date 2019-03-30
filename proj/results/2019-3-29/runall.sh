DATA=../../data/2019-3-29

mkdir -p results1 results2

# summary
seqkit stat $DATA/*.gz > results1/stat.txt

# gc
seqkit fx2tab --name --only-id --gc $DATA/viral.1.*fna.gz > results1/gc.txt

# subset
# get id randomly
seqkit sample --proportion 0.001 $DATA/duplicated-reads.fq.gz | seqkit seq --only-id --name > results1/id.txt
# get sequences according id
seqkit grep --pattern-file results1/id.txt $DATA/duplicated-reads.fq.gz > results1/duplicated-reads.subset.fq


# generate an XML report on data
sra-stat --xml --quick SRR1553610 > results2/report.txt 2>log.txt

# get read length statistics on PacBio
sra-stat --xml --statistics SRR4237168 > results2/length.txt 2>log.txt
