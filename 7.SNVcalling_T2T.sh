#Preparar el ambiente
##Deepvariant tiene problemas al correr con links dinámicos, por eso copiamos los archivos
mkdir 7.SNVcallingT2T
cd 7.SNVcallingT2T
cp /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa .
cp /mnt/Timina/cgonzaga/resources/T2T_2.0/chm13v2.0.noMT.fa.fai .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/5.T2TAssembly/PYM007.T2T.pbmm2.bam .
cp /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/5.T2TAssembly/PYM007.T2T.pbmm2.bam.bai . 

#Correr deepvariant
module load singularity/3.7.0
singularity run \
-B /cm/shared/apps/singularity/images/3.7.0/deepvariant_1.4.0.sif \
-B /usr/lib/locale/:/usr/lib/locale/ \
-B /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/7.SNVcallingT2T \
docker://google/deepvariant:1.4.0 \
/opt/deepvariant/bin/run_deepvariant \
--model_type PACBIO \
--ref /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/7.SNVcallingT2T/chm13v2.0.noMT.fa \
--reads /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/7.SNVcallingT2T/PYM007.T2T.pbmm2.bam \
--output_vcf /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/7.SNVcallingT2T/PYM007_T2T_deepvariant.vcf.gz \
--num_shards 40
