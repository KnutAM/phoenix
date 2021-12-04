#!/bin/bash
#SBATCH --partition=standard  # Partition (queue), some alt: shortrun_large, shortrun_small, testing, fat, gpu01queue, gpu02queue, gpu03queue
#SBATCH -N 1                  # Number of nodes
#SBATCH -n 1                  # Number of processes

# Start a job by calling 
# `sbatch <sbatch_options> <path/to/run_julia.sh> -s <the_julia_script.jl>`
# from the folder containing the julia script (i.e. <the_julia_script.jl>)
# The sbatch options are any options available for the currently used sbatch, and will override settings in this file
# An example call could be 
# sbatch -J myjob -n 2 -time 2-00:00:00 $SBATCH_SCRIPTS/run_julia.sh -s runsim.jl
# Assuming that the environment variable $SBATCH_SCRIPT contains the path to the `sbatch` folder
# Here, the job name is set to "myjob", the number of processors to 2, and the time limit to 2 days


# Get input options
while getopts ":s" opt; do
  case $opt in
    s)
      script=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Load julia
module load software/julia/latest

# Build environment
julia --project=. --threads $SLURM_NPROCS -e 'using Pkg; Pkg.instantiate()'

# Run analysis
julia --project=. --threads $SLURM_NPROCS $script
