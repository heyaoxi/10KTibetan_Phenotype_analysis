#!/bin/bash

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do

cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.rinfo | wc -l >>count.clean.age_filter.data.rls
cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.altitude.rls
cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.altitude.rls
cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.male.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.male.altitude.rls
cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.female.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.female.altitude.rls
cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.TBN.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.TBN.altitude.rls
cat Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.nonTBN.rinfo | grep -v 'Altitude' | awk '{print $1}' | sort | uniq | wc -l >>count.clean.age_filter.exOutliers.nonTBN.altitude.rls
done
