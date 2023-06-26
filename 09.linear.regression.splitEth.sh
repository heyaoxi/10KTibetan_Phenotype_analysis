#!/bin/sh

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens/lm_version

#cp ../batch.lm.splitEth.sh ./
#sh batch.lm.splitEth.sh

for eth in TBN nonTBN;do
for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
Rscript ${phen}.lm.splitEth.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.${eth}.rinfo ${phen}.${eth}.lm ${phen}.${eth}.r2

tail -3 ${phen}.${eth}.lm | awk '{print $1, $2, $5}' >${phen}.${eth}.tmp
tail -1 ${phen}.${eth}.r2 >${phen}.${eth}.tmp2

echo "#$phen" >>allphen.${eth}.lm.tmp
cat ${phen}.${eth}.tmp ${phen}.${eth}.tmp2 | tr '\n' ' ' >>allphen.${eth}.lm.tmp
echo "" >>allphen.${eth}.lm.tmp

rm ${phen}.${eth}.tmp ${phen}.${eth}.tmp2 ${phen}.${eth}.lm ${phen}.${eth}.r2
done

cat allphen.${eth}.lm.tmp | tr '\n' ' ' | tr '#' '\n' >allphen.${eth}.lm.rls
rm allphen.${eth}.lm.tmp
done
