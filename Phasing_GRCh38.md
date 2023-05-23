### Activar el ambiente de conda 
```bash
module load anaconda3/2021.05
source activate whatshap-env
```

### Fasear el archivo VCF 
```bash
whatshap phase -o PYM007_GRCh38_deepvariant.pha.vcf --reference=Homo_sapiens_GRCh38.p14.noMT.names.fasta PYM007_GRCh38_deepvariant.vcf PYM007.GRCh38.pbmm2.bam
```

### Obtener estadísticas del faseo 
```bash
whatshap stats PYM007_GRCh38_deepvariant.pha.vcf
```

### Indexar el archivo faseado 
```bash
module load bcftools/1.10.2 
bcftools index -t Phased_vcf.vcf.gz
``` 

### Agregar etiquetas 
```bash
whatshap haplotag -o Phased.bam --reference 
```
