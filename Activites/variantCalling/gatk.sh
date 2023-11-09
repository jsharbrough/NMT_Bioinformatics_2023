#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --qos normal
#SBATCH --partition=amilan
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=email
#SBATCH --mail-type=ALL
#SBATCH --job-name=gatk
#SBATCH --error=gatk.sampleID.err
#SBATCH --output=gatk.sampleID.out

eval "$(conda shell.bash hook)"
conda activate bio
ploidy=samplePloidy
gatk --java-options "-Xmx40g" MarkDuplicates --INPUT sampleID.primary.sorted.bam --METRICS_FILE sampleID.markedDups.txt --OUTPUT sampleID.duplicatesRemoved.bam --READ_NAME_REGEX null --REMOVE_DUPLICATES true --REMOVE_SEQUENCING_DUPLICATES true --CREATE_INDEX false
gatk --java-options "-Xmx40g" AddOrReplaceReadGroups -I sampleID.duplicatesRemoved.bam -O sampleID.duplicatesRemoved.RGadded.bam -RGLB=lib1 -RGPL=illumina -RGPU=unit1 -RGSM=20
samtools index sampleID.duplicatesRemoved.RGadded.bam
gatk --java-options "-Xmx4g" HaplotypeCaller --input sampleID.duplicatesRemoved.RGadded.bam --output sampleID.vcf --reference Pant.hap.fasta -ploidy $ploidy
