#!/bin/bash
#SBATCH -N 2
#SBATCH --ntasks-per-node=48
#SBATCH --error=./job_errs/job.err
#SBATCH --output=./job_outs/job.out
#SBATCH --time=00:20:00
#SBATCH --partition=standard

# Capture start time in seconds since epoch
start=$(date +%s)
echo "Job started at: $(date -d @$start)"


# Print environment information before running the script
echo "==============================================="
echo "Job Information:"
echo "==============================================="
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
echo "SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST"
echo "SLURM_NTASKS: $SLURM_NTASKS"
echo "SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE"
echo "Current working directory: $(pwd)"

# Get and print CPU core information for each node
echo "CPU Core Information:"
srun -N $SLURM_NNODES -n $SLURM_NNODES bash -c 'echo "$(hostname): $(nproc) cores"'
echo "==============================================="
echo "Running benchmark script..."

# Run your script
../scripts/benchmark4.sh job4_results

# Capture end time and calculate duration
end=$(date +%s)
duration=$((end - start))

# Convert seconds to HH:MM:SS format
hours=$((duration / 3600))
minutes=$(( (duration % 3600) / 60 ))
seconds=$((duration % 60))

printf "\nJob completed at: $(date -d @$end)"
printf "\nTotal execution time: %02d:%02d:%02d\n" $hours $minutes $seconds
