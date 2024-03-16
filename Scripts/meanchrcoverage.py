import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sys

def generate_bar_chart(csv_file, png_file):
    # Cargar datos
    data = pd.read_csv(csv_file)

    # Configuración del gráfico
    plt.figure(figsize=(12, 8))
    ind = np.arange(len(data['Cromosoma']))  # los nombres de los cromosomas
    width = 0.35

    # Barras del gráfico
    plt.bar(ind - width/2, data['PYM007 vs GRCh38'], width, label='PYM007 vs GRCh38', color='#C43E96')
    plt.bar(ind + width/2, data['PYM007 vs CHM13'], width, label='PYM007 vs CHM13', color='#07948E')

    # Etiquetas y estilo
    plt.xlabel('Cromosoma')
    plt.ylabel('Cobertura promedio (X)')
    plt.xticks(ind, data['Cromosoma'].astype(str))
    plt.ylim(0, 25)
    plt.grid(False)
    plt.legend(loc='upper left', bbox_to_anchor=(1, 1), frameon=True, edgecolor='black')

    # Añadiendo marco delgado
    for spine in plt.gca().spines.values():
        spine.set_visible(True)
        spine.set_linewidth(0.5)

    plt.tight_layout()

    # Guardar la figura
    plt.savefig(png_file)
    plt.close()

# Verificar si se han dado los argumentos necesarios
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python <script_name>.py <csv_file.csv> <output_image.png>")
        sys.exit(1)

    csv_file = sys.argv[1]
    png_file = sys.argv[2]
    generate_bar_chart(csv_file, png_file)
