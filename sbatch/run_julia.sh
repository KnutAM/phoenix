#!/bin/bash
#SBATCH --partition=standard  # Partition (queue), some alt: shortrun_large, shortrun_small, testing, fat, gpu01queue, gpu02queue, gpu03queue
#SBATCH -N 1                  # Number of nodes
#SBATCH -n 1                  # Number of processes

# Start a job by calling 
# `sbatch <sbatch_options> <path/to/run_julia.sh> -s <path/to/julia/script.jl>`
# from the folder containing the Project.toml
# The sbatch options are any options available for the currently used sbatch, and will override settings in this file
# An example call could be 
# sbatch -J myjob -n 2 --time=2-00:00:00 $SBATCH_SCRIPTS/run_julia.sh -s runsim.jl
# Assuming that the environment variable $SBATCH_SCRIPTS contains the path to the `sbatch` folder
# Here, the job name is set to "myjob", the number of processors to 2, and the time limit to 2 days

# Default values
memory_percentage=80 # Default value for "m"

# Get input options
while getopts ":s:m:" opt; do
  case $opt in
    s) # Which script to run
      script=$OPTARG
      ;;
    m) # heap-size-hint to m % of maximum memory to prevent out-of-memory cg-failure
      memory_percentage=$OPTARG
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

if [ -z "$script" ]; then
    echo "No script file given, this is mandatory!"
    exit 1
fi

# Calculate suitable heap size hint
heap_size_hint=$(($SLURM_MEM_PER_CPU*$SLURM_NPROCS*$memory_percentage/100))

# Julia args
julia_args="--project=. --threads $SLURM_NPROCS --heap-size-hint=$heap_size_hint"
echo julia_args: $julia_args

# Build environment
julia $julia_args -e 'using Pkg; Pkg.instantiate()'

# Display versioninfo (for reference)
julia $julia_args -e 'using InteractiveUtils; versioninfo()'

# Run analysis
julia $julia_args $script
