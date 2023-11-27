import pandas as pd
import matplotlib.pyplot as plt

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

    data_grch38['chr_sort'] = data_grch38['chr'].apply(sort_chromosomes)
    data_grch38_sorted = data_grch38.sort_values(by='chr_sort')

    data_chm13['chr_sort'] = data_chm13['chr'].apply(sort_chromosomes)
    data_chm13_sorted = data_chm13.sort_values(by='chr_sort')

    plt.figure(figsize=(12, 10))
    bar_width = 0.4
    r1 = range(len(data_grch38_sorted))
    r2 = [x + bar_width for x in r1]

    plt.barh(r1, data_grch38_sorted['data'], color='#C43E96', height=bar_width, label='GRCh38')
    plt.barh(r2, data_chm13_sorted['data'], color='#07948E', height=bar_width, label='CHM13')

    plt.xlabel('Identidad de secuencia (%)')
    plt.ylabel('Cromosoma')
    plt.yticks([r + bar_width/2 for r in range(len(data_grch38_sorted))], data_grch38_sorted['chr'])
    plt.legend()
    plt.tight_layout()
    plt.savefig(output_file, format='png')

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description='Comparación de Identidad de Secuencia por Cromosoma entre GRCh38 y CHM13')
    parser.add_argument('file_grch38', help='Archivo CSV con datos para GRCh38')
    parser.add_argument('file_chm13', help='Archivo CSV con datos para CHM13')
    parser.add_argument('output_file', help='Nombre del archivo de imagen .png para guardar la gráfica')
    args = parser.parse_args()

    main(args.file_grch38, args.file_chm13, args.output_file)
