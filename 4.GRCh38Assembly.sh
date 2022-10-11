#Crear carpeta
mkdir 4.GRCh38Assembly
cd 4.GRCh38Assembly

#Crear links a los reads y la referencia
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/2.ReadsTrimming/Hifiadapterfilt_PYM007/PYM007_reads.filt.fastq.gz
ln -s /mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.fasta .

# Ensamble con pbmm2
module load miniconda/4.3.1
pbmm2 align --sort -j 80 --preset HIFI --log-level INFO Homo_sapiens_GRCh38.p14.noMT.fasta PYM007_reads.filt.fastq.gz PYM007.GRCh38.pbmm2.bam

# Conversión de bam a fasta 
module load samtools/1.10
samtools fasta PYM007.GRCh38.pbmm2.bam > PYM007.GRCh38.pbmm2.fasta

# Estadísticas generales con assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007.GRCh38.pbmm2.fasta > PYM007.GRCh38.pbmm2.assemblystats

# ****** Análisis de aligned coverage depth con mosdepth 
module load mosdepth/0.3.3 
mosdepth -t 60 -n  PYM007.GRCh38.pbmm2 PYM007.GRCh38.pbmm2.bam
python plot-dist.py \*global.dist.txt

# Consenso del pbmm2 bam 
module load samtools/1.16.1 
samtools consensus -f fasta -o PYM007.GRCh38.pbmm2.cons.fa -a PYM007.GRCh38.pbmm2.bam

# Estadísticas generales de consensus con assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007.GRCh38.pbmm2.cons.fa > PYM007.GRCh38.pbmm2.cons.assemblystats

# Mapear ensamble consenso contra la referencia
module load minimap2/2.24
minimap2 -ax asm5 -L --secondary=no -t 60 Homo_sapiens_GRCh38.p14.noMT.fasta PYM007.GRCh38.pbmm2.cons.fa > PYM007.GRCh38.cons.mm2.paf

# ****** Dot plot
module load r/4.2.1
chmod 777 pafCoordsDotPlotly.R
./pafCoordsDotPlotly.R -i PYM007.GRCh38.cons.mm2.paf -o PYM007.GRCh38 -s -t -l -x

----------------------------------------------

#Ver contigs que mapean con buena calidad 
samtools view -c -q60 PYM007.GRCh38.cons.mm2.bam


