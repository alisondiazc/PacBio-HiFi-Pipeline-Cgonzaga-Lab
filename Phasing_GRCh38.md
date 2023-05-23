### Activar el ambiente de conda 
'''
module load anaconda3/2021.05
source activate whatshap-env
'''

### Fasear el archivo VCF 


### Obtener estadísticas del faseo 
whatshap stats input.vcf


### Indexar el archivo faseado 
module load bcftools/1.10.2 
bcftools index -t Phased_vcf.vcf.gz

### Agregar etiquetas 
whatshap haplotag -o Phased.bam --reference 
