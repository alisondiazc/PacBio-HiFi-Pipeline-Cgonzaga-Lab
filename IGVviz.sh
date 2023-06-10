#Indexar archivo bam faseado
module load samtools/1.16.1
samtools index PYM007.GRCh38.pbmm2.pha.bam
#Extraer los datos del chr.15 del archivo bam 
samtools view -h PYM007.GRCh38.pbmm2.pha.bam chr15 > PYM007.GRCh38.pha.chr15.sam 
#Pasar el archivo a .bam
samtools view -bS PYM007.GRCh38.pha.chr15.sam > PYM007.GRCh38.pha.chr15.bam 
#Hacer index del archivo .bam 
samtools index PYM007.GRCh38.pha.chr15.bam 
#Descargar los archivos EN NUESTRA COMPUTADORA
rsync -a adiaz@dna.lavis.unam.mx:/mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/6.SNVcalling38/phasing/PYM007.GRCh38.pha.chr15.bam .
rsync -a adiaz@dna.lavis.unam.mx:/mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/6.SNVcalling38/phasing/PYM007.GRCh38.pha.chr15.bam.bai .
#Entrar a la página https://igv.org/app/ para ver los resultados, seleccionando los archivos .bam y .bai at the same time
