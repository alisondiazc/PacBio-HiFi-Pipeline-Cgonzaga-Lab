# Ensamble de novo
mkdir 3.DeNovoAssembly
cd 3.DeNovoAssembly
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/2.ReadsTrimming/Hifiadapterfilt_PYM007/PYM007_reads.filt.fastq.gz
module load hifiasm/0.16.1
hifiasm -o PYM007_Hifiasm_denovo.asm --primary -t 8 -f 37 PYH007_reads.fastq.gz

# Assembly-stats
module load assembly-stats/1.0.1
assembly-stats PYM007_Hifiasm_denovo.asm
