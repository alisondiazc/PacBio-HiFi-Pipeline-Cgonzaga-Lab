#Crear carpeta de reads 
mkdir reads 
cd reads
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYH007/Cell-1/m64140_220419_014014.hifi_reads.fastq.gz .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYH007/Cell-2/m64140_220420_113131.hifi_reads.fastq.gz .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYH007/Cell-3/m54336U_220420_105237.hifi_reads.fastq.gz .

#Unir los reads en un mismo archivo 
cat *.fastq.gz > PYM007_reads.fastq.gz 

#Crear carpetas para QC
mkdir 1.ReadsQC
cd 1.ReadsQC  

#Análisis con LongQC
mkdir LongQC
cd LongQC
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/reads/PYM007_reads.fastq.gz . 
module load anaconda3/2021.05
module load longqc/1.2.0
python /cm/shared/apps/longqc/LongQC-1.2.0/longQC.py sampleqc -x pb-hifi -s PYM007 -p 80 -o LongQC PYM007_reads.fastq.gz

#Análisis con FastQC 
mkdir FastQC
cd FastQC 
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/reads/PYM007_reads.fastq.gz .
module load fastqc/0.11.3
fastqc PYM007_reads.fastq.gz 

#Limpieza y filtrado de reads 
mkdir 2.ReadsTrimming
cd 2.ReadsTrimming
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/reads/PYM007_reads.fastq.gz .
module load hifiadapterfilt/2.0.0
pbadapterfilt.sh -p ./ -l 44 -m 97 -t 60 -o . 
