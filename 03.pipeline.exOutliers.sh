#!/bin/bash

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do

#for i in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/altitude.list`;do
#cat Altitude-Age-Sex-Eth-${phen}.clean.splitHan.age_filter.rinfo | grep "$i" | awk '{x[NR]=$5; s+=$5; n++} END{a=s/n; for (i in x){ss += (x[i]-a)^2} sd = sqrt(ss/n); print "'$i' "s/NR-3*sd, s/NR+3*sd}' >>${phen}.avg-sd
#done

perl /gpfs/home/heyaoxi/analysis/metabolism_tibetans/add.3sd.pl ${phen}.avg-sd Altitude-Age-Sex-Eth-${phen}.clean.splitHan.age_filter.rinfo Altitude-Age-Sex-Eth-${phen}.clean.splitHan.age_filter.add3sd

cat Altitude-Age-Sex-Eth-${phen}.clean.splitHan.age_filter.add3sd | awk '{if($5>$6 && $5<$7 || $1=="Altitude")print $1, $2, $3, $4, $5}' >Altitude-Age-Sex-Eth-${phen}.clean.splitHan.age_filter.exOutliers.rinfo

done
