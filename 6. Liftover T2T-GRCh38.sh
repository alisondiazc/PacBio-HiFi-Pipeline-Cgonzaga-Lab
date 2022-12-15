#Crear carpeta, mover genomas, indices y bam
mkdir 8.Liftover
cd 8.Liftover
ln -s /mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.fasta .
ln -s /mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.fasta.fai .
ln -s /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa .
ln -s /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa.fai .
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/5.T2TAssembly/PYM007.T2T.pbmm2.bam .
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/5.T2TAssembly/PYM007.T2T.pbmm2.bam.bai . 

#Descargar archivo chain 
wget https://hgdownload.soe.ucsc.edu/goldenPath/hs1/liftOver/chm13v2-hg38.over.chain.gz

#Cambiar encabezados de GRCh38 para que coincidan con archivo chain 
sed -i 's/CM000663.2/chr1/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000664.2/chr2/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000665.2/chr3/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000666.2/chr4/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000667.2/chr5/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000668.2/chr6/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000669.2/chr7/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000670.2/chr8/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000671.2/chr9/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000672.2/chr10/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000673.2/chr11/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000674.2/chr12/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000675.2/chr13/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000676.2/chr14/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000677.2/chr15/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000678.2/chr16/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000679.2/chr17/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000680.2/chr18/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000681.2/chr19/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000682.2/chr20/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000683.2/chr21/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000684.2/chr22/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000685.2/chrX/g' Homo_sapiens_GRCh38.p14.noMT.fasta
sed -i 's/CM000686.2/chrY/g' Homo_sapiens_GRCh38.p14.noMT.fasta

#Obtener archivos de ejecución para leviosam
wget https://github.com/milkschen/leviosam2/blob/main/configs/pacbio_all.yaml
wget https://github.com/milkschen/leviosam2/blob/main/workflow/leviosam2.sh 

#Crear index 
module load anaconda3/2021.05
module load minimap2/2.24
module load samtools/1.16.1
source activate leviosam2
leviosam2 index -c chm13v2-hg38.chain -p chm13v2-hg38 -F Homo_sapiens_GRCh38.p14.noMT.fasta.fai
bash leviosam2.sh \
    -a minimap2 -g 1000 -H 100 -S -x /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/8.Liftover/pacbio_all.yaml \
    -l map-hifi \
    -i /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/8.Liftover/PYM007.T2T.pbmm2.bam \
    -o PYM007_T2TtoGRCh38_lifted \
    -f /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/8.Liftover/Homo_sapiens_GRCh38.p14.noMT.fasta \
    -C /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/8.Liftover/chm13v2-hg38.clft \
    -t 20

leviosam2 lift -C chm13v2-hg38.leviosam2.clft -a PYM007.T2T.pbmm2.bam -t 32 -m -f Homo_sapiens_GRCh38.p14.noMT.fasta -S 30 -S 100 -x pacbio_all.yaml
