#!/bin/bash

echo ""
echo "====="
echo "Running $0"

# From alignment files, plots distribution and sequencing accuracy of trinucleotides

aln_expl_dir="./Data/Alignment" # input data: directory containing explicit alignment
output_graph_dir="./Output/Trinucleotides" # output directory: graphics
output_raw_dir="./Analysis/Trinucleotides" # output directory where raw results are stored
path_file_color_gc_species="./Data/species_gc_color.txt" # file containing GC content of each species, and a dedicated color for plots

mkdir -p $output_graph_dir
mkdir -p $output_raw_dir

# Check that explicit alignment exists
if [ ! -d $aln_expl_dir ]; then
  echo "ERROR: Directory $aln_expl_dir cannot be found. Please run alignment_explicit.sh script prior to this one." >&2
  exit 1
fi
if ! ls ${aln_expl_dir}/*.txt &> /dev/null; then
  echo "ERROR: No explicit alignment could be found in $aln_expl_dir. Please run alignment_explicit.sh script prior to this one." >&2
  exit 1
fi


# Runs the script
python3 -u ./Scripts/Python/trinucleotides.py $aln_expl_dir $output_raw_dir $output_graph_dir $path_file_color_gc_species

echo ""
echo "Done."
echo "---"
