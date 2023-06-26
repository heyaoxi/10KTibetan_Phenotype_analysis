#!/bin/bash

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens/cor_version

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | grep -v 'nonTBN' >../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.TBN.rinfo
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | grep -E 'Ethnicity|nonTBN' >../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.nonTBN.rinfo
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.TBN.rinfo | wc -l >>count.clean.age_filter.exOutliers.data.TBN.rls
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.nonTBN.rinfo | wc -l >>count.clean.age_filter.exOutliers.data.nonTBN.rls
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.TBN.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.altitude.TBN.rls
		cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.nonTBN.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.altitude.nonTBN.rls
		Rscript calcu.cor.Altitude-${phen}.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.TBN.rinfo ${phen}.clean.age_filter.exOutliers.TBN.cor
		Rscript calcu.cor.Altitude-${phen}.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.nonTBN.rinfo ${phen}.clean.age_filter.exOutliers.nonTBN.cor
		cat ${phen}.clean.age_filter.exOutliers.TBN.cor | tail -1 | awk '{print $1, $2, $4, $6, $8}' >>allphen.clean.age_filter.exOutliers.TBN.cor
		cat ${phen}.clean.age_filter.exOutliers.nonTBN.cor | tail -1 | awk '{print $1, $2, $4, $6, $8}' >>allphen.clean.age_filter.exOutliers.nonTBN.cor
done

for eth in TBN nonTBN;do
    perl /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pick.better.cor.pl allphen.clean.age_filter.exOutliers.${eth}.cor allphen.clean.age_filter.exOutliers.${eth}.cor2
		sed 's/ /,/g' allphen.clean.age_filter.exOutliers.${eth}.cor2 >allphen.clean.age_filter.exOutliers.${eth}.cor2.csv
done
