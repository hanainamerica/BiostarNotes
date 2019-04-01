DATA=../../data/2019-3-30

mkdir -p results1 results2 results3

# check chr22.fa by egrep
tail -n 1000 $DATA/chr22.fa | head -n 20 | tr -d '\n' | egrep -o -i 'TAATA' > results1/taata.txt

# check chr22.fa by emboss/dreg
tail -n 1000 $DATA/chr22.fa | head -n 5 | dreg -filter -pattern 'TAATA' >> results1/taata.txt
# looking for TTAGGG replications
cat $DATA/chr22.fa | dreg -filter -pattern '(TTAGGG){20,30}' > results1/ttaggg.txt

# count k-mers, -C*Count both strand, -m*Length of mer, -s*Hash size
jellyfish count -C -m 10 -s10M $DATA/KU182908.fa
# k-mers frequency
jellyfish histo mer_counts.jf > results2/frequency.txt
# frequency=7
jellyfish dump -L 7 mer_counts.jf > results2/f7.txt
# pattern finding
cat $DATA/KU182908.fa | dreg -filter -pattern ATGAAGATTA > results2/findpattern.txt

# multiple sequence alignment
seqkit stat $DATA/ebola.fa > results3/stat.txt
seqkit seq -n $DATA/ebola.fa | cut -f 1 -d ' ' | head -n 10 > results3/ids.txt
seqkit grep --pattern-file results3/ids.txt $DATA/ebola.fa > results3/small.fa
# perform a multiple sequence alignment
mafft --clustalout results3/small.fa > results3/alignment.maf
head -20 results3/alignment.maf

