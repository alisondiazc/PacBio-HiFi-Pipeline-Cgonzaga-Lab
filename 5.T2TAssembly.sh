# Crear carpeta
mkdir 5.T2TAssembly
cd 5.T2TAssembly

# Crear links a los reads y la referencia 
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/2.ReadsTrimming/Hifiadapterfilt_PYM007/PYM007_reads.filt.fastq.gz .
ln -s /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa .

# Ensamble con pbmm2 -- Voy aqui
module load miniconda/4.3.1
pbmm2 align --sort -j 80 --preset HIFI --log-level INFO chm13v2.0.noMT.fa PYM007_reads.filt.fastq.gz PYM007.T2T.pbmm2.bam

# Conversión de bam a fasta 
module load samtools/1.10
samtools fasta PYM007.T2T.pbmm2.bam > PYM007.T2T.pbmm2.fasta

# Analisis con assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007.T2T.pbmm2.fasta > PYM007.T2T.pbmm2.assemblystats

#Consensus of pbmm2 bam 
module load samtools/1.16.1
samtools consensus -f fasta -o PYM007.T2T.pbmm2.cons.fa -a PYM007.T2T.pbmm2.bam

# Analisis de consensus con assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007.T2T.pbmm2.cons.fa > PYM007.T2T.pbmm2.cons.assemblystats

#Alinear consenso contra T2T
module load minimap2/2.24
module load samtools/1.16.1
minimap2 -ax asm5 -L --secondary=no -t 60 chm13v2.0.noMT.fa PYM007.T2T.pbmm2.cons.fa | samtools sort -o PYM007.T2T.cons.mm2.bam
samtools index -o PYM007.T2T.cons.mm2.bai -@ 20 PYM007.T2T.cons.mm2.bam
