#Extraer los datos del chr.15 del archivo bam 
module load samtools/1.16.1
samtools view -h PYM007.GRCh38.pbmm2.pha.bam chr15 > PYM007.GRCh38.pha.chr15.sam 
#Pasar el archivo a .bam
samtools view -bS PYM007.GRCh38.pha.chr15.sam > PYM007.GRCh38.pha.chr15.bam 
#Hacer index del archivo .bam 
samtools index PYM007.GRCh38.pha.chr15.bam 
#Descargar los archivos 
rsync -a adiaz@dna.lavis.unam.mx:
rsync -a adiaz@dna.lavis.unam.mx:
