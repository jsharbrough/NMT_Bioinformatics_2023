#!/bin/bash

#SBATCH --partition amilan
#SBATCH --job-name=bwa
#SBATCH --cpus-per-task=64
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-user=email@address.com
#SBATCH --mail-type=ALL
#SBATCH --time=24:00:00
#SBATCH --qos normal
#SBATCH --error=bwa.err
#SBATCH --output=bwa.out

eval "$(conda shell.bash hook)"
conda activate bio

bwa mem -t 64 reference.fasta F.fastq.gz R.fastq.gz | samtools view -bF 2308 - | samtools sort -O BAM --threads 64 - > sample.primary.sorted.bam

