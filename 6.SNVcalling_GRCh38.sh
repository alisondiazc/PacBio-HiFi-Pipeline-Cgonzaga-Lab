#Preparar el ambiente
##Deepvariant tiene problemas al correr con links dinámicos, por eso copiamos los archivos
mkdir 6.SNVcalling38
cd 6.SNVcalling38 
cp /mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.fasta . 
cp /mnt/Timina/cgonzaga/resources/GRCh38.14/Homo_sapiens_GRCh38.p14.noMT.fasta.fai .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/4.GRCh38Assembly/PYM007.GRCh38.pbmm2.bam .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/4.GRCh38Assembly/PYM007.GRCh38.pbmm2.bam.bai . 

#Correr deepvariant
module load singularity/3.7.0
singularity run \
-B /cm/shared/apps/singularity/images/3.7.0/deepvariant_1.4.0.sif \
-B /usr/lib/locale/:/usr/lib/locale/ \
-B /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/6.SNVcalling38 \
docker://google/deepvariant:1.4.0 \
/opt/deepvariant/bin/run_deepvariant \
--model_type PACBIO \
--ref /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/6.SNVcalling38/Homo_sapiens_GRCh38.p14.noMT.fasta \
--reads /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/6.SNVcalling38/PYM007.GRCh38.pbmm2.bam \
--output_vcf /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/6.SNVcalling38/PYM007_GRCh38_deepvariant.vcf.gz \
--num_shards 40

#Estad[isticas básicas de VCF 
module load bcftools/1.10.2
bcftools stats PYM007_GRCh38_deepvariant.vcf.gz > PYM007_GRCh38_vcfstats
