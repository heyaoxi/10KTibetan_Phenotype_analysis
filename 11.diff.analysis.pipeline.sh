#!/bin/sh

for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do 
    for att in `cat group.list`;do

##### calcu diff P-value by lm and calcu adj-AVG by acova
        cat Altitude-Sex-Eth-${phen}.clean.age_filter.exOutliers.byTnT.grouped.rinfo | grep -E "Altitude|$att" >${phen}.${att}
				Rscript ${phen}.lm.r ${phen}.${att} >${phen}.${att}.lm.tmp
				
				echo "#${phen} ${att}" >>${phen}.all.altitude.lm
				cat ${phen}.${att}.lm.tmp | grep EthnicityTBN >>${phen}.all.altitude.lm
				cat ${phen}.${att}.lm.tmp | tail -1 >>${phen}.all.altitude.lm
				
				for eth in TBN nonTBN;do
##### calculate avarage of sd of phenotype
            echo "#$att" >>${phen}.all.altitude.${eth}.value.sd.tmp
						awk '{if($4=="'${eth}'")print}' ${phen}.${att} | awk '{x[NR]=$5;s+=$5; n++} END{a=s/n; for (i in x){ss += (x[i]-a)^2} sd = sqrt(ss/n); printf("%.2f", sd)}' >>${phen}.all.altitude.${eth}.value.sd.tmp
						cat ${phen}.all.altitude.${eth}.value.sd.tmp | tr '\n' ' ' | tr '#' '\n' | sed '/^$/d' | awk '{if($2=="")print"NA";else print $2}' >${phen}.all.altitude.${eth}.value.sd

##### count sample size
            awk '{if($4=="'${eth}'")print}' ${phen}.${att} | wc -l >>${phen}.all.altitude.${eth}.counts
        done
    done
done

######################################################## 
for phen in `cat /gpfs/home/heyaoxi/analysis/metabolism_tibetans/pheno.list`;do 
    cat ${phen}.all.altitude.lm | tr '\n' ' ' | tr '#' '\n' | grep -v '^$' | awk '{if($3=="")print $1, $2, "NA NA NA NA NA NA NA";else print $0}' >${phen}.all.altitude.lm2
    paste ${phen}.all.altitude.lm2 ${phen}.all.altitude.nonTBN.value.sd ${phen}.all.altitude.TBN.value.sd ${phen}.all.altitude.nonTBN.counts ${phen}.all.altitude.TBN.counts | sed -r 's/\s+/,/g' >${phen}.all.altitude.rls.csv

############################# multiple test
    echo "altitude Raw.p" >${phen}.all.altitude.rawp
    awk -F ',' '{print $2, $7}' ${phen}.all.altitude.rls.csv >>${phen}.all.altitude.rawp
    Rscript multiple.test.r ${phen}.all.altitude.rawp ${phen}.all.altitude.adjp.tmp
    cat ${phen}.all.altitude.adjp.tmp | grep -v altitude | sort -nk1 | awk '{print $3}' >${phen}.all.altitude.adjp
    paste ${phen}.all.altitude.rls.csv ${phen}.all.altitude.adjp | sed 's/\t/,/g' >${phen}.all.altitude.rls.adj.csv
    echo "${phen},${phen},${phen},${phen},${phen},${phen},${phen},${phen},${phen}" >${phen}.all.altitude.rls.adj.csv.tmp
    cat ${phen}.all.altitude.rls.adj.csv | awk -F ',' '{print $4,$7,$14,$9,$11,$13,$8,$10,$12}' | sed 's/ /,/g' >>${phen}.all.altitude.rls.adj.csv.tmp
done

rm *0
