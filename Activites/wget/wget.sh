#!/bin/bash
#SBATCH --qos normal
#SBATCH --partition amilan
#SBATCH --time=24:00:00
#SBATCH --job-name=wget
#SBATCH --mail-user=email@address.com
#SBATCH --mail-type=ALL
#SBATCH --error=sra.err
#SBATCH --output=sra.out

wget 