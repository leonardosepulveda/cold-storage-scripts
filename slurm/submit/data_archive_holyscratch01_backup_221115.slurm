#!/bin/bash
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -p zhuang,shared
#SBATCH -t 02-00:00:00
#SBATCH --mem 10000
#SBATCH --open-mode=append
#SBATCH -o /n/home06/lsepulvedaduran/Software/cold-storage-scripts/slurm/out/%j.cold.data_holyscratch01_backup_221115.stdout.txt
#SBATCH -e /n/home06/lsepulvedaduran/Software/cold-storage-scripts/slurm/err/%j.cold.data_holyscratch01_backup_221115.stderr.txt


date +'Starting at %R.'

echo Cold storage 

export cold_archive_path=/n/home06/lsepulvedaduran/Software/cold-storage-scripts

# snakemake command
/n/home06/lsepulvedaduran/.conda/envs/storage_env/bin/snakemake \
--jobs 800 \
-s $cold_archive_path/archive.snakefile \
--cluster-config $cold_archive_path/cluster.json \
--configfile $cold_archive_path/config/data_config_holyscratch01_backup_221115.json \
--cluster "sbatch --mem={cluster.mem} -A {cluster.account} -p {cluster.partition} -n {cluster.n}  -t {cluster.time} -o {cluster.out} -e {cluster.err} --exclude={cluster.exclude}"

date +'Finished at %R.'