#!/bin/bash

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens/cor_version

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | grep -E 'Sex|Male' >../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.male.rinfo
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | grep -E 'Sex|Female' >../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.female.rinfo
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.male.rinfo | wc -l >>count.clean.age_filter.exOutliers.data.male.rls
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.female.rinfo | wc -l >>count.clean.age_filter.exOutliers.data.female.rls
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.male.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.altitude.male.rls
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.female.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.altitude.female.rls
		Rscript calcu.cor.Altitude-${phen}.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.male.rinfo ${phen}.clean.age_filter.exOutliers.male.cor
		Rscript calcu.cor.Altitude-${phen}.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.female.rinfo ${phen}.clean.age_filter.exOutliers.female.cor
		cat ${phen}.clean.age_filter.exOutliers.male.cor | tail -1 | awk '{print $1, $2, $4, $6, $8}' >>allphen.clean.age_filter.exOutliers.male.cor
		cat ${phen}.clean.age_filter.exOutliers.female.cor | tail -1 | awk '{print $1, $2, $4, $6, $8}' >>allphen.clean.age_filter.exOutliers.female.cor
done

for sex in male female;do
    perl /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pick.better.cor.pl allphen.clean.age_filter.exOutliers.${sex}.cor allphen.clean.age_filter.exOutliers.${sex}.cor2
    sed 's/ /,/g' allphen.clean.age_filter.exOutliers.${sex}.cor2 >allphen.clean.age_filter.exOutliers.${sex}.cor2.csv
done
