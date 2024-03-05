#!/bin/bash

init="step5_input"
rest_prefix="step5_input"
mini_prefix="step6.0_minimization"
equi_prefix="step6.%d_equilibration"
prod_prefix="step7_production"
prod_step="step7"

# Perform minimization
gmx grompp -f "${mini_prefix}.mdp" -o "${mini_prefix}.tpr" -c "${init}.gro" -r "${rest_prefix}.gro" -p topol.top -n index.ndx
gmx mdrun -ntomp 1 -deffnm "${mini_prefix}" -v