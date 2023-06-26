#!/bin/sh

cd /gpfs/home/heyaoxi/analysis/metabolism_tibetans/120.att2phens/lm_version

#cp ../batch.lm.splitSex.sh ./
#sh batch.lm.splitSex.sh

for sex in male female;do

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do
Rscript ${phen}.lm.splitSex.r ../Altitude-Age-Sex-Eth-${phen}.clean.age_filter.exOutliers.${sex}.rinfo ${phen}.${sex}.lm ${phen}.${sex}.r2

tail -3 ${phen}.${sex}.lm | awk '{print $1, $2, $5}' >${phen}.${sex}.tmp
tail -1 ${phen}.${sex}.r2 >${phen}.${sex}.tmp2

echo "#$phen" >>allphen.${sex}.lm.tmp
cat ${phen}.${sex}.tmp ${phen}.${sex}.tmp2 | tr '\n' ' ' >>allphen.${sex}.lm.tmp
echo "" >>allphen.${sex}.lm.tmp

rm ${phen}.${sex}.tmp ${phen}.${sex}.tmp2 ${phen}.${sex}.lm ${phen}.${sex}.r2
done

cat allphen.${sex}.lm.tmp | tr '\n' ' ' | tr '#' '\n' >allphen.${sex}.lm.rls
rm allphen.${sex}.lm.tmp

done
