Overview
---------

## What is this?
This is a Snakefile that will run ShortBred, a resistome profiler for metagenomic data, on your cluster and is compatible with Slurm workscheduler.
The Snakefile uses a Singularity container to pull ShortBred and a Conda environment file to set up remaining dependencies.

## What do I need to use this?
1. Usearch 32 bit (free download, albeit painful and demoralizing)
2. Singularity installed on your cluster
3. +/- slurm workscheduler.
4. Snakemake

## Usage

```bash
1. Git clone this repository
2. cd shortbred
3. ln -s /path/to/your/input/files input_fasta		##this is a symbolic link pointing to your input fasta or fastq files.
4. vi Snakefile
	4a. Reflect the name of your symbolic link in Snakefile.
	4b. Change {sample}.1.fasta and {samle}.2.fasta to match your input format.
	4c. If you are not using paired-end reads you can change read1 and read2 to reads which points to your input singleton.
	4d. Make your --usearch correctly points to its location.
5. Update cluster_configs/rackham/rackham.yaml to reflect your cluster settings.


5. Snakemake --use-conda --use-singularity --profile cluster_configs/rackham --jobs 10 --dryrun ##Make sure all the processes work as intended
												## then run without --dryrun.
```

## Easy-to-make errors
1. Files must terminate with .fasta .fastq or .fna
2. Once you've downloaded usearch change its name from usearch.191.2132.zd.zczx.zxc.zx to usearch
and ensure its location is present in your PATH variable. Check this using echo $PATH

