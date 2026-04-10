#!/bin/bash
#SBATCH --job-name=braker_job
#SBATCH --partition=bigmem
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=450G
#SBATCH --time=7-00:00:00
#SBATCH --output=braker_job.%j.out
#SBATCH --error=braker_job.%j.err

module load singularity

#BASE DIR THAT CONTAINS sif + protein DB
BASE=/path/to/sif_and_proteinDB

#WORKDIR FOR the run dir
WORKDIR=/path/to/rundir

#INPUT FILES
GENOME=$WORKDIR/genome.fasta
PROT=$BASE/protein_db.fasta
AUGCFG=$BASE/augustus_config
SIF=$BASE/braker3.sif

mkdir -p $WORKDIR/braker_out

#RUN BRAKER
singularity exec \
  --bind $WORKDIR:/mnt \
  --bind $BASE:/base \
  --bind $AUGCFG:/opt/Augustus/config \
  $SIF \
  braker.pl \
    --genome=/mnt/genome.fasta\
    --prot_seq=/base/protein_db.fasta \
    --softmasking \ #softmask the genome before the annotation
    --species=speciesname \
    --gff3 \
    --threads=$SLURM_CPUS_PER_TASK \
    --workingdir=/mnt/braker_out \
    --AUGUSTUS_CONFIG_PATH=/opt/Augustus/config

echo "run complete"
