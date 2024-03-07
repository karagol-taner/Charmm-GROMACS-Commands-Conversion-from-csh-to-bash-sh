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

# Perform eq
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

# Perform production
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

# Perform analysis
gmx gyrate -f step7_10.trr -s step7_10.tpr -o gyrate_step710.xvg
gmx gyrate -f step7_10.trr -s step7_1.tpr -o gyrate_step711.xvg

gmx sasa -f step7_10.trr -s step7_10.tpr -o sasa_step710.xvg


gmx rmsf -f step7_10.trr -s step7_1.tpr -o rmsf_step711.xvg -oc correl1.xvg -oq bfac1.pdb -ox xaver1.pdb -dir rmsf_step711.log
gmx rmsf -f step7_10.trr -s step7_10.tpr -o rmsf_step710.xvg -oc correl2.xvg -oq bfac2.pdb -ox xaver2.pdb -dir rmsf_step710.log

gmx traj -f step7_10.trr -s step7_1.tpr -ox coordtraj_step711.xvg -ov velotraj_step711.xvg -of forcetraj_step711.xvg -cv velotraj_step711.pdb -cf forcetraj_step711.pdb 
gmx traj -f step7_10.trr -s step7_10.tpr -ox coordtraj_step710.xvg -ov velodtraj_step710.xvg -of forcetraj_step710.xvg -cv velotraj_step710.pdb -cf forcetraj_step710.pdb 
