import csv

with open("definitions_file.csv", "r") as f:
    reader = csv.reader(f, delimiter='\t')
    for i, line in enumerate(reader):
        print('`define {}'.format(line[0].replace(",", " ")))
