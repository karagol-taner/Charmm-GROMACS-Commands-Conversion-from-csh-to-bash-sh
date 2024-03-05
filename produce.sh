#!/bin/bash

init="step5_input"
rest_prefix="step5_input"
mini_prefix="step6.0_minimization"
equi_prefix="step6.%d_equilibration"
prod_prefix="step7_production"
prod_step="step7"

cnt=1
cntmax=10

while [ ${cnt} -le ${cntmax} ]
do
    pcnt=$((cnt - 1))
    istep="${prod_step}_${cnt}"
    pstep="${prod_step}_${pcnt}"

    if [ ${cnt} -eq 1 ]; then
        pstep=$(printf "${equi_prefix}" 6)
        gmx grompp -f "${prod_prefix}.mdp" -o "${istep}.tpr" -c "${pstep}.gro" -p topol.top -n index.ndx
    else
        gmx grompp -f "${prod_prefix}.mdp" -o "${istep}.tpr" -c "${pstep}.gro" -t "${pstep}.cpt" -p topol.top -n index.ndx
    fi

    gmx mdrun -v -deffnm "${istep}"
    cnt=$((cnt + 1))
done


