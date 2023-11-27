import pandas as pd
import matplotlib.pyplot as plt
import argparse

def sort_chromosomes(chrom):
    if chrom == 'X':
        return 100
    elif chrom == 'Y':
        return 101
    else:
        return int(chrom)

def main(file_path_grch38, file_path_chm13, output_file):
    data_grch38 = pd.read_csv(file_path_grch38)
    data_chm13 = pd.read_csv(file_path_chm13)

    merged_data = pd.merge(data_grch38, data_chm13, on='chr', suffixes=('_GRCh38', '_CHM13'))
    merged_data['chr_sort'] = merged_data['chr'].apply(sort_chromosomes)
    merged_data_sorted = merged_data.sort_values(by='chr_sort')

    plt.figure(figsize=(12, 10))
    bar_width = 0.4
    r1 = range(len(merged_data_sorted))
    r2 = [x + bar_width for x in r1]

    plt.barh(r1, merged_data_sorted['misassemblies_GRCh38'], color='#C43E96', height=bar_width, label='GRCh38')
    plt.barh(r2, merged_data_sorted['misassemblies_CHM13'], color='#07948E', height=bar_width, label='CHM13')

    plt.xlabel('Número de Ensamblajes Erróneos')
    plt.ylabel('Cromosoma')
    plt.yticks([r + bar_width/2 for r in range(len(merged_data_sorted))], merged_data_sorted['chr'])
    plt.legend()
    plt.tight_layout()
    plt.savefig(output_file, format='png')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Comparación de Ensamblajes Erróneos por Cromosoma en Ensamblajes Genéticos')
    parser.add_argument('file_grch38', help='Archivo CSV con ensamblajes erróneos para GRCh38')
    parser.add_argument('file_chm13', help='Archivo CSV con ensamblajes erróneos para CHM13')
    parser.add_argument('output_file', help='Nombre del archivo de imagen .png para guardar la gráfica')
    args = parser.parse_args()

    main(args.file_grch38, args.file_chm13, args.output_file)
