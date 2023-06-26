#!/bin/sh

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens/lm_version

#cp ../batch.lm.com.sh ./
#sh batch.lm.com.sh

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
Rscript ${phen}.lm.com.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.rinfo ${phen}.com.lm ${phen}.com.r2

tail -4 ${phen}.com.lm | awk '{print $1, $2, $5}' >${phen}.com.tmp
tail -1 ${phen}.com.r2 >${phen}.com.tmp2

echo "#$phen" >>allphen.com.lm.tmp
cat ${phen}.com.tmp ${phen}.com.tmp2 | tr '\n' ' ' >>allphen.com.lm.tmp
echo "" >>allphen.com.lm.tmp

rm ${phen}.com.tmp ${phen}.com.tmp2 ${phen}.com.lm ${phen}.com.r2
done

cat allphen.com.lm.tmp | tr '\n' ' ' | tr '#' '\n' >allphen.com.lm.rls
rm allphen.com.lm.tmp
