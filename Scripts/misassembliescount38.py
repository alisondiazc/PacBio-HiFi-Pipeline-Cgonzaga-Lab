import csv
import sys

def count_misassemblies(file_path):
    misassembly_counts = {}
    current_chr = None

    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith('chr'):
                current_chr = line.strip()
                if current_chr not in misassembly_counts:
                    misassembly_counts[current_chr] = 0
            else:
                if current_chr:
                    misassembly_counts[current_chr] += 1

    return misassembly_counts

def main():
    if len(sys.argv) != 2:
        sys.exit(1)

    input_file_path = sys.argv[1]
    misassembly_counts = count_misassemblies(input_file_path)

    csv_file_path = 'missasemblies_count_38.csv'

    with open(csv_file_path, 'w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(['chr', 'misassemblies'])
        for chr, count in misassembly_counts.items():
            writer.writerow([chr, count])

if __name__ == "__main__":
    main()
