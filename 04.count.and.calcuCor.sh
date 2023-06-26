#!/bin/bash

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens/cor_version

cp ../batch.calcu.cor.sh ./
sh batch.calcu.cor.sh

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | wc -l >>count.clean.age_filter.exOutliers.data.rls
    Rscript calcu.cor.Altitude-${phen}.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo ${phen}.clean.age_filter.exOutliers.cor
    cat ${phen}.clean.age_filter.exOutliers.cor | tail -1 | awk '{print $1, $2, $4, $6, $8}' >>allphen.clean.age_filter.exOutliers.cor
    cat ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.altitude.rls
done

perl /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pick.better.cor.pl allphen.clean.age_filter.exOutliers.cor allphen.clean.age_filter.exOutliers.cor2
sed 's/ /,/g' allphen.clean.age_filter.exOutliers.cor2 >allphen.clean.age_filter.exOutliers.cor2.csv
