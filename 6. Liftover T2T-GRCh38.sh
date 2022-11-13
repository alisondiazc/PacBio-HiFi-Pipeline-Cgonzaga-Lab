#Crear archivo chain 
##Descargar archivo main.nf de github
curl -o main.nf https://raw.githubusercontent.com/evotools/nf-LO/main/main.nf
##Correr nextflow 
module load nextflow/21.10.6
module load minimap2/2.24
ln -s /mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.fasta .
ln -s /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa .
nextflow run evotools/nf-LO --source chm13v2.0.noMT.fa --target Homo_sapiens_GRCh38.p14.noMT.fasta --outdir T2T_38_liftover -profile conda --aligner minimap2/2.24
#Si da error intentar con conda 

#Crear index 
leviosam2 index -c source_to_target.chain -p source_to_target -F target.fai

bash leviosam2.sh \
    -a minimap2 -g 1000 -H 100 -S -x ../configs/pacbio_all.yaml \
    -l map-hifi \
    -i pacbio.bam \
    -o pacbio-lifted \
    -f grch38.fna \
    -C chm13v2-grch38.clft \
    -t 16 \
    -R suppress_annotations.bed # optional
