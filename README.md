# Job Submission Scripts
The purpose of this repository is to collect scripts useful for submitting jobs on the Phoenix cluster using the sbatch. The main submission scripts (\*.sh) are located in the sbatch folder.

## Installation
Clone the script directory to your `$HOME` (`~`) folder
```bash
cd ~
git clone https://github.com/KnutAM/phoenix.git
```

## TIPS
### Add shortcut to sbatch folder
To facilitate running scripts, edit your `~/.bash_profile` to include the line
```bash
SBATCH_SCRIPTS=$HOME/phoenix/sbatch
```
to allow convenient access to the sbatch scripts. If you put the phoenix repository in another folder, update the path above accordingly. To make effective immediately, run source `~/.bash_profile`.

