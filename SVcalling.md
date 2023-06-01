# Structural Variants Calling (SV Calling)
***

## SV calling with Sniffles2 
### Loading of modules
```bash
module load anaconda3/2021.05
source activate adiaz39
module unload  python38/3.8.3
```
### Calling Variants 
```bash
sniffles --input PYM007.GRCh38.pbmm2.bam --reference Homo_sapiens_GRCh38.p14.noMT.names.fasta --vcf PYM007.GRCh38.SV.sniffles2.vcf --non-germline --tandem-repeats GRCh38_tandem_repeats.bed
```

## SV calling with pbsv
### Loading of modules
```bash
module load miniconda/4.3.1
```
### Identifiying signatures of structural variation
```bash
pbsv discover PYM007.GRCh38.pbmm2.bam PYM007.GRCh38.svsig.gz --tandem-repeats GRCh38_tandem_repeats.bed
```
### Calling Variants
```bash
pbsv call --ccs Homo_sapiens_GRCh38.p14.noMT.names.fasta PYM007.GRCh38.svsig.gz PYM007.GRCh38.SV.pbsv.vcf
```

## SV calling with svim-asm
### Loading of modules
```bash
module load miniconda/4.3.1
source activate svimasm_env
```
### Calling Variants
```bash
svim-asm haploid ./ PYM007.GRCh38.pbmm2.bam Homo_sapiens_GRCh38.p14.noMT.names.fasta
```

