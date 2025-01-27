#!/bin/bash

echo ""
echo "====="
echo "Running $0"

# Analyse explicit alignment files and reference genome files, concerning heteropolymer errors.

aln_expl_dir="./Data/Alignment/" # input data: directory containing explicit alignment
ref_gen_dir="./Data/Reference_genomes/" # input data: directory containing reference genomes
output_graph_dir="./Output/Heteropolymer_errors/" # output directory: graphics
output_raw_dir="./Analysis/Heteropolymer_errors/" # output directory: raw results
species_color_gc_file="./Data/species_color_GC.txt" # input file: contains gc content for each species and an associated color for graphs
file_species_groups="./Data/species_groups.txt" # file containing species groups
min_length=$1
max_length=$2

mkdir -p $output_raw_dir
mkdir -p $output_graph_dir


# Check that explicit alignment exists
if [ ! -d $ref_gen_dir ]; then
  echo "ERROR: Directory $ref_gen_dir cannot be found. Please provide reference genomes there." >&2
  exit 1
fi
if ! ls ${ref_gen_dir}/*.fasta &> /dev/null; then
  echo "ERROR: No fasta file of reference genome could be found in $ref_gen_dir. Please provide reference genomes in fasta format." >&2
  exit 1
fi
if [ ! -d $aln_expl_dir ]; then
  echo "ERROR: Directory $aln_expl_dir cannot be found. Please run alignment_explicit.sh script prior to this one." >&2
  exit 1
fi
if ! ls ${aln_expl_dir}/*.txt &> /dev/null; then
  echo "ERROR: No explicit alignment could be found in $aln_expl_dir. Please run alignment_explicit.sh script prior to this one." >&2
  exit 1
fi


# Runs the script
python3 -u ./Scripts/Python/heteropolymer_errors.py $aln_expl_dir $ref_gen_dir $output_raw_dir $output_graph_dir $species_color_gc_file $file_species_groups $min_length $max_length

echo ""
echo "Done."
echo "---"
