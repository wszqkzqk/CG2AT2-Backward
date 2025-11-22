#!/bin/bash

# source /opt/intel/oneapi/setvars.sh
i=5gan_arm_cg.pdb
output=`echo $i | sed 's/\.[^.]*$//'`

gmx_mpi editconf -f $i -o ${output}_box.pdb -d 1.0 -bt cubic

python ../database/bin/cg2at_backward.py -c ${output}_box.pdb -w tip3p -fg martini_2-2_charmm36_Jul2021 -ff charmm36-jul2021 -loc $output -silent -rna_ff charmm36

echo -e "1\n1\n0" | gmx_mpi trjconv -f $output/FINAL/final_cg2at_de_novo.pdb -s $output/MERGED/NVT/merged_cg2at_de_novo_nvt.tpr -o $output/FINAL/final_cg2at_de_novo_fixed.pdb -pbc cluster -center
