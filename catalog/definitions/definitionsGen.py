import os
import csv

template = """//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Evan Rosenfeld, James Ryan
//
//     Create Date: 2024-05-02
//     Definitions file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DEFINITIONS
`define DEFINITIONS

{}

`endif //DEFINITIONS"""

definitionString = "";
with open("definitions_file.csv", "r") as f:
    reader = csv.reader(f, delimiter='\t')
    for i, line in enumerate(reader):
        definitionString += '`define {}\n'.format(line[0].replace(",", " "))

if os.path.exists("./definitions.sv"):
    os.remove("./definitions.sv")

w = open("./definitions.sv", "w+")
w.write(template.format(definitionString))
w.close()
print("done.")

