#!/bin/bash

## Job Name
#SBATCH --job-name=qc-coral-embryo-OCT15

## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab

## Nodes
#SBATCH --nodes=1

## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=720:00:00

## Memory per node
#SBATCH --mem=100GB

##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=stanja@uw.edu

## Specify the working directory for this job
#SBATCH --chdir= /gscratch/srlab/

# load modules needed
module load fastp/0.19.7-foss-2018b
module load FastQC/0.11.8-Java-1.8
module load MultiQC/1.9-intel-2020a-Python-3.8.2

# fastqc of raw reads

# run fastqc
fastqc *.fastq.gz

#combine all results - need to rename output file to "raw"
multiqc ./

# Make an array of sequences to trim
array1=($(ls *.fastq.gz)) 

# fastp loop; trim the Read 1 TruSeq adapter sequence; trim poly x default 10 (to trim polyA) 
for i in ${array1[@]}; do
	fastp --in1 ${i} --out1 clean.${i} --adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --trim_poly_x 6 -q 30 -y -Y 50 
# fastqc the cleaned reads
        fastqc clean.${i}
done 

echo "Read trimming of adapters complete." $(date)

# Quality Assessment of Trimmed Reads

multiqc clean* #Compile MultiQC report from FastQC files - need to rename output file to "clean"

echo "Cleaned MultiQC report generated." $(date)