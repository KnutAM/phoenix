# Job Submission Scripts
The purpose of this repository is to collect scripts useful for submitting jobs on the Phoenix cluster using the sbatch. The main submission scripts (\*.sh) are located in the sbatch folder.

## Installation
Clone the script directory to your `$HOME` (`~`) folder
```bash
cd ~
git clone https://github.com/KnutAM/phoenix.git
```

## TIPS
### Default project
To facilitate running scripts, edit your `~/.bash_profile` to include the line
```bash
SBATCH_ACCOUNT=<your_default_slurm_project>
```

where `<your_default_slurm_project>`. This way, you don't have to specify each time you run a sbatch script. To make effective immediately, run source `~/.bash_profile`.

