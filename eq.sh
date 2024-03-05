#!/bin/bash

init="step5_input"
rest_prefix="step5_input"
mini_prefix="step6.0_minimization"
equi_prefix="step6.%d_equilibration"
prod_prefix="step7_production"
prod_step="step7"

cnt=1
cntmax=6

cnt=1
cntmax=6

while [ ${cnt} -le ${cntmax} ]
do
    pcnt=$((cnt - 1))
    istep=$(printf "${equi_prefix}" ${cnt})
    pstep=$(printf "${equi_prefix}" ${pcnt})
    
    if [ ${cnt} -eq 1 ]; then
        pstep="${mini_prefix}"
    fi

    gmx grompp -f "${istep}.mdp" -o "${istep}.tpr" -c "${pstep}.gro" -r "${rest_prefix}.gro" -p topol.top -n index.ndx
    gmx mdrun -v -deffnm "${istep}"
    cnt=$((cnt + 1))
done

