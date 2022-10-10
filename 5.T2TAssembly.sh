# Crear carpeta
mkdir 5.T2TAssembly
cd 5.T2TAssembly

# Crear links a los reads y la referencia 
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/2.ReadsTrimming/Hifiadapterfilt_PYM007/PYM007_reads.filt.fastq.gz .
ln -s /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa .

# Ensamble con pbmm2
module load miniconda/4.3.1
pbmm2 align --sort -j 80 --preset HIFI --log-level INFO chm13v2.0.noMT.fa PYM007_reads.filt.fastq.gz PYM007.T2T.pbmm2.bam

# Conversión de bam a fasta 
module load samtools/1.10
samtools fasta PYM007.T2T.pbmm2.bam > PYM007.T2T.pbmm2.fasta

# Estadísticas generales con assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007.T2T.pbmm2.fasta > PYM007.T2T.pbmm2.assemblystats

# ****** Análisis de aligned coverage depth con mosdepth 
module load mosdepth/0.3.3 
mosdepth -t 60 -n  PYM007.T2T.pbmm2 PYM007.T2T.pbmm2.bam
python plot-dist.py \*global.dist.txt

# Consenso del pbmm2 bam 
module load samtools/1.16.1
samtools consensus -f fasta -o PYM007.T2T.pbmm2.cons.fa -a PYM007.T2T.pbmm2.bam

# Estadísticas generales del consensus con assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007.T2T.pbmm2.cons.fa > PYM007.T2T.pbmm2.cons.assemblystats

# ****** Mapear ensamble consenso contra la referencia
module load minimap2/2.24
minimap2 -ax asm5 -L --secondary=no -t 60 chm13v2.0.noMT.fa PYM007.T2T.pbmm2.cons.fa > PYM007.T2T.cons.mm2.paf

# ****** Dot plot
pafCoordsDotPlotly.R -i PYM007.GRCh38.cons.mm2.paf -o PYM007.GRCh38 -s -t -l -x

