#Preparar carpeta y archivos 
mkdir 9.vsAssemblies
cd 9.vsAssemblies 
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/3.DeNovoAssembly/PYM007_hifiasm_denovo.fa .
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/4.GRCh38Assembly/PYM007.GRCh38.pbmm2.cons.fa .
ln -s /mnt/Timina/cgonzaga/adiaz/PacBio_secuencias/PYM007/5.T2TAssembly/PYM007.T2T.pbmm2.cons.fa .

GSAlign -r PYM007.GRCh38.pbmm2.cons.fa -q PYM007.T2T.pbmm2.cons.fa -o GS/PYM007_GRCh38vsT2T -t 20

#Comparar GRCh38 vs T2T
module load gsalign/29nov22
module load gnuplot/5.2.6
GSAlign -r PYM007.GRCh38.pbmm2.cons.fa -q PYM007.T2T.pbmm2.cons.fa -o PYM007_GRCh38vsT2T -t 20
module load minimap2/2.24
minimap2 -x asm5 -L --secondary=no -t 60 PYM007.GRCh38.pbmm2.cons.fa PYM007.T2T.pbmm2.cons.fa > PYM007.GRCh38vsT2T.mm2.paf

module load r/4.0.2
./pafCoordsDotPlotly.R -i PYM007.GRCh38vsT2T.mm2.paf -o PYM007.GRCh38vsT2T -s -t -l -x

#Comparar GRCh38 vs de novo
module load gsalign/29nov22
module load gnuplot/5.2.6
GSAlign -r PYM007.GRCh38.pbmm2.cons.fa -q PYM007_hifiasm_denovo.fa -o PYM007_GRCh38vsDenovo -t 20

module load minimap2/2.24
minimap2 -x asm5 -L --secondary=no -t 60 PYM007.GRCh38.pbmm2.cons.fa PYM007_hifiasm_denovo.fa > PYM007.GRCh38vsDenovo.mm2.paf

module load r/4.0.2
./pafCoordsDotPlotly.R -i PYM007.GRCh38vsDenovo.mm2.paf -o PYM007.GRCh38vsDenovo -s -t -l -x

#Comparar T2T vs de novo
module load gsalign/29nov22
module load gnuplot/5.2.6
GSAlign -r PYM007.T2T.pbmm2.cons.fa -q PYM007_hifiasm_denovo.fa -o PYM007_T2TvsDenovo -t 20

module load minimap2/2.24
minimap2 -x asm5 -L --secondary=no -t 60 PYM007.T2T.pbmm2.cons.fa PYM007_hifiasm_denovo.fa > PYM007.T2TvsDenovo.mm2.paf

module load r/4.0.2
./pafCoordsDotPlotly.R -i PYM007.T2TvsDenovo.mm2.paf -o PYM007.T2TvsDenovo -s -t -l -x
