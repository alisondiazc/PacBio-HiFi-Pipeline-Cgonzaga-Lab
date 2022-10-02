grep \> chm13v2.0.fa | perl -pe 's/\ .*\ /\t/;s/\>//' > index.tsv
grep -v contig index.tsv
module load seqtk/1.2-r94
for i in $(seq 1 22) X Y
do
  acc_no=$(awk -v i="${i}" 'BEGIN{FS="\t"}{if($2==i){print $1}}' index.tsv)
  seqtk subseq chm13v2.0.fa <(echo "${acc_no}")
done > chm13v2.0.noMT.fa
