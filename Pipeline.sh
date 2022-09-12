# Create reads directory  
mkdir reads 
cd reads
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYH007/Cell-1/m64140_220419_014014.hifi_reads.fastq.gz .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYH007/Cell-2/m64140_220420_113131.hifi_reads.fastq.gz .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYH007/Cell-3/m54336U_220420_105237.hifi_reads.fastq.gz .

# Merge reads into the same file
cat *.fastq.gz > PYM007_reads.fastq.gz 

# Create QC directory
mkdir 1.ReadsQC
cd 1.ReadsQC  

# LongQC analysis
mkdir LongQC
cd LongQC
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/reads/PYM007_reads.fastq.gz . 
module load anaconda3/2021.05
module load longqc/1.2.0
python /cm/shared/apps/longqc/LongQC-1.2.0/longQC.py sampleqc -x pb-hifi -s PYM007 -p 80 -o LongQC PYM007_reads.fastq.gz

# FastQC Analysis 
mkdir FastQC
cd FastQC 
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/reads/PYM007_reads.fastq.gz .
module load fastqc/0.11.3
fastqc PYM007_reads.fastq.gz 

# Cleaning/trimming of reads 
mkdir 2.ReadsTrimming
cd 2.ReadsTrimming
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/reads/PYM007_reads.fastq.gz .
module load hifiadapterfilt/2.0.0
module load blast+/2.13.0
module load bamtools/2.5.1
## Nota: opción -p indica el prefix o ruta del archivo (mas no el archivo), es mejor dejar ./ en la carpeta donde tengamos solo el archivo
pbadapterfilt.sh -p ./ -l 44 -m 97 -t 60 -o Hifiadapterfilt_PYM007

# De novo assembly 
module load hifiasm/0.16.1
hifiasm -o PYM007_Hifiasm_denovo.asm --primary -t 8 -f 37 PYH007_reads.fastq.gz

#GRCh38 assembly 
module load minimap2/2.17
minimap2 -ax map-hifi -t 8 Homo_sapiens_GRCh38.p14.noMT.fasta PYH007_reads.fastq.gz > PYM007_38.mm2.sam
samtools sort -l9 -o PYM007_38.mm2.sort.bam -@ 60 PYM007_38.mm2.sam

#GRCh38 assembly analysis 
## Create a fasta file from bam 
module load samtools/1.10
samtools fasta PYM007_38.mm2.sort.bam > PYM007_38.mm2.sort.fasta 
## Obtain assembly statistics of fasta
module load assembly-stats/1.0.1
assembly-stats PYM007_38.mm2.sort.fasta
